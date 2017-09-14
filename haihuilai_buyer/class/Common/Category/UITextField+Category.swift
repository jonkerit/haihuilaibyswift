//
//  UITextField+Category.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/14.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
extension UITextField {
    convenience init(action: Selector?,target: AnyObject, title: String?, imageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if imageName != nil {
            setImage(UIImage(named: imageName!), for: .normal)
        }
        if fontColor != nil {
            setTitleColor(fontColor, for: .normal)
        }
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
        if action != nil {
            addTarget(target, action: action!, for: .touchUpInside)
        }
    }
}
