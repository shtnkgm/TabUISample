//
//  ViewControllerFactory.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/20.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

/// ViewControllerの生成を行うファクトリークラス
struct ViewControllerFactory {

/// 「フィード」タブのViewControllerを生成する
static func createFeed() -> UIViewController {
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

/// 「探す」タブのViewControllerを生成する
static func createSearch() -> UIViewController {
    let viewController = CustomViewController.create()
    viewController.tabBarItem = UITabBarItem(title: "探す",
                                             image: UIImage(named: "search"),
                                             selectedImage: UIImage(named: "search_filled"))
    return viewController
}

/// 「お気に入り」タブのViewControllerを生成する
static func createFavorite() -> UIViewController {
    let viewController = CustomViewController.create()
    viewController.tabBarItem = UITabBarItem(title: "お気に入り",
                                             image: UIImage(named: "favorite"),
                                             selectedImage: UIImage(named: "favorite_filled"))
    return viewController
}

/// 「設定」タブのViewControllerを生成する
static func createSettings() -> UIViewController {
    let viewController = CustomViewController.create()
    viewController.tabBarItem = UITabBarItem(title: "設定",
                                             image: UIImage(named: "settings"),
                                             selectedImage: UIImage(named: "settings_filled"))
    return viewController
}
}
