//
//  ToolTipProtocolTest.swift
//
//
//  Created by Sinan KÜLEN on 8.06.2023.
//

import XCTest
@testable import ToolTipKit

final class ToolTipProtocolTest: XCTestCase {
    class MockToolTip: ToolTipProtocol {
        var overView: UIView
        var text: NSAttributedString
        var delegate: ToolTipGestureDelegate?

        init(overView: UIView, text: String) {
            self.overView = overView
            self.text = ToolTipView.customize(text: text)
        }

        init(overView: UIView, text: NSAttributedString) {
            self.overView = overView
            self.text = text
        }

        var presentCalled: Bool = false
        func present() {
            presentCalled = true
        }
    }

    func testPresent() {
        let mockToolTip = MockToolTip(overView: UIView(), text: "mockToolTip")
        mockToolTip.present()
        XCTAssertTrue(mockToolTip.presentCalled)
    }
}
