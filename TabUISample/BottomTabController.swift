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
    
    private func setUpViewControllers() {
        var viewControllers: [UIViewController] = []
        
        let redViewController = TopTabController.create()
        redViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        redViewController.view.backgroundColor = .red
        viewControllers.append(redViewController)
        
        let orangeViewController = CustomViewController.create()
        orangeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        orangeViewController.view.backgroundColor = .orange
        viewControllers.append(orangeViewController)
        
        let yellowViewController = CustomViewController.create()
        yellowViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 3)
        yellowViewController.view.backgroundColor = .yellow
        viewControllers.append(yellowViewController)
        
        let greenViewController = CustomViewController.create()
        greenViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 4)
        greenViewController.view.backgroundColor = .green
        viewControllers.append(greenViewController)
        
        setViewControllers(viewControllers, animated: false)
    }
}
