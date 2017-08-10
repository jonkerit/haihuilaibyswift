//
//  HHChoiceCountryModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceCountryModel: NSObject {
    /// 内层模型
    var choiceModel: HHChoiceModel?
    /// 分组
    var index: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
}
