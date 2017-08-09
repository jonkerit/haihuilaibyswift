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
    print("class:\(object_getClass(objcet))")
}
func print_Piont(_ point: CGPoint) -> Void{
    print("piont_x:\(point.x)\\piont_y:\(point.y)")
}
func print_Size(_ size: CGSize) -> Void {
    print("size_width:\(size.width)\\size_height:\(size.height)")
}
func print_Rect(_ rect: CGRect) -> Void {
    print("rect_x:\(rect.origin.x)\\rect_y:\(rect.origin.y)\\rect_width:\(rect.size.width)\\rect_hight:\(rect.size.height)")
}
// 获取沙河的文件夹地址
let PATH_OF_APP_HOME = NSHomeDirectory()
let PATH_OF_TEMP = NSTemporaryDirectory()
let PATH_OF_DOCUMENT = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
// 屏幕尺寸的定义
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT_MATCH = UIScreen.main.bounds.height / 667  // 以4.7寸屏为基准
let SCREEN_WIDTH_MATCH = UIScreen.main.bounds.width / 375
let APP_HEIGHT = UIScreen.main.applicationFrame.size.height
let APP_WIDTH = UIScreen.main.applicationFrame.size.width
let APP_HEIGHT_MATCH = UIScreen.main.applicationFrame.size.height / 667 // 以4.7寸屏为基准
let APP_WIDTH_MATCH = UIScreen.main.applicationFrame.size.width / 375

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
    return string!.isEmpty
}

func is_empty_array(_ array: [AnyObject]?) -> Bool {
    return (array!.count == 0 || array == nil) ? true : false
}
// 
func RGBCOLOR(_ r: Float, _ g: Float, _ b: Float) -> UIColor {
    return UIColor.init(colorLiteralRed: (r/255.0), green: (r/255.0), blue: (r/255.0), alpha: (1))
}
func RBGCOLOR(_ r: Float, _ g: Float, _ b: Float, _ a: Float) -> UIColor {
    return UIColor(colorLiteralRed: (r/255.0), green: (r/255.0), blue: (r/255.0), alpha: (a))
}

// 通知的定义

// 沙河存储的key的定义
let KEY_USER_ACCOUNT = "key_user_account" // 存储用户账户信息
// 关键字的定义
let HH_SERVER_URL = "http://test.haihuilai.com"
let SUCCESSFUL = "0000" // 返回成功
let HAIHUILAI = "还会来" // 重点字段
let HHMAINCOLOR = RGBCOLOR(92, 194, 216) // 主图色
let HHMAINDEEPCOLOR = RGBCOLOR(23, 4, 3)
