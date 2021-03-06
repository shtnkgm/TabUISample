//
//  Page.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/18.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

/// 上タブの要素を表現したデータモデル
final class TopTabItem {
    /// タブのタイトル
    let title: String

    /// タブに紐づくViewController
    let viewController: UIViewController

    init(title: String, viewController: UIViewController) {
        self.title = title
        self.viewController = viewController
    }
}
