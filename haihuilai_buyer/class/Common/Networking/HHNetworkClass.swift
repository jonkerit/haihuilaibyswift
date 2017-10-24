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
    /// 获取搜索历史列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getHistoryResultList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/bookings/history_search", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHHistoryModel().getHistoryDataArray(dataArray: response!["data"] as? [AnyObject])
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
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/bookings/search", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHOrderModel().orderArrays(arrayForDictionary: response!["data"] as! [AnyObject])
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    /// 删除搜索历史
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func delegateHistoryOfSearch(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .POST, URLString: "app/bookings/history_search_remove", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

    /// 删除搜索历史
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getMessageContent(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/accounts/sms", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 注册发送验证码
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func sendTestNumber(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .POST, URLString: "app/suppliers/captcha", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func signUpAccount(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .POST, URLString: "app/suppliers", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

    /// 注册后填写信息（一）
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getPersonInfoFirst(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/accounts/user_info", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 对队长名字的搜索结果列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getSearchLeaderList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/teams/search", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHChoiceLeaderModel().choiceLeaderArray(dictArray: response!["data"]?["teams"] as! [AnyObject])
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    /// 区域的洲－列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getLocationFirstList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/locations/zones", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHChoiceLoactionFirstModel().choiceLoactionFirstArray(dictArray: response!["data"] as! [AnyObject])
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    /// 区域的国家－列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getLocationSecondList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/locations/countries_by_zone", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHChoiceLoactionSecondModel().choiceLoactionSecondArray(dictArray: response!["data"] as! [AnyObject])
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    /// 区域的地区－列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getLocationThirdList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/locations/cities_by_country", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHChoiceLoactionThirdModel().choiceLoactionThirdArray(dictArray: response!["data"]?["cities"] as! [AnyObject])
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

    /// 提交注册信息（第三步）
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func postPersonInfoThird(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .POST, URLString: "app/suppliers/info", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 注册后填写信息（二）
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getPersonInfoSecond(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/supplier_profiles/identification_auth", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 上传单张图片等附带信息
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func postImageInfo(parameter: [String:AnyObject]?, dataParameter:[String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.postData(isLogin: true, URLString: "app/supplier_profiles/pictures", parameters: parameter, dataDictionary: dataParameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 订单详情信息获取
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getDetailOrderInfo(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "/app/bookings/status", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 订单结束服务
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func postDetailOrderEnd(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .POST, URLString: "/app/bookings/finish_travelling", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 订单开始服务
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func postDetailOrderStart(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .POST, URLString: "/app/bookings/confirm_travelling", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 给邮箱发送行程单
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func postEmail(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .POST, URLString: "app/bookings/send_download", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 上传意见单
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func postOpinionImage(parameter: [String:AnyObject]?, dataParameter:[String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.postData(isLogin: true, URLString: "/app/bookings/opinion", parameters: parameter, dataDictionary: dataParameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    /// 上传行程变更单
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func postTravelChangeImage(parameter: [String:AnyObject]?, dataParameter:[String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.postData(isLogin: true, URLString: "app/bookings/travel_change_info", parameters: parameter, dataDictionary: dataParameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

    /// 临时导游列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getTempGuideList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/drivers", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHTempGuideMode().tempDriverList(arrayForDictionary: response!["data"] as! [AnyObject] as! Array<Dictionary<String, Any>>)
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

    /// 临时导游信息获取
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getTempGuideInfo(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/drivers/user_info", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

    /// 获取保险列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getInsuranceIist(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "/app/cars/insurances", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 车队导游信息获取
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getGuideInfo(parameter: [String:AnyObject], networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/driver_suppliers/info", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 获取导游的库存的列表
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getDriverStockList(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultBlock) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "/app/stocks/list", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                let dataArray = HHMotorCadeDetailModel().calendarModelWithArray(arrayForDictionary: response!["data"] as! [AnyObject] as! Array<Dictionary<String, Any>>)
                networkClassData(dataArray,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }
    
    /// 车队导游信息获取
    ///
    /// - Parameters:
    ///   - parameter: 参数
    ///   - networkClassData: 结果回调
    func getIncomeInfo(parameter: [String:AnyObject]?, networkClassData: @escaping HHResultDataBack) {
        HHNetworkTools.shareTools.request(isLogin: true, method: .GET, URLString: "app/transactions/money_info", parameters: parameter) { (response, error) in
            if SUCCESSFUL(response){
                networkClassData(response,nil)
            }else{
                networkClassData(nil, HHCommon.shareCommon.handleError(response, error))
            }
        }
    }

}
