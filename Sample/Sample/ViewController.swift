//
//  ViewController.swift
//  Sample
//
//  Created by Sinan KÜLEN on 13.06.2023.
//

import ToolTipKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var topView: UIImageView!
    @IBOutlet var bottomView: UIImageView!
    @IBOutlet var topButton: UIButton!
    @IBOutlet var bottomButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureToolTip()
        showToolTip()
    }
    
    private func configureToolTip() {
        var toolTipConfig = ToolTipManager.shared.config
        toolTipConfig.isShowView = true
        ToolTipManager.shared.config = toolTipConfig
    }
    
    private func showToolTip() {
        let buttonDescription = "Showing a tooltip on a view can be useful in providing users with additional information or descriptions related to that view."
        let viewDescription = "To display a tooltip on a button, you can use a tooltip text to provide additional information or instructions to the user."
        let toolTipHandler = ToolTipHandler(toolTips: [ToolTipView(overView: topButton,
                                                                   text: viewDescription),
                                                       ToolTipView(overView: bottomButton,
                                                                   text: viewDescription),
                                                       ToolTipView(overView: topView,
                                                                   text: buttonDescription),
                                                       ToolTipView(overView: bottomView,
                                                                   text: buttonDescription)])
        toolTipHandler.presentFirst()
    }
}

