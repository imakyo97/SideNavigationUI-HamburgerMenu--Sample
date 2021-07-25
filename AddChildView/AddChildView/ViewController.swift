//
//  ViewController.swift
//  AddChildView
//
//  Created by 今村京平 on 2021/07/22.
//

import UIKit

class ViewController: UIViewController {

    private var child1VC: Child1ViewController!
    private var child2VC: Child2ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBourd1 = UIStoryboard(name: "Child1", bundle: nil)
        // child1ViewControllerのインスタンを作成
        child1VC = storyBourd1.instantiateInitialViewController()
            as? Child1ViewController
        child1VC.delegate = self
        showChild1() // Child1を初期画面に設定

        let storyBourd2 = UIStoryboard(name: "Child2", bundle: nil)
        // child1ViewControllerのインスタンを作成
        child2VC = storyBourd2.instantiateInitialViewController()
            as? Child2ViewController
        child2VC.delegate = self

    }

    private func showChild1() {

        // child1ViewControllerをViewControllerの子として追加
        addChild(child1VC)
        // child1ViewContorollerのviewをViewControllerviewに追加
        view.addSubview(child1VC.view)
        // child1ViewControllerに対して処理の終了を通知する
        child1VC.didMove(toParent: self)
    }

    private func showChild2() {

        // child1ViewControllerをViewControllerの子として追加
        addChild(child2VC)
        // child1ViewContorollerのviewをViewControllerviewに追加
        view.addSubview(child2VC.view)
        // child1ViewControllerに対して処理の終了を通知する
        child2VC.didMove(toParent: self)
    }
}

extension ViewController: Child1ViewControllerDelegate {
    func didTapShowChild2Btn() {
        showChild2()
    }
}

extension ViewController: Child2ViewControllerDelegate {
    func didTapShowChild1() {
        showChild1()
    }
}

