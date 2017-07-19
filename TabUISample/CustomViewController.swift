//
//  CustomViewController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    var number: String = "-"
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = number
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// 自身のインスタンスを生成する
    static func create() -> CustomViewController {
        let storyBoard = UIStoryboard(name: className, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: className) as! CustomViewController
    }
}
