//
//  HHChoiceModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceModel: NSObject {
    /// 国家名称
    var name: String?
    /// 国家编码
    var val: String?
    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        let keys = ["val", "name"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
