//
//  TopTabController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class TopTabController: UIViewController {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    @IBOutlet fileprivate weak var childViewBaseView: UIView!
    
    /// クラス名
    static private let className = String(describing: TopTabController.self)

    fileprivate var pageViewController: PageViewController?
    
    /// タブに表示するタイトル
    fileprivate var titles: [String] = []
    
    /// 表示するViewController
    fileprivate var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        print(TopTabController.className + ": " + #function)
        
        super.viewDidLoad()
        setUpCollectionView()
        setUpPageViewController()
        
        // 最初のタブを選択状態にする
        selectTab(at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// データソースの設定
    func configure(dataSource: [(title: String, viewController: UIViewController)]) {
        print(TopTabController.className + ": " + #function)
        
        titles = dataSource.map { $0.title }
        viewControllers = dataSource.map { $0.viewController }
    }
    
    /// CollectionViewの設定
    private func setUpCollectionView() {
        print(TopTabController.className + ": " + #function)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        collectionView.isPrefetchingEnabled = false
        TopTabCell.resister(in: collectionView)
    }
    
    /// PageViewControllerの設定
    private func setUpPageViewController() {
        print(TopTabController.className + ": " + #function)
    
        pageViewController = PageViewController.create()
    
        guard let pageViewController = pageViewController else { return }
    
        pageViewController.pageViewControllerDelegate = self
        pageViewController.pageViewControllerDataSource = self
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        // 制約の追加
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: childViewBaseView.topAnchor, constant: 0).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: childViewBaseView.leadingAnchor, constant: 0).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: childViewBaseView.bottomAnchor, constant: 0).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: childViewBaseView.trailingAnchor, constant: 0).isActive = true
        pageViewController.view.setNeedsLayout()
        
        pageViewController.didMove(toParentViewController: self)
    }
    
    /// 指定したタブを選択状態にする
    fileprivate func selectTab(at index: Int){
        print(TopTabController.className + ": " + #function)
        
        // 引数のインデックスのチェック
        guard titles.indices.contains(index) else { return }
        
        // 全てのセルを非選択状態にする
        collectionView.visibleCells
            .flatMap { $0 as? TopTabCell }
            .forEach { $0.deselect() }
        
        // 指定されたインデックスのセルを選択状態にする
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.selectItem(at: indexPath,
                                  animated: true,
                                  scrollPosition: .centeredHorizontally)
        
        let cell = collectionView.cellForItem(at: indexPath) as? TopTabCell
        cell?.select()
    }
    
    /// 自身のインスタンスを生成する
    static func create() -> TopTabController {
        print(TopTabController.className + ": " + #function)
        
        let storyBoard = UIStoryboard(name: className, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: className) as! TopTabController
    }
}

extension TopTabController: PageViewControllerDelegate {
    /// ページが移動する直前
    func pageViewController(_ pageViewController: PageViewController, willPagingTo index: Int) {
        selectTab(at: index)
    }
}

extension TopTabController: PageViewControllerDataSource {
    /// インデックスに応じて表示するViewControllerを返す
    func pageViewController(_ pageViewController: PageViewController,
                            viewControllerForPageAt index: Int) -> UIViewController? {
        
        // 引数のインデックスのチェック
        guard viewControllers.indices.contains(index) else { return nil }
        return viewControllers[index]
    }
    
    /// ViewControllerに応じて、インデックスを返す
    func pageViewController(_ pageViewController: PageViewController, indexOf viewController: UIViewController) -> Int? {
        return viewControllers.index(of: viewController)
    }
}

extension TopTabController: UICollectionViewDelegate {
    
    /// セルが選択された時
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        selectTab(at: indexPath.row)
        
        // ページを移動する
        pageViewController?.paging(index: indexPath.row)
    }

    /// セルが選択解除された時
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TopTabCell
        cell?.deselect()
    }
}

extension TopTabController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabCell.className, for: indexPath) as? TopTabCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(title: titles[indexPath.row])
        return cell
    }
}

extension TopTabController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
