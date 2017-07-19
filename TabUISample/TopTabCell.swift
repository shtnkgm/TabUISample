//
//  TopTabCell.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/16.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit

/// 上タブ用のカスタムセル
class TopTabCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var bottomBorderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// セルの設定
    func configure(title: String) {
        titleLabel.text = title

        if isSelected {
            select()
        } else {
            deselect()
        }

    }

    /// 選択状態にする
    func select() {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.textColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
            self?.bottomBorderView.isHidden = false
        }
    }

    /// 非選択状態にする
    func deselect() {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.textColor = .gray
            self?.bottomBorderView.isHidden = true
        }
    }

    /// CollectionViewにセルを登録する
    static func resister(in collectionView: UICollectionView) {
        let cellNib = UINib(nibName: className, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
}
