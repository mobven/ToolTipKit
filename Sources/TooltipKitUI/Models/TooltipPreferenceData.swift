//
//  TooltipPreferenceData.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TooltipPreferenceData: Equatable {
    let config: TooltipConfig
    let frame: CGRect

    static func == (lhs: TooltipPreferenceData, rhs: TooltipPreferenceData) -> Bool {
        lhs.config.id == rhs.config.id && lhs.frame == rhs.frame
    }
}
