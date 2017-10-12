//
//  HHTempGuideMode.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/12.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHTempGuideMode: NSObject {
    // 车导的ID
    var driver_id: String?
    // 车导的姓名
    var driver_name: String?
    // 车导的电话
    var driver_mobile: String?
    //
    var driver_picture: String?
    // 已接过的微信
    var driver_weixin: Int?
    override init() {
        super.init()
    }
    init(dict: [String: Any]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func tempDriverList(arrayForDictionary:Array<Dictionary<String, Any>>) -> [HHTempGuideMode]? {
        var arrayM = [HHTempGuideMode]()
        for object in arrayForDictionary {
            let choiceCountryModel = HHTempGuideMode.init(dict: object)
            arrayM.append(choiceCountryModel)
        }
        return arrayM
    }
}
