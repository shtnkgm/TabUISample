//
//  BottomTabController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class BottomTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 表示するViewControllerを初期化する
    private func setUpViewControllers() {
        var viewControllers: [UIViewController] = []
        
        let topTabViewController = TopTabController.create()
        topTabViewController.tabBarItem = UITabBarItem(title: "1",
                                                       image: nil,
                                                       tag: 1)
        
        var topTabVCDataSource: [(title: String, viewController: UIViewController)] = []
        
        for i in 1...5 {
            let title = "1-\(i)"
            let viewController = CustomViewController.create()
            viewController.number = title
            topTabVCDataSource.append((title: title, viewController: viewController))
        }
        topTabViewController.configure(dataSource: topTabVCDataSource)
        
        viewControllers.append(topTabViewController)
        
        for i in 2...4 {
            let viewController = CustomViewController.create()
            viewController.number = "\(i)"
            viewController.tabBarItem = UITabBarItem(title: "\(i)",
                                                     image: nil,
                                                     tag: i)
            viewControllers.append(viewController)
        }

        setViewControllers(viewControllers, animated: false)
    }
}
