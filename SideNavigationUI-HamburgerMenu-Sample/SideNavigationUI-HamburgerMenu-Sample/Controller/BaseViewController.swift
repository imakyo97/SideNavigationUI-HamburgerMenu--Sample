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
    private var informationContentsNavigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainContentsNavigationController = instantiateMainContentsNavigationController()
        settingMainContentsViewControllerDelegate()
        showMainContents() // MainContentsVCを初期画面に設定
    }

    // MainContentsViewControllerDelegateをselfに設定
    private func settingMainContentsViewControllerDelegate() {
        let mainContentsVC = mainContentsNavigationController
            .topViewController as! MainContentsViewController
        mainContentsVC.delegate = self
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

    // MainContentsViewControllerDelegateをselfに設定
    private func settingInformationContentsViewControllerDelegate() {
        let informationContentsVC = informationContentsNavigationController
            .topViewController as! InformationContentsViewController
        informationContentsVC.delegate = self
    }

    // MainContentsViewControllerのインスタンを作成
    private func instantiateInformationContentsNavigationController()
    -> UINavigationController {
        let storyBourd = UIStoryboard(name: "InformationContents", bundle: nil)
        let informationContentsNavigationController = storyBourd
            .instantiateInitialViewController()
            as! UINavigationController
        return informationContentsNavigationController
    }

    // メインコンテンツ画面を表示する
    private func showInformationContents() {
        // mainContentsVCのviewをBaseVCのcontentsViewに追加
        contentsView.addSubview(informationContentsNavigationController.view)
        // mainContentsVCをBaseVCの子として追加
        addChild(informationContentsNavigationController)
        // mainContentsVCに対して処理の終了を通知する
        informationContentsNavigationController.didMove(toParent: self)
    }
}

extension BaseViewController: MainContentsViewControllerDelegate {
    func didTapMainContentsMenuButton() {
        contentsView.frame.origin.x = 260
    }
}

extension BaseViewController: InformationContentsViewControllerDelegate {
    func didTapInformationContentsMenuButton() {
        contentsView.frame.origin.x = 260
    }
}


