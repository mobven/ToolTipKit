//
//  TooltipModifier.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A view modifier that attaches tooltip functionality to any SwiftUI view.
///
/// `TooltipModifier` enables any view to display a tooltip by monitoring its presentation state
/// and communicating its frame information up the view hierarchy via preference values. When
/// `isPresented` becomes `true`, the modifier registers the view's geometry and tooltip
/// configuration with the parent `TooltipContainer`.
///
/// The modifier uses a stable ID to prevent unnecessary re-creation of tooltip configurations
/// when the view updates, ensuring smooth animations and consistent behavior.
///
/// - Note: This struct is available on iOS 14.0 and later.
@available(iOS 14.0, *)
struct TooltipModifier: ViewModifier {
    /// A binding that controls whether the tooltip is currently presented.
    @Binding var isPresented: Bool
    
    /// The configuration that defines the tooltip's appearance and content.
    let config: TooltipConfig
    
    /// The tooltip manager obtained from the environment, used to coordinate dismissal.
    @EnvironmentObject var manager: TooltipManager
    
    /// A stable unique identifier for this tooltip instance.
    ///
    /// This ID persists across view updates to ensure the tooltip is recognized as the same
    /// instance, preventing unnecessary re-renders and maintaining smooth transitions.
    @State private var stableId = UUID().uuidString

    /// Applies the tooltip modifier to the content view.
    ///
    /// This method wraps the content with a geometry reader to capture the view's frame
    /// in global coordinates, then uses preference values to communicate tooltip data to
    /// parent containers. It also registers dismissal actions with the tooltip manager.
    ///
    /// - Parameter content: The view content to which the tooltip modifier is applied.
    /// - Returns: A modified view that supports tooltip display functionality.
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
    /// Adds a tooltip to the view that appears when the binding becomes `true`.
    ///
    /// This convenience method creates a tooltip modifier with the specified configuration
    /// and applies it to the view. The tooltip will be displayed when `isPresented` is `true`,
    /// and can be dismissed by tapping the overlay or calling the manager's `dismiss()` method.
    ///
    /// The tooltip must be used within a `TooltipContainer` to function properly, as the
    /// container is responsible for rendering the tooltip overlay and managing its presentation.
    ///
    /// - Parameters:
    ///   - isPresented: A binding that controls the tooltip's presentation state.
    ///   - title: The primary text displayed at the top of the tooltip.
    ///   - description: The secondary descriptive text displayed below the title.
    ///   - arrowDirection: The direction in which the tooltip arrow points. Defaults to `.top`.
    ///   - highlightCornerRadius: The corner radius for the target element highlight. Defaults to 8.
    ///   - titleFont: The font for the title text. Defaults to system font size 12.
    ///   - descriptionFont: The font for the description text. Defaults to system font size 12.
    ///   - titleColor: The text color for the title. Defaults to black.
    ///   - descriptionColor: The text color for the description. Defaults to gray.
    ///   - tooltipWidth: The width of the tooltip bubble in points. Defaults to 350.
    ///   - spacing: The vertical spacing between title and description. Defaults to 16.
    ///   - titlePadding: The padding around the title text. Defaults to 16/16/0/16.
    ///   - descriptionPadding: The padding around the description text. Defaults to 0/32/32/32.
    ///   - backgroundColor: The background color of the tooltip bubble. Defaults to white.
    ///   - shadowRadius: The blur radius of the tooltip shadow. Defaults to 10.
    ///   - cornerRadius: The corner radius of the tooltip bubble. Defaults to 8.
    /// - Returns: A view modified with tooltip functionality.
    ///
    /// ## Example
    /// ```swift
    /// @State private var showTooltip = false
    ///
    /// Button("Tap me") {
    ///     showTooltip = true
    /// }
    /// .tooltip(isPresented: $showTooltip,
    ///          title: "Welcome",
    ///          description: "This is a helpful tooltip")
    /// ```
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
