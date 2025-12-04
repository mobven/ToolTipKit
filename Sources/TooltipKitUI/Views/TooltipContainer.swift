//
//  TooltipContainer.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct TooltipContainer<Content: View>: View {
    @StateObject private var manager = TooltipManager()
    @ViewBuilder let content: Content

    @State private var activeTooltipData: TooltipPreferenceData?
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ZStack {
            content
                .environmentObject(manager)
                .onPreferenceChange(TooltipPreferenceKey.self) { preferenceData in
                    activeTooltipData = preferenceData
                }

            if let tooltipData = activeTooltipData {
                ZStack {
                    Color(.gray).opacity(0.8)
                        .mask(
                            ZStack {
                                Rectangle().fill(Color.white)

                                RoundedRectangle(cornerRadius: tooltipData.config.highlightCornerRadius)
                                    .frame(width: tooltipData.frame.width, height: tooltipData.frame.height)
                                    .position(x: tooltipData.frame.midX, y: tooltipData.frame.midY)
                                    .blendMode(.destinationOut)
                            }
                            .compositingGroup()
                        )
                        .ignoresSafeArea()
                        .onTapGesture {
                            manager.dismiss()
                        }

                    TooltipOverlay(
                        tooltip: tooltipData.config,
                        targetFrame: tooltipData.frame,
                        containerSize: UIScreen.main.bounds.size
                    )
                    .ignoresSafeArea()
                    .onTapGesture {
                        manager.dismiss()
                    }
                }
                .id(tooltipData.config.id)
                .transition(.opacity.animation(.easeInOut(duration: 0.2)))
            }
        }
    }
}
