//
//  HHAccountModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/15.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit

class HHAccountModel: NSObject {
    // 用户的帐号
    var user_email: String?
    // token值
    var user_token: String?
    // 用户的类型
    var user_type: String?
    // 过期日期（暂时不用）
//    var expiredData: String?
    
    //  KVC
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override var description: String{
        let keys = ["user_email", "user_token", "user_type"]
        return "\(dictionaryWithValues(forKeys: keys))"
    }
    
    // 给空值赋值
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
