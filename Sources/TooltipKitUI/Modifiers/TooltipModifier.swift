//
//  TooltipModifier.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TooltipModifier: ViewModifier {
    @Binding var isPresented: Bool
    let config: TooltipConfig
    @EnvironmentObject var manager: TooltipManager
    @State private var stableId = UUID().uuidString

    func body(content: Content) -> some View {
        let stableConfig = TooltipConfig(
            id: stableId,
            title: config.title,
            description: config.description,
            targetId: config.targetId,
            arrowDirection: config.arrowDirection,
            highlightCornerRadius: config.highlightCornerRadius,
            titleFont: config.titleFont,
            descriptionFont: config.descriptionFont,
            titleColor: config.titleColor,
            descriptionColor: config.descriptionColor,
            tooltipWidth: config.tooltipWidth,
            spacing: config.spacing,
            titlePadding: config.titlePadding,
            descriptionPadding: config.descriptionPadding,
            backgroundColor: config.backgroundColor,
            shadowRadius: config.shadowRadius,
            cornerRadius: config.cornerRadius
        )

        return content
            .background(
                GeometryReader { geo in
                    let globalFrame = geo.frame(in: .global)
                    Color.clear
                        .preference(
                            key: TooltipPreferenceKey.self,
                            value: isPresented ? TooltipPreferenceData(
                                config: stableConfig,
                                frame: globalFrame
                            ) : nil
                        )
                }
            )
            .onChange(of: isPresented) { newValue in
                if newValue {
                    manager.register {
                        isPresented = false
                    }
                }
            }
            .onAppear {
                if isPresented {
                    manager.register {
                        isPresented = false
                    }
                }
            }
    }
}

@available(iOS 14.0, *)
extension View {
    public func tooltip(
        isPresented: Binding<Bool>,
        title: String,
        description: String,
        arrowDirection: ArrowDirection = .top,
        highlightCornerRadius: CGFloat = 8,
        titleFont: Font = .system(size: 12),
        descriptionFont: Font = .system(size: 12),
        titleColor: Color = .black,
        descriptionColor: Color = .gray,
        tooltipWidth: CGFloat = 350,
        spacing: CGFloat = 16,
        titlePadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16),
        descriptionPadding: EdgeInsets = EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 32),
        backgroundColor: Color = .white,
        shadowRadius: CGFloat = 10,
        cornerRadius: CGFloat = 8
    ) -> some View {
        modifier(TooltipModifier(
            isPresented: isPresented,
            config: TooltipConfig(
                id: UUID().uuidString,
                title: title,
                description: description,
                targetId: "",
                arrowDirection: arrowDirection,
                highlightCornerRadius: highlightCornerRadius,
                titleFont: titleFont,
                descriptionFont: descriptionFont,
                titleColor: titleColor,
                descriptionColor: descriptionColor,
                tooltipWidth: tooltipWidth,
                spacing: spacing,
                titlePadding: titlePadding,
                descriptionPadding: descriptionPadding,
                backgroundColor: backgroundColor,
                shadowRadius: shadowRadius,
                cornerRadius: cornerRadius
            )
        ))
    }
}
