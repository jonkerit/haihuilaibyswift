//
//  HHMotorCadeBookingModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/20.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMotorCadeDetailModel: NSObject {
    //  分组
    var date: String?{
        didSet{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            daysForDate = String(Calendar.current.component(.day, from: formatter.date(from: date!)!))
        }
    }

    // dd
    var daysForDate: String?
    // 订单的相关信息
    var bookings: [HHMotorCadeBookingModel]?
    // 是否有订单
    var booking: Bool?
    override init() {
        super.init()
    }
    init(dict: [String: AnyObject]) {
        super.init()
        let arrayDic:Array = dict["bookings"] as! Array<Dictionary<String, Any>>
        var arrayM = [HHMotorCadeBookingModel]()
        for object in arrayDic {
            let choiceModel:HHMotorCadeBookingModel = HHMotorCadeBookingModel.init(dict: object as [String : AnyObject])
            arrayM.append(choiceModel)
        }
        setValuesForKeys(dict)
        bookings = arrayM
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    func calendarModelWithArray(arrayForDictionary: Array<Dictionary<String, Any>>) -> Array<HHMotorCadeDetailModel> {
        var arrayM = [HHMotorCadeDetailModel]()
        for object in arrayForDictionary {
            let choiceCountryModel = HHMotorCadeDetailModel.init(dict: object as [String : AnyObject])
            arrayM.append(choiceCountryModel)
        }
        return arrayM
    }
}

class HHMotorCadeBookingModel: NSObject {
    /// 名称
    var title: String?
    /// 订单ID
    var booking_id: String?
    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        let keys = ["title", "booking_id"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
}
