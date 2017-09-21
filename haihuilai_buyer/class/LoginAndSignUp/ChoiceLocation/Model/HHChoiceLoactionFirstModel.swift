//
//  HHChoiceLeaderModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/20.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceLoactionFirstModel: NSObject {
    // 地区ID
    var location_id: String?
    // 地区名字
    var location_name: String?
    override init() {
        super.init()
    }
    init(dict:[String: Any]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func choiceLoactionFirstArray(dictArray: [Any]) -> [HHChoiceLoactionFirstModel] {
        var arrayM = [HHChoiceLoactionFirstModel]()
        for object in dictArray {
            let newsModel = HHChoiceLoactionFirstModel.init(dict: object as? [String : Any])
            arrayM.append(newsModel)
        }
        return arrayM
    }
}
class HHChoiceLoactionSecondModel: NSObject {
    // 地区ID
    var location_id: String?
    // 地区名字
    var location_name: String?
    override init() {
        super.init()
    }
    init(dict:[String: Any]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func choiceLoactionSecondArray(dictArray: [Any]) -> [HHChoiceLoactionSecondModel] {
        var arrayM = [HHChoiceLoactionSecondModel]()
        for object in dictArray {
            let newsModel = HHChoiceLoactionSecondModel.init(dict: object as? [String : Any])
            arrayM.append(newsModel)
        }
        return arrayM
    }
}
class HHChoiceLoactionSonModel: NSObject {
    // 地区ID
    var location_id: String?
    // 地区名字
    var location_name: String?
    // 是否已选
    var has: Bool?
    override init() {
        super.init()
    }
    init(dict:[String: Any]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func choiceLoactionThirdSonArray(dictArray: [Any]) -> [HHChoiceLoactionSonModel] {
        var arrayM = [HHChoiceLoactionSonModel]()
        for object in dictArray {
            let newsModel = HHChoiceLoactionSonModel.init(dict: object as? [String : Any])
            arrayM.append(newsModel)
        }
        return arrayM
    }
}
class HHChoiceLoactionThirdModel: NSObject {
    // 地区ID
    var index: String?
    // 地区名字
    var locations: [HHChoiceLoactionSonModel]?

    override init() {
        super.init()
    }
    init(dict:[String: Any]?) {
        super.init()
        let arrayDic:[Any] = dict!["locations"] as! Array<Dictionary<String, Any>>
        var arrayM = [HHChoiceLoactionSonModel]()
        for object in arrayDic {
            let choiceModel:HHChoiceLoactionSonModel = HHChoiceLoactionSonModel.init(dict: object as! [String : AnyObject])
            
            arrayM.append(choiceModel)
        }
        setValuesForKeys(dict!)
        locations = arrayM
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func choiceLoactionThirdArray(dictArray: [Any]) -> [HHChoiceLoactionThirdModel] {
        var arrayM = [HHChoiceLoactionThirdModel]()
        for object in dictArray {
            let newsModel = HHChoiceLoactionThirdModel.init(dict: object as? [String : Any])
            arrayM.append(newsModel)
        }
        return arrayM
    }
}

