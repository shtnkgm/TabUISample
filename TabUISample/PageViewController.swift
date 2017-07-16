//
//  PageViewController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    /// デリゲート
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    /// 表示するViewControllerの配列
    fileprivate var pageViewControllers: [UIViewController] = []
    
    /// 現在のページインデックス
    fileprivate var currentPageIndex: Int {
        get {
            guard let currentViewController = viewControllers?.first,
                let index = pageViewControllers.index(of: currentViewController) else {
                return 0
            }
            return index
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        setUpViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 表示するViewControllerを初期化する
    private func setUpViewControllers() {
        let vc1 = CustomViewController.create()
        vc1.view.backgroundColor = UIColor(white: 1.0, alpha: 1)
        
        let vc2 = CustomViewController.create()
        vc2.view.backgroundColor = UIColor(white: 0.9, alpha: 1)

        let vc3 = CustomViewController.create()
        vc3.view.backgroundColor = UIColor(white: 0.8, alpha: 1)
        
        let vc4 = CustomViewController.create()
        vc4.view.backgroundColor = UIColor(white: 0.7, alpha: 1)
        
        let vc5 = CustomViewController.create()
        vc5.view.backgroundColor = UIColor(white: 0.6, alpha: 1)
        
        pageViewControllers = [vc1, vc2, vc3, vc4, vc5]
        
        // 最初に表示するViewControllerのみをセットする
        setViewControllers([vc1], direction: .forward, animated: false, completion: nil)
    }
    
    /// 指定したページへ移動する
    func paging(index: Int) {
        guard index != currentPageIndex && index < pageViewControllers.count else {
            return
        }
        
        // ページを移動する際の向き
        var direction: UIPageViewControllerNavigationDirection = .reverse
        if index > currentPageIndex {
            direction = .forward
        }
        
        let viewController = pageViewControllers[index]
        setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    /// ページを移動する直前
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        guard let viewController = pendingViewControllers.first,
            let index = pageViewControllers.index(of: viewController) else {
            return
        }
    
        pageViewControllerDelegate?.pageViewController(self, willPagingTo: index)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    /// ページを戻る場合のViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let pageIndex = pageViewControllers.index(of: viewController),
            pageIndex > 0 else {
            return nil
        }
        
        return pageViewControllers[pageIndex - 1]
    }
    
    /// ページを進む場合のViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let pageIndex = pageViewControllers.index(of: viewController),
            pageIndex < pageViewControllers.count - 1 else {
                return nil
        }
        
        return pageViewControllers[pageIndex + 1]
    }
}

protocol PageViewControllerDelegate: class {
    func pageViewController(_ pageViewController: PageViewController, willPagingTo index: Int)
}
