//
//  ToolTipManagerTest.swift
//
//
//  Created by Sinan KÜLEN on 8.06.2023.
//

@testable import ToolTipKit
import XCTest

final class ToolTipManagerTest: XCTestCase {
    func testConfig() {
        var toolTipConfig = ToolTipManager.shared.config
        toolTipConfig.isShowView = true
        toolTipConfig.textColor = .gray
        toolTipConfig.toolTipBacgroundColor = .darkGray
        ToolTipManager.shared.config = toolTipConfig
        XCTAssertEqual(toolTipConfig.isShowView, ToolTipManager.shared.config.isShowView)
        XCTAssertEqual(toolTipConfig.textColor, ToolTipManager.shared.config.textColor)
        XCTAssertEqual(toolTipConfig.toolTipBacgroundColor, ToolTipManager.shared.config.toolTipBacgroundColor)
    }
}
