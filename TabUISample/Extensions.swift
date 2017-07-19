//
//  Extensions.swift
//  TabUISample
//
//  Created by Shota Nakagami on 2017/07/19.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import Foundation

// クラス名を取得する
extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}
