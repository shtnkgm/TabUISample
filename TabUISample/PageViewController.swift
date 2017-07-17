//
//  PageViewController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    /// クラス名
    static let className = String(describing: PageViewController.self)
    
    /// デリゲート
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    /// データソース
    weak var pageViewControllerDataSource: PageViewControllerDataSource?
    
    /// 現在のページインデックス
    fileprivate var currentPageIndex: Int {
        get {
            guard let currentViewController = viewControllers?.first,
                let index = pageViewControllerDataSource?.pageViewController(self, indexOf: currentViewController) else {
                    return 0
            }
            return index
        }
    }
    
    override func viewDidLoad() {
        print(PageViewController.className + ": " + #function)
        
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        setUpViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(PageViewController.className + ": " + #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(PageViewController.className + ": " + #function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 表示するViewControllerを初期化する
    private func setUpViewControllers() {
        print(PageViewController.className + ": " + #function)
        
        guard let viewController = pageViewControllerDataSource?.pageViewController(self, viewControllerForPageAt: 0) else {
            return
        }
        
        // 最初に表示するViewControllerのみをセットする
        setViewControllers([viewController],
                           direction: .forward,
                           animated: false,
                           completion: nil)
    }
    
    /// 指定したページへ移動する
    func paging(index: Int) {
        print(PageViewController.className + ": " + #function)
        
        // 現在表示中であれば何もしない
        guard index != currentPageIndex else {
            return
        }
        
        // ページを移動する際の向き
        var direction: UIPageViewControllerNavigationDirection = .reverse
        if index > currentPageIndex {
            direction = .forward
        }
        
        guard let viewController = pageViewControllerDataSource?.pageViewController(self, viewControllerForPageAt: index) else {
            return
        }
        
        setViewControllers([viewController], direction: direction, animated: true, completion: nil)
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
        
        guard let index = pageViewControllerDataSource?.pageViewController(self, indexOf: viewController),
            index > 0 else {
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
