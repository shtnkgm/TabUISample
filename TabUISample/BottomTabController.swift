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
        let image = UIImage(named: "square.png")
        
        // 最初のタブ
        let firstViewController = TopTabController.create()
        firstViewController.tabBarItem = UITabBarItem(title: "1",
                                                      image: image,
                                                      tag: 1)
        
        let firstVCDataSource = (1...5).map {
            (number: Int) -> Page in
            let title = "1-\(number)"
            let viewController = CustomViewController.create()
            viewController.number = title
            return Page(title: title, viewController: viewController)
        }
        
        firstViewController.configure(dataSource: firstVCDataSource)
        
        let viewControllers = [firstViewController] + (2...4).map {
            (number: Int) -> UIViewController in
            let viewController = CustomViewController.create()
            viewController.number = "\(number)"
            viewController.tabBarItem = UITabBarItem(title: "\(number)",
                image: image,
                tag: number)
            return viewController
        }
        
        setViewControllers(viewControllers, animated: false)
    }
}
