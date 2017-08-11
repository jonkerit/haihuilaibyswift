//
//  HHChoiceCountryModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceCountryModel: NSObject {
    /// 分组
    var index: String?
    /// 
    var countries: [HHChoiceModel]?

    override init() {
        super.init()
    }
    init(dict: [String: AnyObject]) {
        super.init()
        let arrayDic:Array = dict["countries"] as! Array<Dictionary<String, Any>>
        var arrayM = [HHChoiceModel]()
        for object in arrayDic {
            let choiceModel:HHChoiceModel = HHChoiceModel.init(dict: object as [String : AnyObject])

            arrayM.append(choiceModel)
        }
        setValuesForKeys(dict)
        countries = arrayM
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    func countryArrays(arrayForDictionary: Array<Dictionary<String, Any>>) -> Array<HHChoiceCountryModel> {
        var arrayM = [HHChoiceCountryModel]()
        for object in arrayForDictionary {
            let choiceCountryModel = HHChoiceCountryModel.init(dict: object as [String : AnyObject])
            arrayM.append(choiceCountryModel)
        }
        return arrayM
    }
    
}
