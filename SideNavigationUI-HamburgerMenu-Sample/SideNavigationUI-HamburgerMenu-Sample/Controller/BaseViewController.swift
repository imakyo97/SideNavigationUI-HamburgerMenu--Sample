//
//  BaseViewController.swift
//  SideNavigationUI-HamburgerMenu-Sample
//
//  Created by 今村京平 on 2021/07/28.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet private weak var contentsView: UIView!
    @IBOutlet private weak var SideNavigationView: UIView!
    @IBOutlet private weak var wrapperButton: UIButton!

    // 現在選択されたボタンの識別番号を持つ（初期値をmaincontentsにする）
    private var selectedButtonType: Int =
        SideNavigationButtonType.mainContents.rawValue

    // サイドナビゲーションの状態
    private var sideNavigationStatus: SideNavigationStatus =
        .closed

    private var mainContentsNavigationController: UINavigationController!
    private var informationContentsNavigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainContentsNavigationController = instantiateMainContentsNavigationController()
        settingMainContentsViewControllerDelegate()
        showMainContents() // MainContentsVCを初期画面に設定
        informationContentsNavigationController = instantiateInformationContentsNavigationController()
        settingInformationContentsViewControllerDelegate()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sideNavigationView" {
            // SideNavigationViewControllerのdelegateを設定
            let sideNavigationViewController =
                segue.destination as! SideNavigationViewController
            sideNavigationViewController.delegate = self
        }
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

    // informationContentsViewControllerのインスタンを作成
    private func instantiateInformationContentsNavigationController()
    -> UINavigationController {
        let storyBourd = UIStoryboard(name: "InformationContents", bundle: nil)
        let informationContentsNavigationController = storyBourd
            .instantiateInitialViewController()
            as! UINavigationController
        return informationContentsNavigationController
    }

    // インフォメーションコンテンツ画面を表示する
    private func showInformationContents() {
        // mainContentsVCのviewをBaseVCのcontentsViewに追加
        contentsView.addSubview(informationContentsNavigationController.view)
        // mainContentsVCをBaseVCの子として追加
        addChild(informationContentsNavigationController)
        // mainContentsVCに対して処理の終了を通知する
        informationContentsNavigationController.didMove(toParent: self)
    }

    private func showAppleWebPage() {
        if let appleURL = URL(string: "https://apple.com") {
            if UIApplication.shared.canOpenURL(appleURL) {
                UIApplication.shared.open(appleURL)
            } else {
                showAlertWith(completionHandler: nil)
            }
        }
    }

    private func showAmazonWebPage() {
        if let appleURL = URL(string: "https://amazon.com") {
            if UIApplication.shared.canOpenURL(appleURL) {
                UIApplication.shared.open(appleURL)
            } else {
                showAlertWith(completionHandler: nil)
            }
        }
    }


    private func showAlertWith(completionHandler: (() -> ())? = nil) {
        let alert = UIAlertController(
            title: "リンクを開くことができませんでした。",
            message: "アプリ内部の設定が誤っている可能性があります。",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                completionHandler?()
            }
        )
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    // サイドナビゲーションを開くメソッド
    private func openSideNavigationView(withCompletion: (() -> ())? = nil) {

        // サイドナビゲーションはタッチイベントを有効にする
        SideNavigationView.isUserInteractionEnabled = true

        // コンテンツはタッチイベントを無効にする
        contentsView.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.16, delay: 0, options: [.curveEaseOut], animations: {

            // コンテンツを移動させてサイドメニューを表示させる
            self.contentsView.frame = CGRect(
                x: 260,
                y: self.contentsView.frame.origin.y,
                width: self.contentsView.frame.width,
                height: self.contentsView.frame.height
            )
            self.wrapperButton.frame = CGRect(
                x: 260,
                y: self.wrapperButton.frame.origin.y,
                width: self.wrapperButton.frame.width,
                height: self.wrapperButton.frame.height
            )

            // メインコンテンツ以外のアルファを変更する
            self.wrapperButton.alpha = 0.36
            self.SideNavigationView.alpha = 1
        }, completion: { _ in
            withCompletion?()
        })
    }

    // サイドナビゲーションを閉じるメソッド
    private func closeSideNavigationView(withCompletion: (() -> ())? = nil) {

        // サイドナビゲーションはタッチイベントを有効にする
        SideNavigationView.isUserInteractionEnabled = false

        // コンテンツはタッチイベントを無効にする
        contentsView.isUserInteractionEnabled = true

        UIView.animate(withDuration: 0.16, delay: 0, options: [.curveEaseOut], animations: {

            // コンテンツを移動させてサイドメニューを表示させる
            self.contentsView.frame = CGRect(
                x: 0,
                y: self.contentsView.frame.origin.y,
                width: self.contentsView.frame.width,
                height: self.contentsView.frame.height
            )
            self.wrapperButton.frame = CGRect(
                x: 0,
                y: self.wrapperButton.frame.origin.y,
                width: self.wrapperButton.frame.width,
                height: self.wrapperButton.frame.height
            )

            // メインコンテンツ以外のアルファを変更する
            self.wrapperButton.alpha = 0
            self.SideNavigationView.alpha = 0
        }, completion: { _ in
            withCompletion?()
        })
    }
}

// MARK: - MainContentsViewControllerDelegate
extension BaseViewController: MainContentsViewControllerDelegate {
    func didTapMainContentsMenuButton() {
        openSideNavigationView()
    }
}

// MARK: - InformationContentsViewControllerDelegate
extension BaseViewController: InformationContentsViewControllerDelegate {
    func didTapInformationContentsMenuButton() {
        openSideNavigationView()
    }
}

// MARK: - SideNavigationButtonDelegate
extension BaseViewController: SideNavigationButtonDelegate {
    func changeMainContentsContainer(_ buttonType: Int) {

        // 選択されたボタンが現在表示されているか判定する
        let currentDisplay: Bool = selectedButtonType == buttonType

        switch buttonType {
        // メインコンテンツの場合
        case SideNavigationButtonType.mainContents.rawValue:
            selectedButtonType = buttonType
            closeSideNavigationView(withCompletion: {
                if !currentDisplay {
                    self.showMainContents()
                }
            })

        // インフォメーションコンテンツの場合
        case SideNavigationButtonType.informationContents.rawValue:
            selectedButtonType = buttonType
            closeSideNavigationView(withCompletion: {
                if !currentDisplay {
                    self.showInformationContents()
                }
            })

        // appleWebPageの場合
        case SideNavigationButtonType.appleWebPage.rawValue:
            closeSideNavigationView(withCompletion: {
                self.showAppleWebPage()
            })

        // amazonWebPageの場合
        case SideNavigationButtonType.amazonWebPage.rawValue:
            closeSideNavigationView(withCompletion: {
                self.showAmazonWebPage()
            })
        default:
            break
        }
    }
}

