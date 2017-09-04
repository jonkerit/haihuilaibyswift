//
//  HHHomeNoticeModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/4.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHHomeNoticeModel: NSObject {
    /// 消息数量
    var count: Int?
    /// 消息的名称
    var name: String?

    override init() {
        super.init()
    }
    
    init(dict: [String: Any]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    func homeList(arrayForDictionary:Array<Dictionary<String, Any>>) -> [HHHomeNoticeModel]? {
        var arrayM = [HHHomeNoticeModel]()
        for object in arrayForDictionary {
            let model = HHHomeNoticeModel.init(dict: object)
            arrayM.append(model)
        }
        return arrayM
    }

}
