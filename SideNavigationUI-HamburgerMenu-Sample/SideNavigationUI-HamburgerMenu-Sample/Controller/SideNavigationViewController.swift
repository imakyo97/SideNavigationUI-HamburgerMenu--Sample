//
//  SideNavigationViewController.swift
//  SideNavigationUI-HamburgerMenu-Sample
//
//  Created by 今村京平 on 2021/07/28.
//

import UIKit

protocol SideNavigationButtonDelegate: AnyObject {
    func changeMainContentsContainer(_ buttonType: Int)
}

class SideNavigationViewController: UIViewController {

    weak var delegate: SideNavigationButtonDelegate?

    @IBOutlet private weak var mainContentsButton: UIButton!
    @IBOutlet private weak var informationContentsButton: UIButton!
    @IBOutlet private weak var appleWebPageButton: UIButton!
    @IBOutlet private weak var amazonWebPageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingSideNavigationButton()
    }

    private func settingSideNavigationButton() {

        mainContentsButton.addTarget(
            self,
            action: #selector(didTapSideNavigationButton(sender:)),
            for: .touchUpInside
        )

        informationContentsButton.addTarget(
            self,
            action: #selector(didTapSideNavigationButton(sender:)),
            for: .touchUpInside
        )

        appleWebPageButton.addTarget(
            self,
            action: #selector(didTapSideNavigationButton(sender:)),
            for: .touchUpInside
        )

        amazonWebPageButton.addTarget(
            self,
            action: #selector(didTapSideNavigationButton(sender:)),
            for: .touchUpInside
        )
    }

    @objc private func didTapSideNavigationButton(sender: UIButton) {
        let selectedButtonType = sender.tag
        delegate?.changeMainContentsContainer(selectedButtonType)
    }
}
