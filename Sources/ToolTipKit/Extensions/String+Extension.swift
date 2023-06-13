//
//  String+Extension.swift
//
//
//  Created by Sinan KÜLEN on 9.05.2023.
//
import Foundation
import UIKit

extension String {
    /// Calculates the height of the string when rendered with the specified width and font.
    /// - Parameters:
    ///   - width: The width within which the string will be rendered.
    ///   - font: The font used to render the string.
    /// - Returns: The calculated height of the string.
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = (self as NSString).boundingRect(
            with: maxSize,
            options: [.usesLineFragmentOrigin],
            attributes: [.font: font],
            context: nil
        )
        return actualSize.height
    }
}
