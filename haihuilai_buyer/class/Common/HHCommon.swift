//
//  HHCommon.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/13.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit
import AFNetworking

typealias HHNetworkExameBack = (Int) -> () //或者 () -> Void

class HHCommon: NSObject {
    // 单例
    static let shareCommon = HHCommon()
    
    /*
    AFN etworkReachabilityStatusUnknown          = -1,未知
    AFNetworkReachabilityStatusNotReachable     = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetw
    */
    
    
    /// 监测网络状态 AFNetworkReachabilityStatusUnknown = -1,未知;AFNetworkReachabilityStatusNotReachable     = 0,没有网络
    private func networkExamineInViewNONoticeWithResult(NetworkExameBack: HHNetworkExameBack){
        let manger = AFNetworkReachabilityManager.shared()
        manger?.setReachabilityStatusChange({ (networkReachabilityStatus) in
            
        })
        manger?.startMonitoring()
    }
}
