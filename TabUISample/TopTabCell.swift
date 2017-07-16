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
    
    static let className = String(describing: TopTabCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(title: String) {
        titleLabel.text = title
    }
    
    func select() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
    }
    
    func deselect() {
        self.backgroundColor = .white
    }
    
    static func resister(in collectionView: UICollectionView) {
        let cellNib = UINib(nibName: className, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
}
