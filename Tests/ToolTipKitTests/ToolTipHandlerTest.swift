//
//  ToolTipHandlerTest.swift
//
//
//  Created by Sinan KÜLEN on 8.06.2023.
//

import XCTest
@testable import ToolTipKit

final class ToolTipHandlerTest: XCTestCase {
    class MockToolTip: ToolTipProtocol {
        var overView: UIView
        var text: NSAttributedString
        var delegate: ToolTipKit.ToolTipGestureDelegate?

        init(overView: UIView, text: String, delegate: ToolTipGestureDelegate? = nil) {
            self.overView = overView
            self.text = ToolTipView.customize(text: text)
            self.delegate = delegate
        }

        init(overView: UIView, text: NSAttributedString, delegate: ToolTipGestureDelegate? = nil) {
            self.overView = overView
            self.text = text
            self.delegate = delegate
        }

        var presentCalled: Bool = false
        func present() {
            presentCalled = true
        }
    }

    class MockGestureDelegate: ToolTipGestureDelegate {
        var onTapCalled: Bool = false
        func toolTipDidTap(_ toolTip: ToolTipKit.ToolTipView) {
            onTapCalled = true
        }
    }

    func testPresent() {
        let mockToolTip1 = MockToolTip(overView: UIView(), text: "Tooltip 1")
        let mockToolTip2 = MockToolTip(overView: UIView(), text: "Tooltip 2")
        let mockToolTip3 = MockToolTip(overView: UIView(), text: "Tooltip 3")
        let mockToolTips = [mockToolTip1, mockToolTip2, mockToolTip3]
        let mockGestureDelegate = MockGestureDelegate()
        let toolTipHandler = ToolTipHandler(toolTips: mockToolTips)

        toolTipHandler.toolTips.forEach { $0.delegate = mockGestureDelegate }
        toolTipHandler.present()
        XCTAssert(mockToolTip1.presentCalled)
        toolTipHandler.toolTips.first?.delegate?.toolTipDidTap(
            .init(overView: mockToolTip1.overView, text: mockToolTip1.text)
        )
        XCTAssertTrue(mockGestureDelegate.onTapCalled)
    }
}
