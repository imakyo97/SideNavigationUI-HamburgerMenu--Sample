//
//  ViewController.swift
//  TouchEvent
//
//  Created by 今村京平 on 2021/07/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // タッチイベント開始時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touchesBegan: \(touches.first!.location(in: view))")
    }

    // タッチイベントドラッグ時
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("touchesMoved: \(touches.first!.location(in: self.view))")
        let touchEvent = touches.first!
        //
        let view = touchEvent.view!
        guard view != self.view else { return }
        let touchPoint = touchEvent.location(in: self.view)
        view.center = touchPoint
    }

    // タッチイベント終了時
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("touchesEnded: \(touches.first!.location(in: view))")
    }
}

