//
//  PageViewController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

/// 上タブで管理されるPageViewController
class PageViewController: UIPageViewController {

    /// デリゲート
    weak var pageViewControllerDelegate: PageViewControllerDelegate?

    /// データソース
    weak var pageViewControllerDataSource: PageViewControllerDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self

        setupFirstViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// 表示するViewControllerを初期化する
    private func setupFirstViewController() {
        guard let viewController = pageViewControllerDataSource?.pageViewController(self, viewControllerForPageAt: 0) else {
            return
        }

        // 最初に表示するViewControllerのみをセットする
        setViewControllers([viewController],
                           direction: .forward,
                           animated: false,
                           completion: nil)
    }

    /// インデックスで指定したページへ移動する
    func move(to index: Int) {
        // 現在のインデックスを取得
        guard let currentViewController = viewControllers?.first,
            let currentIndex = pageViewControllerDataSource?.pageViewController(self, indexOf: currentViewController) else {
                return
        }

        // 現在表示中であれば何もしない
        guard index != currentIndex else {
            return
        }

        // ページを移動する際の方向
        let direction: UIPageViewControllerNavigationDirection = index > currentIndex ? .forward : .reverse

        guard let viewController = pageViewControllerDataSource?.pageViewController(self, viewControllerForPageAt: index) else {
            return
        }

        setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }

    /// 自身のインスタンスを生成する
    static func create() -> PageViewController {
        let storyBoard = UIStoryboard(name: className, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: className) as! PageViewController
    }

}

extension PageViewController: UIPageViewControllerDelegate {
    /// ページを移動する直前
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

        guard let viewController = pendingViewControllers.first,
            let index = pageViewControllerDataSource?.pageViewController(self, indexOf: viewController) else {
                return
        }

        pageViewControllerDelegate?.pageViewController(self, willPagingTo: index)
    }

    /// ページを移動した直後
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    }
}

extension PageViewController: UIPageViewControllerDataSource {

    /// ページを戻る場合のViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let index = pageViewControllerDataSource?.pageViewController(self, indexOf: viewController) else {
            return nil
        }

        return pageViewControllerDataSource?.pageViewController(self, viewControllerForPageAt: index - 1)
    }

    /// ページを進む場合のViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let index = pageViewControllerDataSource?.pageViewController(self, indexOf: viewController) else {
            return nil
        }

        return pageViewControllerDataSource?.pageViewController(self, viewControllerForPageAt: index + 1)
    }
}

protocol PageViewControllerDelegate: class {
    /// ページを移動する直前
    func pageViewController(_ pageViewController: PageViewController, willPagingTo index: Int)
}

protocol PageViewControllerDataSource: class {
    /// ページインデックスに応じて表示するViewControllerを返す
    func pageViewController(_ pageViewController: PageViewController, viewControllerForPageAt index: Int) -> UIViewController?

    /// ViewControllerに応じて、インデックスを返す
    func pageViewController(_ pageViewController: PageViewController, indexOf viewController: UIViewController) -> Int?
}
