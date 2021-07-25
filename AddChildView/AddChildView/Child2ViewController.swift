//
//  Child2ViewController.swift
//  AddChildView
//
//  Created by 今村京平 on 2021/07/22.
//

import UIKit

protocol Child2ViewControllerDelegate: AnyObject {
    func didTapShowChild1()
}

final class Child2ViewController: UIViewController {

    weak var delegate: Child2ViewControllerDelegate?

    @IBAction func didTapShowChild1(_ sender: Any) {
        delegate?.didTapShowChild1()
    }
}
