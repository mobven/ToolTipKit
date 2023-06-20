//
//  NSAttributedString+Extension.swift
//
//
//  Created by Sinan KÜLEN on 9.05.2023.
//
import Foundation
import UIKit

extension NSAttributedString {
    /// Calculates the height of the string when rendered with the specified width and font.
    /// - Parameters:
    ///   - width: The width within which the string will be rendered.
    /// - Returns: The calculated height of the string.
    func height(withWidth width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let boundingRect = boundingRect(with: size, options: options, context: nil)
        return boundingRect.height
    }
}
