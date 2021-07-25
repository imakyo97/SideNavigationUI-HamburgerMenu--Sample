//
//  SideMenuViewController.swift
//  LeftSideMenu
//
//  Created by 今村京平 on 2021/07/25.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func tappedCloseBtn()
}

final class SideMenuViewController: UIViewController {

    weak var delegate: SideMenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func tappedCloseBtn(_ sender: Any) {
        delegate?.tappedCloseBtn()
    }
}
