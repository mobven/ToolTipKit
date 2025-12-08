//
//  TooltipOverlay.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A view that positions and renders a tooltip bubble relative to a target element.
///
/// `TooltipOverlay` is responsible for calculating the optimal position for the tooltip bubble
/// based on available screen space, the target element's frame, and the tooltip's configuration.
/// It automatically determines whether to place the tooltip above or below the target, adjusts
/// horizontal positioning to keep the tooltip within screen bounds, and calculates the arrow
/// position to point at the target element's center.
///
/// The overlay handles edge cases such as insufficient space and ensures the tooltip remains
/// fully visible and properly aligned with its target.
///
/// - Note: This struct is available on iOS 14.0 and later.
@available(iOS 14.0, *)
struct TooltipOverlay: View {
    /// The configuration that defines the tooltip's appearance and content.
    let tooltip: TooltipConfig
    
    /// The frame rectangle of the target view in global coordinate space.
    let targetFrame: CGRect
    
    /// The size of the container view, used for bounds checking and positioning calculations.
    let containerSize: CGSize

    /// The measured size of the tooltip content, used for accurate positioning.
    ///
    /// This state is updated when the tooltip view's geometry changes, allowing the overlay
    /// to position the tooltip correctly relative to the target element.
    @State private var contentSize: CGSize = .zero

    /// The body of the overlay view.
    ///
    /// This view calculates the optimal tooltip position, adjusts the configuration based on
    /// available space, and renders the tooltip bubble with the correct arrow positioning.
    ///
    /// Positioning logic:
    /// - Determines arrow direction based on available space (prefers space below if > 200pt)
    /// - Calculates horizontal center aligned with target, with edge constraints
    /// - Computes arrow position as a ratio of tooltip width for proper pointing
    var body: some View {
        let minX: CGFloat = 8
        let maxAvailableWidth = containerSize.width - (minX * 2)
        let tooltipWidth = min(tooltip.tooltipWidth, maxAvailableWidth)
        let spaceBelow = containerSize.height - targetFrame.maxY
        let renderBelow = spaceBelow > 200

        let direction: ArrowDirection = renderBelow ? .top : .bottom

        let targetCenterX = targetFrame.midX

        var tooltipCenterX = targetCenterX
        var tooltipX = tooltipCenterX - (tooltipWidth / 2)

        let maxX = containerSize.width - tooltipWidth - minX

        if tooltipX < minX {
            tooltipX = minX
            tooltipCenterX = tooltipX + (tooltipWidth / 2)
        } else if tooltipX > maxX {
            tooltipX = maxX
            tooltipCenterX = tooltipX + (tooltipWidth / 2)
        }

        let arrowX = targetCenterX - tooltipX

        let arrowRatio = arrowX / tooltipWidth

        let updatedConfig = TooltipConfig(
            id: tooltip.id,
            title: tooltip.title,
            description: tooltip.description,
            targetId: tooltip.targetId,
            arrowDirection: direction,
            highlightCornerRadius: tooltip.highlightCornerRadius,
            titleFont: tooltip.titleFont,
            descriptionFont: tooltip.descriptionFont,
            titleColor: tooltip.titleColor,
            descriptionColor: tooltip.descriptionColor,
            tooltipWidth: tooltipWidth,
            spacing: tooltip.spacing,
            titlePadding: tooltip.titlePadding,
            descriptionPadding: tooltip.descriptionPadding,
            backgroundColor: tooltip.backgroundColor,
            shadowRadius: tooltip.shadowRadius,
            cornerRadius: tooltip.cornerRadius
        )

        return TooltipView(
            config: updatedConfig,
            arrowPosition: arrowRatio
        )
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        contentSize = geo.size
                    }
                    .onChange(of: geo.size) { newSize in
                        contentSize = newSize
                    }
            }
        )
        .position(
            x: tooltipCenterX,
            y: renderBelow
                ? targetFrame.maxY + 10 + (contentSize.height / 2)
                : targetFrame.minY - 10 - (contentSize.height / 2)
        )
    }
}
