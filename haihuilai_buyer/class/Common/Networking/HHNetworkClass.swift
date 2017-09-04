//
//  HHNetworkClass.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

typealias HHResultBlock = (_ dataArray:Array<Any>?, _ errorString:String?)->()
import UIKit

class HHNetworkClass:NSObject {

    /// 获取国家编码
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getCountryNumber(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock){
        HHNetworkTools.shareTools.request(isLogin: false, method: .GET, URLString: "/app/countries", parameters: parameter) {(response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHChoiceCountryModel().countryArrays(arrayForDictionary: response!["data"] as! Array<Dictionary<String, Any>>)
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 获取订单列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getOrderList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock){
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "/app/bookings", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHOrderModel().orderArrays(arrayForDictionary: response!["data"] as! [AnyObject])
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 获取导游列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getDriverList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/driver_suppliers", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHMotorcadeModel().driverList(arrayForDictionary: response!["data"] as! [AnyObject] as! Array<Dictionary<String, Any>>)
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 获取全球合伙人列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getHomeList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/guides/notifier", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHHomeNoticeModel().homeList(arrayForDictionary: response?["data"]! as! Array<Dictionary<String, Any>>)
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
}
