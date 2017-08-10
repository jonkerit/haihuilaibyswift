//
//  HHNetworkClass.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHNetworkClass:NSObject {
//    static let networkClass = HHNetworkClass()
    
    func getCountryNumber(parameter: [String:AnyObject]?, networkClassData: @escaping HHNetworkDataBack){
        HHNetworkTools.shareTools.request(isLogin: false, method: .GET, URLString: "app/countries", parameters: parameter) {(response, error) in
            networkClassData(response, error)
        }
    }
    
}
