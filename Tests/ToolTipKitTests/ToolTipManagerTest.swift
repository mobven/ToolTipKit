//
//  ToolTipManagerTest.swift
//
//
//  Created by Sinan KÜLEN on 8.06.2023.
//

import XCTest
@testable import ToolTipKit

final class ToolTipManagerTest: XCTestCase {
    func testConfig() {
        var toolTipConfig = ToolTipManager.shared.config
        toolTipConfig.shouldHighlightView = true
        toolTipConfig.textColor = .gray
        toolTipConfig.toolTipBacgroundColor = .darkGray
        ToolTipManager.shared.config = toolTipConfig
        XCTAssertEqual(toolTipConfig.shouldHighlightView, ToolTipManager.shared.config.shouldHighlightView)
        XCTAssertEqual(toolTipConfig.textColor, ToolTipManager.shared.config.textColor)
        XCTAssertEqual(toolTipConfig.toolTipBacgroundColor, ToolTipManager.shared.config.toolTipBacgroundColor)
    }
}
