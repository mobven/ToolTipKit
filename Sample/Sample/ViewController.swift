//
//  ViewController.swift
//  Sample
//
//  Created by Sinan KÜLEN on 13.06.2023.
//

import ToolTipKit
import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet var topView: UIImageView!
    @IBOutlet var bottomView: UIImageView!
    @IBOutlet var topButton: UIButton!
    @IBOutlet var bottomButton: UIButton!
    
    private let previewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SwiftUI Preview", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureToolTip()
        showToolTip()
    }

    private func configureToolTip() {
        var toolTipConfig = ToolTipManager.shared.config
        toolTipConfig.shouldHighlightView = true
        ToolTipManager.shared.config = toolTipConfig
    }

    private func showToolTip() {
        let buttonDescription =
            "Showing a tooltip on a view can be useful in providing users with additional information or descriptions related to that view."
        let viewDescription =
            "To display a tooltip on a button, you can use a tooltip text to provide additional information or instructions to the user."
        let toolTipHandler = ToolTipHandler(toolTips: [
            ToolTipView(
                overView: topButton,
                text: viewDescription
            ),
            ToolTipView(
                overView: bottomButton,
                text: viewDescription
            ),
            ToolTipView(
                overView: topView,
                text: buttonDescription
            ),
            ToolTipView(
                overView: bottomView,
                text: buttonDescription
            )
        ])
        toolTipHandler.present()
    }
    
    private func setupPreviewButton() {
        view.addSubview(previewButton)
        previewButton.addTarget(self, action: #selector(openSwiftUIPreview), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            previewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func openSwiftUIPreview() {
        let swiftUIView = TooltipPreviewScreen()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: true)
    }
}
