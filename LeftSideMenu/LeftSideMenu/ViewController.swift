//
//  ViewController.swift
//  LeftSideMenu
//
//  Created by 今村京平 on 2021/07/25.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var mainViewLeadingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setEdgePanGestureRecognizer()
    }

    private func setEdgePanGestureRecognizer() {
        let panGesture =
            UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(edgeTapGesture(sender:))
            )
        panGesture.edges = .left
        mainView.addGestureRecognizer(panGesture)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SideMenuSegue" {
            let sideMenuViewController =
                segue.destination as! SideMenuViewController
            sideMenuViewController.delegate = self
        }
    }

    @objc private func edgeTapGesture(sender: UIScreenEdgePanGestureRecognizer) {

        // 移動量を取得する
        let move = sender.translation(in: mainView)

        // mainViewを移動させる
        mainView.frame.origin.x += move.x

        // ドラッグ終了後の処理
        if sender.state == UIGestureRecognizer.State.ended {
            if mainView.frame.origin.x < 160 {
                mainView.frame.origin.x = 0
            } else {
                mainView.frame.origin.x = 260
            }
        }

        // 移動量をリセット
        sender.setTranslation(.zero, in: mainView)
    }
}

extension ViewController: SideMenuViewControllerDelegate {
    func tappedCloseBtn() {
        mainView.frame.origin.x = 0
    }
}
