//
//  TooltipView.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A view that displays the visual content of a tooltip bubble.
///
/// `TooltipView` renders the title and description text within a styled container that includes
/// a custom shape background with an arrow. The view applies typography, spacing, and padding
/// according to the provided configuration, and positions the arrow based on the specified ratio.
///
/// This view is used internally by `TooltipOverlay` to render the actual tooltip content
/// and should not be instantiated directly by users of the framework.
///
/// - Note: This struct is available on iOS 14.0 and later.
@available(iOS 14.0, *)
struct TooltipView: View {
    /// The configuration object that defines the tooltip's appearance, content, and layout.
    let config: TooltipConfig
    
    /// The horizontal position of the arrow as a ratio of the tooltip's width.
    ///
    /// Values range from 0.0 (left edge) to 1.0 (right edge). This ratio is used to position
    /// the arrow so it points at the target element's center.
    let arrowPosition: CGFloat

    /// The body of the tooltip view.
    ///
    /// This view renders a vertical stack containing the title and description text, applies
    /// custom styling and padding, and wraps everything in a `TooltipShape` background with
    /// shadow effects. The view includes padding to accommodate the arrow direction.
    var body: some View {
        VStack(alignment: .center, spacing: config.spacing) {
            Text(config.title)
                .font(config.titleFont)
                .foregroundColor(config.titleColor)
                .multilineTextAlignment(.center)
                .padding(config.titlePadding)

            Text(config.description)
                .font(config.descriptionFont)
                .foregroundColor(config.descriptionColor)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(config.descriptionPadding)
        }
        .frame(width: config.tooltipWidth)
        .padding(.top, config.arrowDirection == .top ? 9 : 0)
        .padding(.bottom, config.arrowDirection == .bottom ? 9 : 0)
        .background(
            TooltipShape(arrowPosition: arrowPosition, direction: config.arrowDirection)
                .fill(config.backgroundColor)
                .shadow(radius: config.shadowRadius)
        )
        .onTapGesture {}
    }
}
