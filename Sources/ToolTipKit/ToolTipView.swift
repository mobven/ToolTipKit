//
//  ToolTipView.swift
//
//
//  Created by Sinan KÜLEN on 8.05.2023.
//

import Foundation
import UIKit

/// ToolTipView to display tips on top view.
public final class ToolTipView: UIView, ToolTipProtocol {
    /// Delegates `ToolTipKit` tip changes.
    public var delegate: ToolTipGestureDelegate?
    public var overView: UIView
    public var text: NSAttributedString
    private var toolTipDirection: ToolTipDirection = .up(.zero)

    /// Initalizes `ToolTipView` with parameters
    /// - Parameters:
    ///   - overView: Root view to display `ToolTipView`.
    ///   - text: Text to be displayed on tool tip view.
    public convenience init(overView: UIView, text: String) {
        self.init(overView: overView, text: Self.customize(text: text))
    }

    /// Initalizes `ToolTipView` with parameters
    /// - Parameters:
    ///   - overView: Root view to display `ToolTipView`.
    ///   - text: Text to be displayed on tool tip view.
    public init(overView: UIView, text: NSAttributedString) {
        self.overView = overView
        self.text = text
        super.init(frame: UIScreen.main.bounds)
        configureGestureRecognizer()
    }

    /// Presents tool tip view with initialized parameters.
    public func present() {
        let config = ToolTipManager.shared.config
        let leadingTrailingToolTipPadding = config.toolTipLeadingPadding + config.toolTipTrailingPadding
        let topBottomToolTipLabelInset = config.toolTipLabelEdgeInsets.bottom + config.toolTipLabelEdgeInsets.top
        let labelWidth = (overView.window?.frame.width ?? .zero - leadingTrailingToolTipPadding) +
            topBottomToolTipLabelInset
        toolTipDirectionFor(overView: overView, and: text.height(withWidth: labelWidth))
        setup()
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizer))
        gestureRecognizer.delegate = self
        addGestureRecognizer(gestureRecognizer)
    }

    class func customize(text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: ToolTipManager.shared.config.textFont,
            .foregroundColor: ToolTipManager.shared.config.textColor
        ])
        return attributedString
    }

    lazy var toolTipLabel: UILabel = {
        let label = ToolTipLabel()
        label.attributedText = text
        label.textAlignment = .left
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = ToolTipManager.shared.config.toolTipCornerRadius
        label.layer.masksToBounds = ToolTipManager.shared.config.toolTipCornerRadius > .zero
        label.topInset = ToolTipManager.shared.config.toolTipLabelEdgeInsets.top
        label.leftInset = ToolTipManager.shared.config.toolTipLabelEdgeInsets.left
        label.rightInset = ToolTipManager.shared.config.toolTipLabelEdgeInsets.right
        label.bottomInset = ToolTipManager.shared.config.toolTipLabelEdgeInsets.bottom
        return label
    }()

    lazy var backgroundView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = ToolTipManager.shared.config.toolTipBacgroundColor
        return view
    }()

    lazy var triangleView: UIView = {
        let view = TriangleView(frame: toolTipDirection.triangleFrame.triangleFrame)
        view.transform = toolTipDirection.triangleFrame.isUp ? view.transform
            .rotated(by: .pi) : view
            .transform
        view.triangleColor = UIColor.white
        return view
    }()

    private func showOverView() {
        let imageView = UIImageView(image: overView.snapshot)
        let fakeView = overView
        imageView.frame = fakeView.viewFrameInWindow(fakeView)
        addSubview(imageView)
    }

    private func setup() {
        overView.window?.addSubview(self)
        setupViews()
        setupLayouts()
        if ToolTipManager.shared.config.shouldHighlightView {
            showOverView()
        }
    }

    private func setupViews() {
        addSubview(backgroundView)
        addSubview(triangleView)
        addSubview(toolTipLabel)
    }

    private func setupLayouts() {
        toolTipLabel.translatesAutoresizingMaskIntoConstraints = false
        toolTipLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: ToolTipManager.shared.config.toolTipLeadingPadding
        ).isActive = true
        toolTipLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -ToolTipManager.shared.config.toolTipTrailingPadding
        ).isActive = true
        if toolTipDirection.triangleFrame.isUp {
            toolTipLabel.bottomAnchor.constraint(equalTo: triangleView.topAnchor).isActive = true
        } else {
            toolTipLabel.topAnchor.constraint(equalTo: triangleView.bottomAnchor).isActive = true
        }
    }

    private func toolTipDirectionFor(overView: UIView, and labelHeight: CGFloat) {
        guard let safeAreaTopHeight = overView.window?.safeAreaInsets.top,
              let safeAreaBottomHeight = overView.window?.safeAreaInsets.bottom,
              let screenHeight = overView.window?.frame.height else { return }

        let overViewRect = overView.viewFrameInWindow(overView)
        let overViewYPoint = overViewRect.origin.y
        let tooltipSpacerConstant = ToolTipManager.shared.config.tooltipSpacerConstant

        if (overViewYPoint - labelHeight - tooltipSpacerConstant - safeAreaTopHeight) > 100 {
            toolTipDirection = .up(overViewRect)
        } else if screenHeight - safeAreaBottomHeight - overViewYPoint - labelHeight - tooltipSpacerConstant > 100 {
            toolTipDirection = .down(overViewRect)
        }
    }

    private enum ToolTipDirection: Equatable {
        case up(CGRect)
        case down(CGRect)

        var triangleFrame: (triangleFrame: CGRect, isUp: Bool) {
            let triangleSize = ToolTipManager.shared.config.triangleSize
            let toolTipViewPadding = ToolTipManager.shared.config.toolTipViewPadding
            switch self {
            case let .up(viewRect):
                return (
                    CGRect(
                        x: (viewRect.width / 2) + viewRect.origin.x - (triangleSize.width / 2),
                        y: viewRect.origin.y - triangleSize.height - toolTipViewPadding,
                        width: triangleSize.width,
                        height: triangleSize.height
                    ),
                    true
                )
            case let .down(viewRect):
                return (
                    CGRect(
                        x: (viewRect.width / 2) + viewRect.origin.x - (triangleSize.width / 2),
                        y: viewRect.origin.y + viewRect.height + toolTipViewPadding,
                        width: triangleSize.width,
                        height: triangleSize.height
                    ),
                    false
                )
            }
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension ToolTipView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_: UIGestureRecognizer, shouldReceive _: UITouch) -> Bool {
        removeFromSuperview()
        delegate?.toolTipDidTap(self)
        return false
    }
}
