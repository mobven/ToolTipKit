//
//  UILabel+Extenison.swift
//
//
//  Created by Sinan KÜLEN on 9.05.2023.
//
import Foundation
import UIKit

extension UILabel {
    /// Calculates the height of the label's text when rendered with the specified width.
    /// - Parameter width: The width within which the label's text will be rendered.
    /// - Returns: The calculated height of the label's text.
    func textHeight(withWidth width: CGFloat) -> CGFloat {
        guard let text else {
            return 0
        }
        return text.height(withWidth: width, font: font)
    }
}
