//
//  HeaderFile.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/15.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import Foundation
import UIKit

// 打印的宏定义
func print_Class(_ objcet: AnyObject) -> Void {
    #if DEBUG
    print("class:\(object_getClass(objcet))")
    #endif
}
func print_Piont(_ point: CGPoint) -> Void{
    #if DEBUG
    print("piont_x:\(point.x)\\piont_y:\(point.y)")
    #endif
}
func print_Size(_ size: CGSize) -> Void {
    #if DEBUG
    print("size_width:\(size.width)\\size_height:\(size.height)")
    #endif
}
func print_Rect(_ rect: CGRect) -> Void {
    #if DEBUG
    print("rect_x:\(rect.origin.x)\\rect_y:\(rect.origin.y)\\rect_width:\(rect.size.width)\\rect_hight:\(rect.size.height)")
    #endif
}
func HHPrint(_ some: Any) -> Void {
    #if DEBUG
        print(some)
    #endif
}
// 获取沙河的文件夹地址
let PATH_OF_APP_HOME = NSHomeDirectory()
let PATH_OF_TEMP = NSTemporaryDirectory()
let PATH_OF_DOCUMENT = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
// 沙河存储key
let CHECK_STATUS_KEY = "checkStatusKey" // 审核状态（1:pending_review审核中,2:reviewed通过,3:refused拒绝,4:inactive未激活 ）
let INDIVIDUAL_KEY = "individualKey" // 存储个人信息
// 屏幕尺寸的定义
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT_MATCH = UIScreen.main.bounds.height / 667  // 以4.7寸屏为基准
let SCREEN_WIDTH_MATCH = UIScreen.main.bounds.width / 375
let APP_HEIGHT = UIScreen.main.bounds.size.height
let APP_WIDTH = UIScreen.main.bounds.size.width
let APP_HEIGHT_MATCH = UIScreen.main.bounds.size.height / 667 // 以4.7寸屏为基准
let APP_WIDTH_MATCH = UIScreen.main.bounds.size.width / 375

// view的各个尺寸的定义
func x(_ object: UIView) -> CGFont{
    return object.frame.origin.x as! CGFont
}
func y(_ object: UIView) -> CGFont{
    return object.frame.origin.y as! CGFont
}
func w(_ object: UIView) -> CGFont{
    return object.frame.size.width as! CGFont
}
func h(_ object: UIView) -> CGFont{
    return object.frame.size.height as! CGFont
}

// 判断object是否为空
func is_empty_string(_ string: String?) -> Bool{
    if string == nil || string == "" {
        return true
    }else{
        return false
    }
}

func is_empty_array(_ array: [AnyObject]?) -> Bool {
    return (array!.count == 0 || array == nil) ? true : false
}
// 
func RGBCOLOR(_ r: Float, _ g: Float, _ b: Float) -> UIColor {
    return UIColor.init(colorLiteralRed: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: (1))
}
func RBGCOLOR(_ r: Float, _ g: Float, _ b: Float, _ a: Float) -> UIColor {
    return UIColor.init(colorLiteralRed: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: (a))
}
// 主题灰
func HHGRAYCOLOR() -> UIColor {
    return UIColor.init(colorLiteralRed: (243/255.0), green: (243/255.0), blue: (243/255.0), alpha: (1))
}
// 主题色
func HHMAINCOLOR() -> UIColor {
    return UIColor.init(colorLiteralRed: (92/255.0), green: (194/255.0), blue: (216/255.0), alpha: (1))
}
// 点击主题色
func HHMAINDEEPCOLOR() -> UIColor {
    return UIColor.init(colorLiteralRed: (26/255.0), green: (183/255.0), blue: (205/255.0), alpha: (1))
}
//字体颜色-黑体
func HHWORDCOLOR() -> UIColor {
    return UIColor.init(colorLiteralRed: (74/255.0), green: (74/255.0), blue: (74/255.0), alpha: (1))
}
//字体颜色-灰体
func HHWORDGAYCOLOR() -> UIColor {
    return UIColor.init(colorLiteralRed: (155/255.0), green: (155/255.0), blue: (155/255.0), alpha: (1))
}
// 橙红
func HHMAINREDCOLOR() -> UIColor {
    return UIColor.init(colorLiteralRed: (237/255.0), green: (78/255.0), blue: (78/255.0), alpha: (1))
}


// 判断网络请求是否返回成功
func SUCCESSFUL(_ dataDic: [String: AnyObject]?) -> Bool{
    if dataDic == nil {
        return false
    }else{
        return dataDic?["status"] as! String == "0000"
    }
}
// 获取主屏幕
let HHKeyWindow = UIApplication.shared.keyWindow
// 获取当前版本号
let HHEditionVision = Bundle.main.infoDictionary?["CFBundleShortVersionString"]

// 通知的定义
let notification_country_number = "NotificationForCountryNumber" // 选择国家码通知
let notification_changeinto_rootController = "Notification_changeIntoRootController" // 改变根目录
let notification_choiceLeader = "Notification_choiceLeader" // 选择车队
let notification_choiceLocation = "notification_choiceLocation" // 选择居住地
let notification_CalenderBtn = "notification_CalenderBtn" // 传递日历的点击事件

// 沙河存储的key的定义
let KEY_USER_ACCOUNT = "key_user_account" // 存储用户账户信息
// 关键字的定
#if DEBUG
let HH_SERVER_URL = "http://test.haihuilai.com"
#else
let HH_SERVER_URL = "http://www.haihuilai.com"
#endif

let HAIHUILAI = "还会来" // 重点字段
let iOSLoadOrderEnclosure = "iOSLoadOrderEnclosure" // 获取附件

// 开发环境打印
