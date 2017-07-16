//
//  PageViewController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    fileprivate var pageViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        setUpViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpViewControllers() {
        let firstVC = CustomViewController.create()
        firstVC.view.backgroundColor = .blue
        pageViewControllers.append(firstVC)
        let secondVC = CustomViewController.create()
        secondVC.view.backgroundColor = .black
        pageViewControllers.append(secondVC)
        let thirdVC = CustomViewController.create()
        thirdVC.view.backgroundColor = .purple
        pageViewControllers.append(thirdVC)
        
        setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let pageIndex = pageViewControllers.index(of: viewController),
            pageIndex > 0 else {
            return nil
        }
        
        return pageViewControllers[pageIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let pageIndex = pageViewControllers.index(of: viewController),
            pageIndex < pageViewControllers.count - 1 else {
                return nil
        }
        
        return pageViewControllers[pageIndex + 1]
    }
}
