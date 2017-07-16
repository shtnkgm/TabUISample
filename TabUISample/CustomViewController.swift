//
//  CustomViewController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    static func create() -> CustomViewController {
        let storyBoard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyBoard.instantiateInitialViewController() as! CustomViewController
    }
}
