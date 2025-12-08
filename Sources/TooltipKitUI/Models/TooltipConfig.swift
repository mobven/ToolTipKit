//
//  TooltipConfig.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A configuration structure that defines the appearance, layout, and behavior of a tooltip.
///
/// `TooltipConfig` encapsulates all customizable properties for tooltips, including typography,
/// spacing, colors, dimensions, and arrow direction. This allows for consistent tooltip styling
/// across the application while providing flexibility for customization.
///
/// - Note: This struct is available on iOS 14.0 and later.
@available(iOS 14.0, *)
public struct TooltipConfig {
    /// A unique identifier for this tooltip configuration.
    public let id: String
    
    /// The primary text displayed at the top of the tooltip.
    public let title: String
    
    /// The secondary descriptive text displayed below the title.
    public let description: String
    
    /// An identifier for the target view element that this tooltip is associated with.
    public let targetId: String
    
    /// The direction in which the tooltip arrow points relative to the target element.
    ///
    /// Defaults to `.top`, indicating the arrow points upward.
    public var arrowDirection: ArrowDirection = .top
    
    /// The corner radius used for highlighting the target element's rounded rectangle.
    ///
    /// This value affects the visual appearance of the overlay mask that highlights
    /// the target element when a tooltip is displayed.
    public var highlightCornerRadius: CGFloat = 8
    
    // MARK: - Typography
    
    /// The font used for rendering the tooltip title text.
    ///
    /// Defaults to a system font of size 12 points.
    public var titleFont: Font = .system(size: 12)
    
    /// The font used for rendering the tooltip description text.
    ///
    /// Defaults to a system font of size 12 points.
    public var descriptionFont: Font = .system(size: 12)
    
    /// The text color used for the tooltip title.
    ///
    /// Defaults to black.
    public var titleColor: Color = .black
    
    /// The text color used for the tooltip description.
    ///
    /// Defaults to gray.
    public var descriptionColor: Color = .gray
    
    // MARK: - Layout
    
    /// The width of the tooltip bubble in points.
    ///
    /// The actual rendered width may be adjusted to fit within the container bounds.
    /// Defaults to 350 points.
    public var tooltipWidth: CGFloat = 350
    
    /// The vertical spacing between the title and description text.
    ///
    /// Defaults to 16 points.
    public var spacing: CGFloat = 16
    
    /// The padding applied around the title text.
    ///
    /// Defaults to 16 points on top and leading, 0 on bottom and trailing.
    public var titlePadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
    
    /// The padding applied around the description text.
    ///
    /// Defaults to 32 points on leading, bottom, and trailing edges, 0 on top.
    public var descriptionPadding: EdgeInsets = EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 32)
    
    // MARK: - Appearance
    
    /// The background color of the tooltip bubble.
    ///
    /// Defaults to white.
    public var backgroundColor: Color = .white
    
    /// The blur radius of the shadow applied to the tooltip bubble.
    ///
    /// Defaults to 10 points. A value of 0 disables the shadow.
    public var shadowRadius: CGFloat = 10
    
    /// The corner radius of the tooltip bubble's rounded rectangle.
    ///
    /// Defaults to 8 points. This does not affect the arrow shape.
    public var cornerRadius: CGFloat = 8
    
    /// Creates a new tooltip configuration with the specified parameters.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for this tooltip configuration.
    ///   - title: The primary text displayed at the top of the tooltip.
    ///   - description: The secondary descriptive text displayed below the title.
    ///   - targetId: An identifier for the target view element associated with this tooltip.
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
    public init(
        id: String,
        title: String,
        description: String,
        targetId: String,
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
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.targetId = targetId
        self.arrowDirection = arrowDirection
        self.highlightCornerRadius = highlightCornerRadius
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
        self.tooltipWidth = tooltipWidth
        self.spacing = spacing
        self.titlePadding = titlePadding
        self.descriptionPadding = descriptionPadding
        self.backgroundColor = backgroundColor
        self.shadowRadius = shadowRadius
        self.cornerRadius = cornerRadius
    }
}

/// Defines the direction in which a tooltip arrow points relative to its target element.
///
/// The arrow direction determines where the tooltip bubble appears in relation to the
/// highlighted target view. The system may automatically adjust this based on available
/// screen space.
public enum ArrowDirection: Sendable {
    /// The arrow points upward, with the tooltip bubble positioned below the target element.
    case top
    
    /// The arrow points downward, with the tooltip bubble positioned above the target element.
    case bottom
}
