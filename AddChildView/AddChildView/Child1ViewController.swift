//
//  Child1ViewController.swift
//  AddChildView
//
//  Created by 今村京平 on 2021/07/22.
//

import UIKit

protocol Child1ViewControllerDelegate: AnyObject {
    func didTapShowChild2Btn()
}

final class Child1ViewController: UIViewController {

    weak var delegate: Child1ViewControllerDelegate?

    @IBAction private func didTapShowChild2(_ sender: Any) {
        delegate?.didTapShowChild2Btn()
    }
}
