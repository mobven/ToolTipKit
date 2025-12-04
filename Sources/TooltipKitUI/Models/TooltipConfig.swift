//
//  TooltipConfig.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct TooltipConfig {
    public let id: String
    public let title: String
    public let description: String
    public let targetId: String
    public var arrowDirection: ArrowDirection = .top
    public var highlightCornerRadius: CGFloat = 8
    
    // Typography
    public var titleFont: Font = .system(size: 12)
    public var descriptionFont: Font = .system(size: 12)
    public var titleColor: Color = .black
    public var descriptionColor: Color = .gray
    
    // Layout
    public var tooltipWidth: CGFloat = 350
    public var spacing: CGFloat = 16
    public var titlePadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
    public var descriptionPadding: EdgeInsets = EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 32)
    
    // Appearance
    public var backgroundColor: Color = .white
    public var shadowRadius: CGFloat = 10
    public var cornerRadius: CGFloat = 8
    
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

public enum ArrowDirection: Sendable {
    case top
    case bottom
}
