//
//  TriangleView.swift
//
//
//  Created by Sinan KÜLEN on 8.05.2023.
//
import UIKit

final class TriangleView: UIView {
    public var triangleColor: UIColor = .white {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let trianglePath = UIBezierPath()
        let width = rect.width
        let height = rect.height

        trianglePath.move(to: CGPoint(x: .zero, y: height))
        trianglePath.addLine(to: CGPoint(x: width, y: height))
        trianglePath.addLine(to: CGPoint(x: width / 2, y: .zero))
        trianglePath.addLine(to: CGPoint(x: 0, y: height))
        trianglePath.close()

        triangleColor.setStroke()
        triangleColor.setFill()
        trianglePath.fill()
        trianglePath.stroke()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = trianglePath.cgPath
        layer.mask = shapeLayer
    }
}
