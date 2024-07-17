
//
//  ToolTipProtocol.swift
//
//
//  Created by Sinan KÜLEN on 11.05.2023.
//
import Foundation
import UIKit

/// The `ToolTipProtocol` protocol defines the requirements for a tooltip object.
public protocol ToolTipProtocol: AnyObject {
    var overView: UIView { get }
    var text: NSAttributedString { get }
    var toolTipImage: UIImage? { get }
    var delegate: ToolTipGestureDelegate? { get set }
    /// Presents `ToolTipKit` over `overView`.
    func present()
}
