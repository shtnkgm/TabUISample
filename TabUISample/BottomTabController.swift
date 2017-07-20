//
//  BottomTabController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

/// 下タブの管理を行うクラス
final class BottomTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// 表示するタブを初期化する
    private func setupTabs() {
        let viewControllers = [ViewControllerFactory.createFeed(),
                               ViewControllerFactory.createSearch(),
                               ViewControllerFactory.createFavorite(),
                               ViewControllerFactory.createSettings()]
        setViewControllers(viewControllers, animated: false)
    }
}
