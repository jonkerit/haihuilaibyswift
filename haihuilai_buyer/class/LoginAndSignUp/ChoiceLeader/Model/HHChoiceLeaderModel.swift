//
//  HHChoiceLeaderModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/20.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceLeaderModel: NSObject {
    // 队长名字
    var fullname: String?
    // 队长的队名
    var team_name: String?
    // 队的ID
    var team_id: Int = 0
    // 服务区域
    var services: String?
    
    override init() {
        super.init()
    }
    init(dict:[String: Any]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func choiceLeaderArray(dictArray: [Any]) -> [HHChoiceLeaderModel] {
        var arrayM = [HHChoiceLeaderModel]()
        for object in dictArray {
            let newsModel = HHChoiceLeaderModel.init(dict: object as? [String : Any])
            let dict = object as! [String : Any]
            newsModel.team_id = dict["team_id"] as! Int
            arrayM.append(newsModel)
        }
        return arrayM
    }
}

