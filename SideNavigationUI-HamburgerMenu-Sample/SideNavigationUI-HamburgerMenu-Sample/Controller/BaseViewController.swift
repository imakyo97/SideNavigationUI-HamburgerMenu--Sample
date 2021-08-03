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

    // タッチイベント開始時の座標
    private var touchBeganPositionX: CGFloat!

    private var mainContentsNavigationController: UINavigationController!
    private var informationContentsNavigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainContentsNavigationController = instantiateMainContentsNavigationController()
        settingMainContentsViewControllerDelegate()
        showMainContents() // MainContentsVCを初期画面に設定
        informationContentsNavigationController = instantiateInformationContentsNavigationController()
        settingInformationContentsViewControllerDelegate()
        setEdgePanGestureRecognizer()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sideNavigationView" {
            // SideNavigationViewControllerのdelegateを設定
            let sideNavigationViewController =
                segue.destination as! SideNavigationViewController
            sideNavigationViewController.delegate = self
        }
    }

    private func setEdgePanGestureRecognizer() {
        let panGesture =
            UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(edgeTapGesture(sender:))
            )
        panGesture.edges = .left
        contentsView.addGestureRecognizer(panGesture)
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
    // コンテンツの開閉状態を管理する
    private func changeContentsSettingWithAnimation(_ status: SideNavigationStatus) {
        // コンテンツを開いて、状態を管理する
        if status == .opened {
            sideNavigationStatus = .opened
            openSideNavigationView()
        } else {
            sideNavigationStatus = .closed
            closeSideNavigationView()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        let touchEvent = touches.first!

        let beginPosition = touchEvent.previousLocation(in: view)
        touchBeganPositionX = beginPosition.x
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        if touchBeganPositionX >= 260 && sideNavigationStatus == .opened {

            SideNavigationView.isUserInteractionEnabled = false
            contentsView.isUserInteractionEnabled = false

            let touchEvent = touches.first!

            // ドラッグ前の座標
            let preDx = touchEvent.previousLocation(in: self.view).x

            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x

            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx

            // ドラッグした移動分の値を反映させる
            var viewFrame: CGRect = wrapperButton.frame
            viewFrame.origin.x += dx
            contentsView.frame = viewFrame
            wrapperButton.frame = viewFrame

            // メインコンテンツのx座標が0〜260の間に収まるように補正
            if contentsView.frame.origin.x > 260 {

                contentsView.frame.origin.x = 260
                wrapperButton.frame.origin.x         = 260

            } else if contentsView.frame.origin.x < 0 {

                contentsView.frame.origin.x = 0
                wrapperButton.frame.origin.x         = 0
            }

            // サイドナビゲーションとボタンのアルファ値を変更する
            SideNavigationView.alpha = contentsView.frame.origin.x / 260
            wrapperButton.alpha           = contentsView.frame.origin.x / 260 * 0.36
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        if touchBeganPositionX >= 260 && (contentsView.frame.origin.x == 260 || contentsView.frame.origin.x < 160) {
            changeContentsSettingWithAnimation(.closed)
        } else if touchBeganPositionX >= 260 && contentsView.frame.origin.x >= 160 {
            changeContentsSettingWithAnimation(.opened)
        }
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

    @objc private func edgeTapGesture(sender: UIScreenEdgePanGestureRecognizer) {

        // サイドナビゲーションビューとコンテンツビューのタッチイベントを無効にする
        SideNavigationView.isUserInteractionEnabled = false
        contentsView.isUserInteractionEnabled = false

        // 移動量を取得する
        let move: CGPoint = sender.translation(in: contentsView)

        // コンテンツビューとボタンを移動させる
        wrapperButton.frame.origin.x += move.x
        contentsView.frame.origin.x += move.x

        // サイドナビゲーションとボタンのアルファ値を変更する
        SideNavigationView.alpha = contentsView.frame.origin.x / 260
        wrapperButton.alpha = contentsView.frame.origin.x / 260 * 0.36

        // 移動しすぎないようにナビゲーションビューの幅で止める
        if contentsView.frame.origin.x > 260 {
            contentsView.frame.origin.x = 260
            wrapperButton.frame.origin.x = 260
        } else if contentsView.frame.origin.x < 0 {
            contentsView.frame.origin.x = 0
            wrapperButton.frame.origin.x = 0
        }

        // ドラッグ終了時に移動量の160を基準に処理を分ける
        if sender.state == UIGestureRecognizer.State.ended {
            if contentsView.frame.origin.x > 160 {
                changeContentsSettingWithAnimation(.opened)
            } else {
                changeContentsSettingWithAnimation(.closed)
            }
        }

        // 移動量をリセットする
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
}

// MARK: - MainContentsViewControllerDelegate
extension BaseViewController: MainContentsViewControllerDelegate {
    func didTapMainContentsMenuButton() {
        changeContentsSettingWithAnimation(.opened)
    }
}

// MARK: - InformationContentsViewControllerDelegate
extension BaseViewController: InformationContentsViewControllerDelegate {
    func didTapInformationContentsMenuButton() {
        changeContentsSettingWithAnimation(.opened)
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
            sideNavigationStatus = .closed

        // インフォメーションコンテンツの場合
        case SideNavigationButtonType.informationContents.rawValue:
            selectedButtonType = buttonType
            closeSideNavigationView(withCompletion: {
                if !currentDisplay {
                    self.showInformationContents()
                }
            })
            sideNavigationStatus = .closed

        // appleWebPageの場合
        case SideNavigationButtonType.appleWebPage.rawValue:
            closeSideNavigationView(withCompletion: {
                self.showAppleWebPage()
            })
            sideNavigationStatus = .closed

        // amazonWebPageの場合
        case SideNavigationButtonType.amazonWebPage.rawValue:
            closeSideNavigationView(withCompletion: {
                self.showAmazonWebPage()
            })
            sideNavigationStatus = .closed
        default:
            break
        }
    }
}

