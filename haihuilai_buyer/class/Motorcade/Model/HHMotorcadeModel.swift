//
//  HHMotorcadeModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMotorcadeModel: NSObject {
    // 车导的ID
    var driver_supplier_id: String?
    // 车导的电话
    var driver_supplier_mobile: String?
    // 车导的姓名
    var driver_supplier_name: String?
    // 库存量
    var has_stock: String?
    // 已接过的单量
    var bookings_count: Int?
    override init() {
        super.init()
    }
    init(dict: [String: Any]?) {
        super.init()
        setValuesForKeys(dict!)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    func driverList(arrayForDictionary:Array<Dictionary<String, Any>>) -> [HHMotorcadeModel]? {
        var arrayM = [HHMotorcadeModel]()
        for object in arrayForDictionary {
            let choiceCountryModel = HHMotorcadeModel.init(dict: object)
            arrayM.append(choiceCountryModel)
        }
        return arrayM
    }
    
}
