//
//  TooltipPreferenceKey.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A preference key that enables tooltip views to communicate their data up the view hierarchy.
///
/// `TooltipPreferenceKey` implements SwiftUI's `PreferenceKey` protocol to facilitate
/// the propagation of tooltip information from child views to parent containers. This allows
/// the `TooltipContainer` to receive and manage tooltip display requests from any descendant view.
///
/// The preference value type is `TooltipPreferenceData?`, where `nil` indicates no active tooltip.
///
/// - Note: This struct is available on iOS 14.0 and later.
@available(iOS 14.0, *)
struct TooltipPreferenceKey: PreferenceKey {
    /// The type of value associated with this preference key.
    typealias Value = TooltipPreferenceData?

    /// The default value when no preference has been set.
    ///
    /// Returns `nil`, indicating no tooltip is active by default.
    static var defaultValue: TooltipPreferenceData? {
        nil
    }

    /// Combines multiple preference values from child views into a single value.
    ///
    /// This method is called by SwiftUI when multiple views in the hierarchy set preference
    /// values. The implementation prioritizes the most recent non-nil value, allowing the
    /// latest tooltip to take precedence.
    ///
    /// - Parameters:
    ///   - value: The current accumulated preference value, modified in place.
    ///   - nextValue: A closure that returns the next preference value from the hierarchy.
    static func reduce(value: inout TooltipPreferenceData?, nextValue: () -> TooltipPreferenceData?) {
        if let next = nextValue() {
            value = next
        }
    }
}
