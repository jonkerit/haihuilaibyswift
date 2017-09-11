//
//  HHNewsModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/8.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHNewsModel: NSObject {
    // 消息内容
    var content: String?
    // 消息neir
    var n_id: String?
    // 消息neir
    var open_id: Int?
    // 消息neir
    var subject: String?
    // 消息neir
    var open: String?
    // 消息neir
    var is_read: String?
    // 消息neir
    var date: String?
    
    override init() {
        super.init()
    }
    init(dict:[String: AnyObject]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func newsDataArray(dictArray: [AnyObject]) -> [HHNewsModel] {
        var arrayM = [HHNewsModel]()
        for object in dictArray {
            let newsModel = HHNewsModel.init(dict: object as? [String : AnyObject])
            arrayM.append(newsModel)
        }
        return arrayM
    }
    
}
