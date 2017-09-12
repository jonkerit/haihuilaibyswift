//
//  HHHistoryModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/12.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHHistoryModel: NSObject {
    /// 类别中文
    var tag_name: String?
    /// 名字
    var content: String?
    /// 标示
    var tag: String?
    override init() {
        super.init()
    }
    init(dict:[String: AnyObject]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func getHistoryDataArray(dataArray: [AnyObject]?) -> [HHHistoryModel] {
        var arrayM = [HHHistoryModel]()
        for objcet in dataArray! {
            let model = HHHistoryModel.init(dict: objcet as? [String: AnyObject])
            arrayM.append(model)
        }
        return arrayM
    }
    
}
