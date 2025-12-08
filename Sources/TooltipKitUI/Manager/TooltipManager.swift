//
//  TooltipManager.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A manager class that coordinates tooltip dismissal across the view hierarchy.
///
/// `TooltipManager` acts as a centralized coordinator for tooltip lifecycle management,
/// allowing multiple tooltip views to register dismissal actions. This enables consistent
/// dismissal behavior when users interact with tooltips or the overlay background.
///
/// The manager uses SwiftUI's `ObservableObject` protocol to enable reactive updates
/// and is typically provided via `environmentObject` to child views.
///
/// - Note: This class is available on iOS 14.0 and later.
@available(iOS 14.0, *)
class TooltipManager: ObservableObject {
    /// A closure that, when executed, dismisses the currently active tooltip.
    ///
    /// This action is registered by tooltip views and invoked when dismissal is requested.
    var dismissAction: (() -> Void)?

    /// Dismisses the currently active tooltip with animation.
    ///
    /// This method executes the registered dismissal action (if any) and clears it.
    /// The dismissal is performed within an animation block to provide smooth transitions.
    ///
    /// - Note: Safe to call even if no tooltip is currently displayed.
    func dismiss() {
        withAnimation {
            dismissAction?()
            dismissAction = nil
        }
    }

    /// Registers a dismissal action that will be called when the tooltip should be dismissed.
    ///
    /// This method should be called by tooltip views to register their dismissal logic.
    /// Only one dismissal action can be registered at a time; registering a new action
    /// replaces any previously registered action.
    ///
    /// - Parameter dismiss: A closure that performs the tooltip dismissal when executed.
    func register(dismiss: @escaping () -> Void) {
        dismissAction = dismiss
    }
}
