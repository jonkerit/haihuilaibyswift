//
//  UIButton+Extension.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/13.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit

extension UIButton {
    
    // 构成便利函数
    convenience init(title: String?, imageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
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
    }
    convenience init(title: String?, backgroudImageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if backgroudImageName != nil {
            setBackgroundImage(UIImage(named:backgroudImageName!), for: .normal)
        }
        if fontColor != nil {
            setTitleColor(fontColor, for: .normal)
        }
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
    }

    
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
    convenience init(action: Selector?,target: AnyObject, title: String?, backgroudImageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if backgroudImageName != nil {
            setBackgroundImage(UIImage(named: backgroudImageName!), for: .normal)
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

