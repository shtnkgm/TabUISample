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
        setupTabs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// 表示するタブを初期化する
    private func setupTabs() {
        let viewControllers = [createViewControllerInFirstTab(),
                               createViewControllerInSecondTab(),
                               createViewControllerInThirdTab(),
                               createViewControllerInFourthTab()]
        setViewControllers(viewControllers, animated: false)
    }

    /// 1番目のタブのViewControllerを生成する
    private func createViewControllerInFirstTab() -> UIViewController {
        let viewController = TopTabController.create()
        viewController.tabBarItem = UITabBarItem(title: "フィード",
                                                  image: UIImage(named: "feed"),
                                                  selectedImage: UIImage(named: "feed_filled"))

        let dataSource = (1...5).map {
            (number: Int) -> TopTabItem in
            let title = "フィード" + "\(number)"
            let viewController = CustomViewController.create()
            viewController.title = title
            return TopTabItem(title: title, viewController: viewController)
        }
        viewController.configure(dataSource: dataSource)
        return viewController
    }

    /// 2番目のタブのViewControllerを生成する
    private func createViewControllerInSecondTab() -> UIViewController {
        let viewController = CustomViewController.create()
        viewController.tabBarItem = UITabBarItem(title: "探す",
                                                  image: UIImage(named: "search"),
                                                  selectedImage: UIImage(named: "search_filled"))
        return viewController
    }

    /// 3番目のタブのViewControllerを生成する
    private func createViewControllerInThirdTab() -> UIViewController {
        let viewController = CustomViewController.create()
        viewController.tabBarItem = UITabBarItem(title: "お気に入り",
                                                 image: UIImage(named: "favorite"),
                                                 selectedImage: UIImage(named: "favorite_filled"))
        return viewController
    }

    /// 4番目のタブのViewControllerを生成する
    private func createViewControllerInFourthTab() -> UIViewController {
        let viewController = CustomViewController.create()
        viewController.tabBarItem = UITabBarItem(title: "設定",
                                                 image: UIImage(named: "settings"),
                                                 selectedImage: UIImage(named: "settings_filled"))
        return viewController
    }

}
