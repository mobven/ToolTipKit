//
//  ToolTipHandler.swift
//  ToolTipKit
//
//  Created by Sinan KÜLEN on 11.05.2023.
//
import Foundation

///  The `ToolTipGestureDelegate` protocol defines methods that a delegate object can adopt to handle tooltip gesture
/// events.
public protocol ToolTipGestureDelegate: AnyObject {
    func toolTipDidTap(_ toolTip: ToolTipView)
}

/// An array of tooltips to be managed by the `ToolTipHandler`.
public final class ToolTipHandler: ToolTipGestureDelegate {
    public var toolTips: [ToolTipProtocol]

    /// Initializes a new instance of `ToolTipHandler` with the specified tooltips.
    /// - Parameter toolTips: An array of tooltips to be managed by the `ToolTipHandler`.
    public init(toolTips: [ToolTipProtocol]) {
        self.toolTips = toolTips
        self.toolTips.forEach {
            $0.delegate = self
        }
    }

    /// Presents the next tooltip in the array.
    public func present() {
        guard toolTips.count > .zero else { return }
        toolTips.first?.present()
        toolTips.removeFirst()
    }

    /// Presents the next tooltip in the array after receiving a tap gesture on the screen.
    public func toolTipDidTap(_ toolTip: ToolTipView) {
        present()
    }
}
