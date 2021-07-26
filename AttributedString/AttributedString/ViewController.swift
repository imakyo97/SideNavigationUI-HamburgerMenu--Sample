//
//  ViewController.swift
//  AttributedString
//
//  Created by 今村京平 on 2021/07/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var YesNoLabel: UILabel!
    @IBOutlet weak var colorfulLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingYesNoLabel()
        settingColorfulLabel()
    }

    private func settingYesNoLabel() {
        // AttributedStringを作成
        var attributed = [NSAttributedString.Key: Any]()
        // フォントカラーを指定
        attributed[.foregroundColor] = UIColor.red
        // フォントを指定
        attributed[.font] = UIFont.boldSystemFont(ofSize:20)

        let string = NSAttributedString(string: YesNoLabel.text!, attributes: attributed)
        YesNoLabel.attributedText = string
    }

    private func settingColorfulLabel() {
        // AttributedStringを作成
        let attributed1: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let string1 = NSAttributedString(string: "はい、", attributes: attributed1)

        // AttributedStringを作成
        let attributed2: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let string2 = NSAttributedString(string: "いいえ", attributes: attributed2)

        let mutableString = NSMutableAttributedString()
        mutableString.append(string1)
        mutableString.append(string2)

        colorfulLabel.attributedText = mutableString
    }
}

