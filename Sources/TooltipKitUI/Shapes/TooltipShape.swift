//
//  TooltipShape.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TooltipShape: Shape {
    var arrowHeight: CGFloat = 9
    var arrowWidth: CGFloat = 18
    var cornerRadius: CGFloat = 8
    var arrowPosition: CGFloat = 0.5
    var direction: ArrowDirection = .top

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
