//
//  ToolTipManager.swift
//
//
//  Created by Sinan KÜLEN on 9.05.2023.
//
import Foundation
import UIKit

///  `ToolTipManager` is a singleton class that manages tooltip configurations.
public final class ToolTipManager {
    /// Singleton instance of `ToolTipManager`.
    public static let shared = ToolTipManager()
    private init() {}

    /// Configurations of `ToolTipView`
    public var config: ToolTipConfig = .init()
}
