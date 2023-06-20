//
//  ToolTipLabel.swift
//
//
//  Created by Sinan KÜLEN on 9.05.2023.
//
import Foundation
import UIKit

final class ToolTipLabel: UILabel {
    public var leftInset: CGFloat = .zero
    public var rightInset: CGFloat = .zero
    public var topInset: CGFloat = .zero
    public var bottomInset: CGFloat = .zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + leftInset + rightInset,
            height: size.height + topInset + bottomInset
        )
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
