//
//  TopTabCell.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

class TopTabCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    /// クラス名
    static let className = String(describing: TopTabCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// セルの設定
    func configure(title: String) {
        titleLabel.text = title
    }
    
    /// 選択状態にする
    func select() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundColor = UIColor(white: 0, alpha: 0.1)
        }
    }
    
    /// 非選択状態にする
    func deselect() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundColor = .white
        }
    }
    
    /// CollectionViewにセルを登録する
    static func resister(in collectionView: UICollectionView) {
        let cellNib = UINib(nibName: className, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
}
