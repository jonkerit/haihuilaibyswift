//
//  HHNetworkClass.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
typealias HHNetworkClassDataBack = (_ response: [String:AnyObject]?,_ error: Error?) -> ()

class HHNetworkClass:NSObject {
    static let networkClass = HHNetworkClass()
    var networkClassDataBack: HHNetworkClassDataBack?
    
    
    func getCountryNumber(parameter: [String:AnyObject]?, networkClassData: @escaping HHNetworkClassDataBack){
        HHNetworkTools.shareTools.request(isLogin: false, method: .GET, URLString: "app/countries", parameters: parameter) { [weak self](response, error) in
            self?.networkClassDataBack!(response, error)
        }
    }
    
    
}
