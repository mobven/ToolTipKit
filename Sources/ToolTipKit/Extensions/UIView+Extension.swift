//
//  UIView+Extension.swift
//
//
//  Created by Sinan KÜLEN on 10.05.2023.
//
import Foundation
import UIKit

extension UIView {
    /// Returns the frame of the view in the coordinate system of its window.
    /// - Parameter view: The view whose frame needs to be obtained.
    /// - Returns: The frame of the view in the coordinate system of its window.
    func viewFrameInWindow(_ view: UIView) -> CGRect {
        if let window = view.window {
            return view.convert(view.bounds, to: window)
        }
        return .zero
    }

    /// Returns snapshot of the view after screen updates.
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { ctx in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
