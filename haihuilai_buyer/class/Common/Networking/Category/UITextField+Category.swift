//
//  UITextField+Category.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/14.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
extension UITextField {
    convenience init(placeholders: String?, title: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        if title != nil {
            text = title
        }
        if placeholders != nil {
            placeholder = placeholders
        }
        if fontColor != nil {
            textColor = fontColor
        }
        if fontSize != nil {
            font = UIFont.systemFont(ofSize: fontSize!)
        }
    }
}
