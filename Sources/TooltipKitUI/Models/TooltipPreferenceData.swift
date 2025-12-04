//
//  TooltipPreferenceData.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

/// A data structure that combines tooltip configuration with its target view's frame information.
///
/// `TooltipPreferenceData` is used to pass tooltip information through SwiftUI's preference
/// value system, allowing child views to communicate their tooltip requirements and layout
/// information up to a parent container view.
///
/// This structure implements `Equatable` to enable efficient change detection and prevent
/// unnecessary re-renders when tooltip data remains unchanged.
///
/// - Note: This struct is available on iOS 14.0 and later.
@available(iOS 14.0, *)
struct TooltipPreferenceData: Equatable {
    /// The configuration object that defines the tooltip's appearance and content.
    let config: TooltipConfig
    
    /// The frame rectangle of the target view in global coordinate space.
    ///
    /// This frame is used to position the tooltip relative to the target element and
    /// to create the highlight overlay that dims the background around the target.
    let frame: CGRect

    /// Determines equality between two `TooltipPreferenceData` instances.
    ///
    /// Two instances are considered equal if they have the same tooltip configuration ID
    /// and the same target frame. This comparison is used to optimize view updates.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side instance to compare.
    ///   - rhs: The right-hand side instance to compare.
    /// - Returns: `true` if both instances have the same ID and frame; otherwise, `false`.
    static func == (lhs: TooltipPreferenceData, rhs: TooltipPreferenceData) -> Bool {
        lhs.config.id == rhs.config.id && lhs.frame == rhs.frame
    }
}
