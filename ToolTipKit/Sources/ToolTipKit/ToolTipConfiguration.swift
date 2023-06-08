//
//  ToolTipConfiguration.swift
//
//
//  Created by Sinan KÜLEN on 9.05.2023.
//
import Foundation
import UIKit

/// The `ToolTipConfiguration` protocol defines a set of properties that can be used to configure the appearance of a
/// tooltip.
public protocol ToolTipConfiguration {
    var textFont: UIFont { get set }
    var textColor: UIColor { get set }
    var isShowView: Bool { get set }
    var toolTipBacgroundColor: UIColor { get set }
    var toolTipCornerRadius: CGFloat { get set }
    var toolTipViewPadding: CGFloat { get set }
    var triangleSize: CGSize { get set }
    var toolTipLabelEdgeInsets: UIEdgeInsets { get set }
    var toolTipLeadingPadding: CGFloat { get set }
    var toolTipTrailingPadding: CGFloat { get set }
    var tooltipSpacerConstant: CGFloat { get set }
    var letterSpacingText: CGFloat { get set }
    var lineHeigtText: CGFloat { get set }
}

/// `ToolTipConfig` is a struct that implements the `ToolTipConfiguration` protocol, providing default values for
/// tooltip configuration properties.
public struct ToolTipConfig: ToolTipConfiguration {
    ///  The font used for the tooltip text.
    public var textFont: UIFont
    /// The color of the tooltip text.
    public var textColor: UIColor
    /// A Boolean value that determines whether to show the tooltip view.
    public var isShowView: Bool
    /// The background color of the tooltip view.
    public var toolTipBacgroundColor: UIColor
    /// The corner radius of the tooltip view.
    public var toolTipCornerRadius: CGFloat
    /// The padding around the tooltip view.
    public var toolTipViewPadding: CGFloat
    /// The size of the triangle on the tooltip view.
    public var triangleSize: CGSize
    /// The edge insets of the tooltip label.
    public var toolTipLabelEdgeInsets: UIEdgeInsets
    /// The leading padding of the tooltip view.
    public var toolTipLeadingPadding: CGFloat
    /// The trailing padding of the tooltip view.
    public var toolTipTrailingPadding: CGFloat
    /// The constant used for the safe area between tooltip space.
    public var tooltipSpacerConstant: CGFloat
    /// The letter spacing of the tooltip text.
    public var letterSpacingText: CGFloat
    /// The line height of the tooltip text.
    public var lineHeigtText: CGFloat

    public init(
        textFont: UIFont = UIFont.systemFont(ofSize: 14),
        textColor: UIColor = .black,
        isShowView: Bool = false,
        toolTipBacgroundColor: UIColor = .black.withAlphaComponent(0.7),
        toolTipCornerRadius: CGFloat = 4.0,
        toolTipViewPadding: CGFloat = 10.0,
        triangleSize: CGSize = CGSize(width: 22.0, height: 11.0),
        toolTipLabelEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0),
        toolTipLeadingPadding: CGFloat = 16.0,
        toolTipTrailingPadding: CGFloat = 16.0,
        tooltipSpacerConstant: CGFloat = 150.0,
        letterSpacingText: CGFloat = 0.25,
        lineHeigtText: CGFloat = 20.0
    ) {
        self.textFont = textFont
        self.textColor = textColor
        self.isShowView = isShowView
        self.toolTipBacgroundColor = toolTipBacgroundColor
        self.toolTipCornerRadius = toolTipCornerRadius
        self.toolTipViewPadding = toolTipViewPadding
        self.triangleSize = triangleSize
        self.toolTipLabelEdgeInsets = toolTipLabelEdgeInsets
        self.toolTipLeadingPadding = toolTipLeadingPadding
        self.toolTipTrailingPadding = toolTipTrailingPadding
        self.tooltipSpacerConstant = tooltipSpacerConstant
        self.letterSpacingText = letterSpacingText
        self.lineHeigtText = lineHeigtText
    }
}
