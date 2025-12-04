//
//  TooltipView.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TooltipView: View {
    let config: TooltipConfig
    let arrowPosition: CGFloat

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
