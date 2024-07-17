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
        var toolTipImage: UIImage?
        var delegate: ToolTipGestureDelegate?

        init(overView: UIView, text: String, image: UIImage? = nil) {
            self.overView = overView
            self.text = ToolTipView.customize(text: text)
            self.toolTipImage = image
        }

        init(overView: UIView, text: NSAttributedString, image: UIImage? = nil) {
            self.overView = overView
            self.text = text
            self.toolTipImage = image
        }

        var presentCalled: Bool = false
        func present() {
            presentCalled = true
        }
    }

    func testPresent() {
        let mockToolTip = MockToolTip(overView: UIView(), text: "mockToolTip", image: UIImage(named: "test"))
        mockToolTip.present()
        XCTAssertTrue(mockToolTip.presentCalled)
    }
}
