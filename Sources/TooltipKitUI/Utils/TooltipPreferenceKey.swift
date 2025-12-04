//
//  TooltipPreferenceKey.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TooltipPreferenceKey: PreferenceKey {
    typealias Value = TooltipPreferenceData?

    static var defaultValue: TooltipPreferenceData? {
        nil
    }

    static func reduce(value: inout TooltipPreferenceData?, nextValue: () -> TooltipPreferenceData?) {
        if let next = nextValue() {
            value = next
        }
    }
}
