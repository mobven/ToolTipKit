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
    public static let shared = ToolTipManager()
    private init() {}

    public var config: ToolTipConfig = .init()
}
