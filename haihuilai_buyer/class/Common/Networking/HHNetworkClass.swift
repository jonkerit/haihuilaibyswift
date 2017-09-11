//
//  HHNetworkClass.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

typealias HHResultBlock = (_ dataArray:Array<Any>?, _ errorString:String?)->()
typealias HHResultDataBack = (_ response: [String:AnyObject]?, _ errorString:String?) -> ()

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
    
    /// 获取消息中心列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getNewsList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock){
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/notifications", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHNewsModel().newsDataArray(dictArray: response!["data"] as! [AnyObject])
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
    
    /// 获取审核状态
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getReviewStatus(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/suppliers/review_status", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response, nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 获取个人信息（粗略）
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getIndividualInfo(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/accounts/user_info", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response, nil)
                // 存储
            }else{
                // 取出存储数据
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 获取消息中心是否有未读消息
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getNotificationsAll_read(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/notifications/all_read", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response, nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

    /// 获取个人信息完整度情况
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getInfoViewList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/accounts/info_complete_rate", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response, nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    /// 获取搜索方式的列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getSearchMenuList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/bookings/search_list", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHMenuModel().getMenuDataArray(dataArray: response!["data"] as? [AnyObject])
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    /// 获取搜索结果列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getSearchResultList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/accounts/info_complete_rate", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHMotorcadeModel().driverList(arrayForDictionary: response!["data"] as! [AnyObject] as! Array<Dictionary<String, Any>>)
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }


}
