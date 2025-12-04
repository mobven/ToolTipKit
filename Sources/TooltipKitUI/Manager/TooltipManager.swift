//
//  TooltipManager.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 3.12.2025.
//  Copyright © 2025 Mobven. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
class TooltipManager: ObservableObject {
    var dismissAction: (() -> Void)?

    func dismiss() {
        withAnimation {
            dismissAction?()
            dismissAction = nil
        }
    }

    func register(dismiss: @escaping () -> Void) {
        dismissAction = dismiss
    }
}
