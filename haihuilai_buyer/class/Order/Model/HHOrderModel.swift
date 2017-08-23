//
//  HHOrderModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHOrderModel: NSObject {
    var booking_id: String?
    var dates: String?
    var locations: String?
    var driver_name: String?
    var priend_placece: String?
    var locale_price: String?
    var status: String?
    var status_cn: String?
    var url: String?
    var end_place: String?
    var type_en: String?
    var type: String?
    var channel: String?
    var has_driver_supplier: Bool?
    var is_change_info: Bool?
    var is_upload_opinion: Bool?
    
    override init() {
        super.init()
    }
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    func orderArrays(arrayForDictionary: [AnyObject]) -> [HHOrderModel] {
        var arrayM = [HHOrderModel]()
        for object in arrayForDictionary {
            let orderModel = HHOrderModel.init(dict: object as! [String : AnyObject])
            arrayM.append(orderModel)
        }
        return arrayM
    }
    

}
