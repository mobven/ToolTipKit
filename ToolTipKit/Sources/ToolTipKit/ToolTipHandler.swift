//
//  ToolTipHandler.swift
//
//
//  Created by Sinan KÜLEN on 11.05.2023.
//
import Foundation

///  The `ToolTipGestureDelegate` protocol defines methods that a delegate object can adopt to handle tooltip gesture
/// events.
public protocol ToolTipGestureDelegate: AnyObject {
    func onTap()
}

/// An array of tooltips to be managed by the `ToolTipHandler`.
public class ToolTipHandler: ToolTipGestureDelegate {
    public var toolTips: [ToolTipProtocol]

    /// Initializes a new instance of `ToolTipHandler` with the specified tooltips.
    /// - Parameter toolTips: An array of tooltips to be managed by the `ToolTipHandler`.
    public init(toolTips: [ToolTipProtocol]) {
        self.toolTips = toolTips
        self.toolTips.forEach {
            $0.delegate = self
        }
    }

    /// Presents the first tooltip in the array.
    public func presentFirst() {
        toolTips.first?.present()
    }

    /// Presents the next tooltip in the array after receiving a tap gesture on the screen.
    public func onTap() {
        presentNext()
    }

    /// Presents the next tooltip in the array.
    private func presentNext() {
        if toolTips.count > .zero {
            toolTips.removeFirst()
            toolTips.first?.present()
        }
    }
}
