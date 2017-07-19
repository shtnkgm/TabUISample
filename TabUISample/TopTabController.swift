//
//  TopTabController.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

/// 上タブを管理するクラス
class TopTabController: UIViewController {

    /// タブ表示のためのコレクションビュー
    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    /// ChildVCのframeを設定するためのView
    @IBOutlet fileprivate weak var childViewBaseView: UIView!

    /// 上タブデータ
    fileprivate var topTabItems = [TopTabItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageViewController()

        // 最初のタブを選択状態にする
        selectTab(at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// 上タブデータの設定
    func configure(topTabItems: [TopTabItem]) {
        self.topTabItems = topTabItems
    }

    /// CollectionViewの設定
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        // タブの複数選択を禁止
        collectionView.allowsMultipleSelection = false

        // 画面外のセルの先読みを禁止
        collectionView.isPrefetchingEnabled = false

        // カスタムセルの登録
        TopTabCell.resister(in: collectionView)
    }

    /// PageViewControllerの設定
    private func setupPageViewController() {
        let pageViewController = PageViewController.create()
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
    fileprivate func selectTab(at index: Int) {
        // 引数のインデックスのチェック
        guard topTabItems.indices.contains(index) else { return }

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

extension TopTabController: PageViewControllerDataSource {
    /// インデックスに応じて表示するViewControllerを返す
    func pageViewController(_ pageViewController: PageViewController,
                            viewControllerForPageAt index: Int) -> UIViewController? {

        // 引数のインデックスのチェック
        guard topTabItems.indices.contains(index) else { return nil }
        return topTabItems[index].viewController
    }

    /// ViewControllerに応じて、インデックスを返す
    func pageViewController(_ pageViewController: PageViewController, indexOf viewController: UIViewController) -> Int? {
        let viewControllers = topTabItems.map { $0.viewController }
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
        let pageViewController = childViewControllers.flatMap { $0 as? PageViewController }.first
        pageViewController?.move(to: indexPath.row)
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
        return topTabItems.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabCell.className, for: indexPath) as? TopTabCell else {
            return UICollectionViewCell()
        }

        cell.configure(title: topTabItems[indexPath.row].title)
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
