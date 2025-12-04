//
//  TooltipOverlay.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TooltipOverlay: View {
    let tooltip: TooltipConfig
    let targetFrame: CGRect
    let containerSize: CGSize

    @State private var contentSize: CGSize = .zero

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
