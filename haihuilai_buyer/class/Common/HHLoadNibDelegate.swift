//
//  HHLoadNib.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/9.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

protocol HHLoadNibDelegate: class {
    
}
extension HHLoadNibDelegate where Self : UIView {
    //在协议里面不允许定义class 只能定义static
    static func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
        
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
