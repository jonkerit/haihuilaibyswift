//
//  HHCommon.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/13.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit
import AFNetworking
import MessageUI

typealias HHNetworkExameBack = (Int) -> () //或者 () -> Void
typealias HHContactOrderResult = (_ contentArray:[[HHInviteModel]]?, _ titleArray:[String]?) -> ()
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
    
    
    /// 返回一个table的header或者footer
    ///
    /// - Parameters:
    ///   - tableView: tableView
    ///   - section:
    /// - Returns: 一个view
    func createViewForHeaderView(_ tableView: UITableView,_ title:String,_ fontSize:CGFloat, _ fontColor: UIColor) -> UIView? {
        let backView = UIView()
        backView.backgroundColor = HHGRAYCOLOR()
        let label = UILabel.init(title: title, fontColor: fontColor, fontSize: fontSize, alignment: .left)
        backView.addSubview(label)
        label.mas_makeConstraints { (make) in
            make?.left.equalTo()(backView)?.setOffset(15)
            make!.centerY.equalTo()(backView)
        }
        return backView
    }

    
    /// 给一个数组分组排序
    ///
    /// - Parameters:
    ///   - inputArray: 需要排序的数组
    ///   - contactOrderResult: 返回的内容数组和标题数组
    func sequenceAndGroups(inputArray:[HHInviteModel]?, contactOrderResult:@escaping HHContactOrderResult){
        if inputArray == nil || inputArray?.count == 0 {
            return
        }
        // 排序分组的temp数组
        var tempArray = [[HHInviteModel]]()
        // 排序分组的结果数组
        var titleArray = [String]()
        //先将UILocalizedIndexedCollation初始化，
        let collation = UILocalizedIndexedCollation.current()
        
        //得出collation索引的数量，这里是27个（26个字母和1个#）
        let collationCount = collation.sectionTitles.count
        
         //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
        
        for _ in 0..<collationCount {
            let array = [HHInviteModel]()
            tempArray.append(array)
        }
        //将每个人按name分到某个section下
        for inviteModel in inputArray! {
            let sectionNumber = collation.section(for: inviteModel, collationStringSelector: #selector(getter: inviteModel.inviteName))
            tempArray[sectionNumber].append(inviteModel)
        }
        //对每个section中的数组按照name属性排序
        for i in 0..<collationCount {
            let sonArray = tempArray[i]
            if sonArray.count > 0 {
                let sortedArrayForSection = collation.sortedArray(from: sonArray, collationStringSelector: #selector(getter: HHInviteModel.inviteName))
                tempArray[i] = sortedArrayForSection as! [HHInviteModel]
                titleArray.append(collation.sectionIndexTitles[i])
            }
        }
        
        // 删除tempArray中的空元素
        // 排序分组的结果数组
        var resultArray = [[HHInviteModel]]()
        for objt in tempArray {
            if objt.count > 0 {
                resultArray.append(objt)
            }
        }
        contactOrderResult(resultArray, titleArray)
    }
    
    
    /// 给label下划线和给定范围颜色
    ///
    /// - Parameters:
    ///   - inputString: 目标字符串
    ///   - fontColor: 范围颜色
    ///   - ColorRange: 给定范围
    /// - Returns: NSAttributedString
    func drawLineForString(inputString: String, fontColor: UIColor,ColorRange: NSRange) -> NSAttributedString {
        //设置文字颜色成蓝色，富文本别的设置也几乎就是在这个字典中设置
        let myAttrString = NSMutableAttributedString.init(string: inputString)
            myAttrString.setAttributes([NSForegroundColorAttributeName : fontColor,NSUnderlineStyleAttributeName:1], range: ColorRange)
        return myAttrString
    }
    
    /// 判断邮箱的正则
    ///
    /// - Parameter email: 邮箱
    /// - Returns: 结果
    func validateEmail(email: String?) -> Bool{
        let pattern = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: email!, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, (email?.characters.count)!))
        if res.count > 0 {
            return true
        }
        return false

    }
    /// 判断电话的正则
    ///
    /// - Parameter email: 电话号码
    /// - Returns: 结果
    func checkPhoneNumber(str:String)->Bool {
        let pattern = "1[3578]\\d{9}"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, str.characters.count))
        if res.count > 0 {
            return true
        }
        return false
    }
    
    /// 获取1970年到现在的年份的数组
    func fromNowTo1970YearsArray() -> [String] {
        var dateArray = [String]()
        let ndf = DateFormatter.init()
        ndf.dateFormat = "yyyy"
        var now = Date()
        
        var dateString = ndf.string(from: now)
        dateArray.append(dateString+"年")
        var dateComponents = DateComponents()
        dateComponents.year = -1
        
        while Int(dateString)! > 1970 {
            now = NSCalendar.current.date(byAdding: dateComponents, to: now)!
            dateString = ndf.string(from: now)
            dateArray.append(dateString+"年")
        }
        return dateArray
    }
    
    /// 截取字符串
    ///
    /// - inputString: 电话号码
    /// - start: 开始位置
    /// = end: 结束位置
    func subString(inputString: String,start:Int, end:Int)->String {
        let StartIndex = inputString.index(inputString.startIndex, offsetBy: start)
        let str = inputString.substring(from: StartIndex)
        let endNumber = inputString.characters.count - end - 1
        let endIndex = str.index(str.endIndex, offsetBy:-endNumber)
        return str.substring(to: endIndex)
    }
    
    func compressImage(inputImage: UIImage, newWidth: CGFloat) -> UIImage{
        // 原图片的尺寸
        let imageWidth = inputImage.size.width
        let imageHeight = inputImage.size.height
        //  与目标尺寸的比例
        let newHight = inputImage.size.height / (inputImage.size.width/newWidth)
        let scaleWidth = imageWidth / newWidth
        let scaleHeight = imageHeight / newHight
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height:newHight))
        if scaleWidth > scaleHeight {
            inputImage.draw(in: CGRect(x:0, y:0, width: imageWidth / scaleHeight, height:newHight))
        } else {
            inputImage.draw(in: CGRect(x:0, y:0, width: imageWidth, height: newHight / scaleWidth))
        }
         // 从当前context中创建一个改变大小后的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
