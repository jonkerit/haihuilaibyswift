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
    func networkExamineInViewNONoticeWithResult(NetworkExameBack: HHNetworkExameBack){
        let manger = AFNetworkReachabilityManager.shared()
        manger?.setReachabilityStatusChange({ (networkReachabilityStatus) in
            
        })
        manger?.startMonitoring()
    }
    
    /// 网络请求错误信息返回
    ///
    /// - Parameters:
    ///   - resultDictionary: 网络请求的返回结果字典
    ///   - error: 返回的错误
    /// - Returns: 错误提示的String
    func handleError(_ resultDictionary: [String: AnyObject]?, _ error: Error?) -> String? {
        if error != nil {
            if error?.localizedDescription == "The request timed out." {
                return "网络请求超时"
            } else {
                return error?.localizedDescription ?? "网络未知错误"
            }
        } else if resultDictionary != nil || (resultDictionary?.count)!>0 {
            let resultString = resultDictionary?["status"] as! String
            if is_empty_string(resultString){
                return "网络未知错误"
            } else {
                if SUCCESSFUL(resultDictionary) {
                    return nil;
                } else {
                    // 重新登录
                    if resultDictionary?["status"]as! String == "8888" {
                        // todo 
                        
                        return resultDictionary?["msg"] as? String
                    }
                    let errorDictionary = ["0000":"成功", "4001":"缺少参数", "4002":"验证码发送失败", "4003":"验证码验证失败", "4004":"type错误", "4005":"用户已经存在", "4006":"创建用户失败", "4007":"用户名或密码错误", "4008":"此状态无法修改信息", "4009":"此用户未注册", "4010":"上传图片错误", "4011":"开始服务失败", "4012":"创建导游错误", "4013":"分配导游错误",  "4014": "创建账户失败",  "4015": "已经有账户",  "4016": "没有账户",  "4017": "不是队长",  "4018": "没有这个车队",  "4019": "队长无法加入车队",  "4020": "已经加入过车队",  "4021": "加入车队失败",  "4022": "没有交易记录",  "4023": "提现错误",  "4024": "提现金额错误",  "4025": "车导不存在",  "4026": "没有权限",  "4027": "不是车导游, 无法设置",  "4028": "没有交易记录",  "4029": "删除成员失败",  "4030": "保存设备id失败",  "4031": "更新失败",  "4032": "导游不存在",  "4033": "无法访问此订单",  "4034": "此导游有正在服务的订单",  "4035": "车辆库存记录不存在",  "4036": "添加服务区域失败",  "4037": "车辆类型不存在",  "4038": "车辆类型已存在",  "4039": "当前用户没权限",  "4040": "没有消息记录",  "4041": "没有版本记录",  "4042": "当前用户改派导游机会已用完",  "4043": "当前订单改派导游已用完",  "4044": "不能删除,导游已经有接单了!谢谢",  "4045": "没有这个临时车导",  "4046": "不能删除,导游已经有接单了!谢谢",  "4047": "车辆记录不存在",  "4048": "对应订单无法结束",  "4049": "队长当前无车队"]
                    if errorDictionary[resultString] == nil {
                        if resultDictionary?["msg"] == nil {
                            return "网络未知错误"
                        }else{
                            return resultDictionary?["msg"] as! String?
                        }
                    } else {
                        return errorDictionary[resultString]
                    }
                }
            }
        }else{
            return "网络未知错误"
        }
    }
    
    
    /// 获取字符串的尺寸
    ///
    /// - Parameters:
    ///   - inputString: 目标字符串
    ///   - fontSize: 字符串的字体大小
    ///   - MAXSize: 最大宽度
    /// - Returns: 返回尺寸
    func obtainStringLength(_ inputString: String?, _ fontSize: CGFloat, _ MAXSize:CGSize) -> CGSize {
        if is_empty_string(inputString) {
            return CGSize(width: 0,height: 0)
        } else {
            let StringRect = inputString?.boundingRect(with: MAXSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context:nil)
            return StringRect!.size
        }
    }
    
    /// 清理app缓存
    func handleClearAPP(){
        //删除三部分
        //1.删除 sd 图片缓存
        //先清除内存中的图片缓存
        SDImageCache.shared().clearMemory()
        //清除磁盘的缓存
        SDImageCache.shared().cleanDisk()
        //2.删除自己缓存
        let myCachePath = NSHomeDirectory() + "Library/Caches"
        do {
            try  FileManager.default.removeItem(atPath: myCachePath)
        } catch {
            print("清除磁盘的缓存失败")
        }
        //3.清除所有的存储本地的数据
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        // 记录版本号(HHUserDefaults 里面的版本号和判断是否第一次使用APP的key不能清除)

    }
    
}
