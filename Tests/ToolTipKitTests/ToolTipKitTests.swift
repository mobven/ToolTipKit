
import UIKit
import XCTest
@testable import ToolTipKit

final class ToolTipKitTests: XCTestCase {
    var sut: ToolTipView!
    let overView = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    let text =
        "Lorem ipsum Lorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsum"
    let image = UIImage(named: "test")
    var toolTipHandler: ToolTipHandler!

    override func setUp() {
        super.setUp()
        sut = ToolTipView(overView: overView, text: text, image: image)
    }

    func testWithSetup() {
        sut.present()
        XCTAssertEqual(sut.overView, overView)
        XCTAssertEqual(sut.toolTipLabel.text, text)
        XCTAssertEqual(sut.subviews.count, 3)
        XCTAssertEqual(sut.toolTipImage, image)
        XCTAssertEqual(sut.triangleView.frame.size.width, ToolTipManager.shared.config.triangleSize.width)
    }

    func testWithShowOverView() {
        ToolTipManager.shared.config.shouldHighlightView = true
        sut.present()
        XCTAssertEqual(sut.subviews.count, 4)
    }
}
