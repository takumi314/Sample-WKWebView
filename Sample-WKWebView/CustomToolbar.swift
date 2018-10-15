//
//  CustomToolbar.swift
//  Sample-WKWebView
//
//  Created by NishiokaKohei on 2018/10/16.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import UIKit

class CustomToolbar: UIToolbar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    func setup() {
        // バーの色
        self.barTintColor = UIColor.orange
        // アイテムの色
        self.tintColor = UIColor.white
    }

}
