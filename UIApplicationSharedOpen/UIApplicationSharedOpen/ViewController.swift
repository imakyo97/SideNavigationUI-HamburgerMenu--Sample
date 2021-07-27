//
//  ViewController.swift
//  UIApplicationSharedOpen
//
//  Created by 今村京平 on 2021/07/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedAppleOpenBtn(_ sender: Any) {
        let appleURL = URL(string: "https://apple.com")
        if UIApplication.shared.canOpenURL(appleURL!) {
            UIApplication.shared.open(appleURL!)
        }
    }

    @IBAction func tappedAmazonOpenBtn(_ sender: Any) {
        let amazonURL = URL(string: "https://amazon.com")
        if UIApplication.shared.canOpenURL(amazonURL!) {
            UIApplication.shared.open(amazonURL!)
        }
    }
}

