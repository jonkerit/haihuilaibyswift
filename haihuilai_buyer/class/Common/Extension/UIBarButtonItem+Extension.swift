//
//  UIBarButtonItem+Extension.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/13.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title: String, imageName: String, target: Any?, action: Selector) {
        self.init()
        let btn = UIButton.init()
        btn.titleLabel?.text = title
        btn.sizeToFit()
        if !imageName.isEmpty {
            btn.setImage(UIImage(named:imageName), for: .normal)
        }
        btn.addTarget(target, action: action, for: .allTouchEvents)
        customView = btn
    }
    convenience init(title: String, imageName: String, target: Any?) {
        self.init()
        let btn = UIButton.init()
        btn.titleLabel?.text = title
        btn.sizeToFit()
        if !imageName.isEmpty {
            btn.setImage(UIImage(named:imageName), for: .normal)
        }
        customView = btn
    }

}
