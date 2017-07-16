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
    
    /// クラス名
    static let className = String(describing: TopTabController.self)
    
    /// PageViewControllerを取得する
    fileprivate var pageViewController: PageViewController? {
        get {
            return childViewControllers.flatMap { $0 as? PageViewController }.first
        }
    }
    
    /// タブに表示するタイトル
    fileprivate var tabTitles: [String] = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpPageViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectTab(at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// CollectionViewの設定
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        TopTabCell.resister(in: collectionView)
    }
    
    /// PageViewControllerの設定
    private func setUpPageViewController() {
        pageViewController?.pageViewControllerDelegate = self
    }
    
    /// 指定したタブを選択状態にする
    fileprivate func selectTab(at index: Int){
        guard index >= 0 && index < tabTitles.count else {
            return
        }
        
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
        return tabTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabCell.className, for: indexPath) as? TopTabCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(title: tabTitles[indexPath.row])
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
