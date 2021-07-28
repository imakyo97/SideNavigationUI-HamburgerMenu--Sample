//
//  BaseViewController.swift
//  SideNavigationUI-HamburgerMenu-Sample
//
//  Created by 今村京平 on 2021/07/28.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var contentsView: UIView!

    private var mainContentsNavigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainContentsNavigationController = instantiateMainContentsNavigationController()
        let mainContentsVC = mainContentsNavigationController
            .topViewController as! MainContentsViewController
        mainContentsVC.delegate = self
        showMainContents() // MainContentsVCを初期画面に設定
    }

    // MainContentsViewControllerのインスタンを作成
    private func instantiateMainContentsNavigationController()
    -> UINavigationController {
        let storyBourd = UIStoryboard(name: "MainContents", bundle: nil)
        let mainContentsNavigationController = storyBourd
            .instantiateInitialViewController()
            as! UINavigationController
        return mainContentsNavigationController
    }

    // メインコンテンツ画面を表示する
    private func showMainContents() {
        // mainContentsVCのviewをBaseVCのcontentsViewに追加
        contentsView.addSubview(mainContentsNavigationController.view)
        // mainContentsVCをBaseVCの子として追加
        addChild(mainContentsNavigationController)
        // mainContentsVCに対して処理の終了を通知する
        mainContentsNavigationController.didMove(toParent: self)
    }
}

extension BaseViewController: MainContentsViewControllerDelegate {
    func didTapMenuButton() {
        print("delegateが作動しました")
        contentsView.frame.origin.x = 260
        }
}
