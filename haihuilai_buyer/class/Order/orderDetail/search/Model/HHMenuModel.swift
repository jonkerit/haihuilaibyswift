//
//  HHMenuModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMenuModel: NSObject {
    /// 标题
    var alert: String?
    /// placeHolder
    var content: String?
    /// 标示
    var tag: String?
    override init() {
        super.init()
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    init(dict:[String: AnyObject]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    func getMenuDataArray(dataArray: [AnyObject]?) -> [HHMenuModel] {
        var arrayM = [HHMenuModel]()
        for objcet in dataArray! {
            let model = HHMenuModel.init(dict: objcet as? [String: AnyObject])
            arrayM.append(model)
        }
        return arrayM
    }
}
