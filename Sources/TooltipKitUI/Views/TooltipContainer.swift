//
//  TooltipContainer.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A container view that manages tooltip presentation and overlay rendering.
///
/// `TooltipContainer` serves as the root coordinator for tooltip functionality in a view hierarchy.
/// It provides a `TooltipManager` instance to child views via the environment, collects tooltip
/// preference data from descendant views, and renders the tooltip overlay when a tooltip is active.
///
/// The container creates a dimmed overlay with a highlighted cutout around the target view,
/// and positions the tooltip bubble relative to the target element. Users can dismiss tooltips
/// by tapping anywhere on the overlay.
///
/// - Note: All views that use the `.tooltip()` modifier must be wrapped in a `TooltipContainer`.
/// - Note: This struct is available on iOS 14.0 and later.
///
/// ## Example
/// ```swift
/// TooltipContainer {
///     YourContentView()
/// }
/// ```
@available(iOS 14.0, *)
public struct TooltipContainer<Content: View>: View {
    /// The tooltip manager instance that coordinates dismissal across the hierarchy.
    ///
    /// This manager is provided to child views via `environmentObject` and enables
    /// centralized control of tooltip lifecycle.
    @StateObject private var manager = TooltipManager()
    
    /// The content view builder that defines the view hierarchy to display.
    @ViewBuilder let content: Content

    /// The currently active tooltip data, if any tooltip is being presented.
    ///
    /// This state is updated when preference values change, triggering the overlay to appear.
    @State private var activeTooltipData: TooltipPreferenceData?
    
    /// Creates a new tooltip container with the specified content.
    ///
    /// - Parameter content: A view builder closure that returns the content to display.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    /// The body of the container view.
    ///
    /// This view renders the content hierarchy and overlays the tooltip UI (dimmed background,
    /// highlight cutout, and tooltip bubble) when a tooltip is active. The overlay is dismissed
    /// when users tap on it or when the manager's `dismiss()` method is called.
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
