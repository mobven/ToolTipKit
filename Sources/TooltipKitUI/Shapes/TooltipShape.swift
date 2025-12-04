//
//  TooltipShape.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A custom shape that draws a tooltip bubble with a triangular arrow.
///
/// `TooltipShape` creates a rounded rectangle with an arrow pointing in a specified direction.
/// The arrow can be positioned at any horizontal location along the tooltip's edge, allowing
/// precise alignment with target elements. The shape supports both top and bottom arrow directions
/// and includes corner radius support for smooth, modern aesthetics.
///
/// The shape is used as the background for tooltip views, providing the visual container
/// that distinguishes tooltips from regular views.
///
/// - Note: This struct is available on iOS 14.0 and later.
@available(iOS 14.0, *)
struct TooltipShape: Shape {
    /// The height of the arrow triangle in points.
    ///
    /// Defaults to 9 points. This determines how far the arrow extends from the tooltip body.
    var arrowHeight: CGFloat = 9
    
    /// The width of the arrow triangle at its base in points.
    ///
    /// Defaults to 18 points. This determines the width of the arrow's base.
    var arrowWidth: CGFloat = 18
    
    /// The corner radius of the rounded rectangle body in points.
    ///
    /// Defaults to 8 points. This value is applied to all four corners of the tooltip bubble.
    var cornerRadius: CGFloat = 8
    
    /// The horizontal position of the arrow as a ratio of the tooltip's width.
    ///
    /// Values range from 0.0 (left edge) to 1.0 (right edge), with 0.5 being centered.
    /// The arrow position is calculated to point at the target element's center.
    var arrowPosition: CGFloat = 0.5
    
    /// The direction in which the arrow points relative to the tooltip body.
    ///
    /// `.top` indicates the arrow points upward (tooltip below target),
    /// `.bottom` indicates the arrow points downward (tooltip above target).
    var direction: ArrowDirection = .top

    /// Creates the path for the tooltip shape within the given rectangle.
    ///
    /// This method constructs a path that draws a rounded rectangle with a triangular arrow
    /// positioned according to the specified parameters. The path handles edge cases where
    /// the arrow might intersect with corner radii, ensuring smooth visual appearance.
    ///
    /// - Parameter rect: The rectangle in which to draw the shape.
    /// - Returns: A `Path` object representing the tooltip shape with arrow.
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        let arrowPos = arrowPosition * width

        if direction == .top {
            path.move(to: CGPoint(x: cornerRadius, y: arrowHeight))

            let arrowLeft = arrowPos - arrowWidth / 2
            if arrowLeft > cornerRadius {
                path.addLine(to: CGPoint(x: arrowLeft, y: arrowHeight))
            }

            path.addLine(to: CGPoint(x: arrowPos, y: 0))

            let arrowRight = arrowPos + arrowWidth / 2
            path.addLine(to: CGPoint(x: arrowRight, y: arrowHeight))

            if arrowRight < width - cornerRadius {
                path.addLine(to: CGPoint(x: width - cornerRadius, y: arrowHeight))
            }

            path.addArc(
                center: CGPoint(x: width - cornerRadius, y: arrowHeight + cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: -90),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )

            path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
            path.addArc(
                center: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )

            path.addLine(to: CGPoint(x: cornerRadius, y: height))
            path.addArc(
                center: CGPoint(x: cornerRadius, y: height - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )

            path.addLine(to: CGPoint(x: 0, y: arrowHeight + cornerRadius))
            path.addArc(
                center: CGPoint(x: cornerRadius, y: arrowHeight + cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )

        } else {
            path.move(to: CGPoint(x: cornerRadius, y: 0))
            path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
            path.addArc(
                center: CGPoint(x: width - cornerRadius, y: cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: -90),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )

            path.addLine(to: CGPoint(x: width, y: height - arrowHeight - cornerRadius))
            path.addArc(
                center: CGPoint(x: width - cornerRadius, y: height - arrowHeight - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )

            let arrowRight = arrowPos + arrowWidth / 2
            if arrowRight < width - cornerRadius {
                path.addLine(to: CGPoint(x: arrowRight, y: height - arrowHeight))
            }

            path.addLine(to: CGPoint(x: arrowPos, y: height))

            let arrowLeft = arrowPos - arrowWidth / 2
            path.addLine(to: CGPoint(x: arrowLeft, y: height - arrowHeight))

            if arrowLeft > cornerRadius {
                path.addLine(to: CGPoint(x: cornerRadius, y: height - arrowHeight))
            }

            path.addArc(
                center: CGPoint(x: cornerRadius, y: height - arrowHeight - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )

            path.addLine(to: CGPoint(x: 0, y: cornerRadius))
            path.addArc(
                center: CGPoint(x: cornerRadius, y: cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )
        }

        return path
    }
}
