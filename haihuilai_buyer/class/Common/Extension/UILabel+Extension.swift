//
//  UILabel+Extension.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/13.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(title: String, fontColor: UIColor, fontSize: CGFloat, alignment:NSTextAlignment) {
        self.init()
        text = title
        textColor = fontColor
        if fontSize > 0 {
            font = UIFont.systemFont(ofSize: fontSize)
        }
        textAlignment = alignment
    }
    

}
