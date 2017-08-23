//
//  HHNetworking.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/14.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit
import AFNetworking

/// 枚举网络方式
enum RequestMethod: String{
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
    case PATCH = "PATCH"
}

/// 定义一个闭包
typealias HHNetworkDataBack = (_ response: [String:AnyObject]?,_ error: Error?) -> ()

class HHNetworkTools: AFHTTPSessionManager {    
    // 建立一个网络单利baseURL:URL.init(string: "http://test.haihuilai.com")
    static let shareTools: HHNetworkTools = {
        var instace = HHNetworkTools(baseURL: URL(string: HH_SERVER_URL))
//        print(instace?.responseSerializer.acceptableContentTypes ?? "NO")
        return instace!
    }()
    
    
    
    
    /// 一般网络请求
    ///
    /// - Parameters:
    ///   - isLogin: 是否需要登录信息
    ///   - method: 网络请求方式
    ///   - URLString: 地址
    ///   - parameters: 参数
    ///   - networkDataBack: 数据回调
    func request(isLogin: Bool, method: RequestMethod, URLString: String, parameters: [String: AnyObject]?, networkDataBack: @escaping HHNetworkDataBack){
        // 判空字典
        var parameter = [String: AnyObject]()
        if parameters != nil {
            parameter = parameters!
        }
        // 是否含有登陆信息
        if isLogin {
            let version:String = "Ios_" + (HHEditionVision as! String)
           parameter.updateValue(HHAccountViewModel.shareAcount.accountEmail as AnyObject, forKey: "user_email")
           parameter.updateValue(HHAccountViewModel.shareAcount.accountToken as AnyObject, forKey: "user_token")
           parameter.updateValue(HHAccountViewModel.shareAcount.accountModel?.user_type as AnyObject, forKey: "user_type")
            parameter.updateValue(version as AnyObject, forKey: "version")
        }
        
        // 1. 成功的回调闭包
       let  success = { (dataTask: URLSessionDataTask?, responseObject: Any?) -> Void in
            networkDataBack(responseObject as! [String:AnyObject]?, nil)
        }
        // 失败回调包
        let failure = { (dataTask: URLSessionDataTask?, error: Error?) -> Void in
            networkDataBack(nil, error)
        }
        
        switch method {
        case .GET:
            get(URLString, parameters: parameter, success: success , failure: failure)
            break
        case .POST:
            post(URLString, parameters: parameter, success: success, failure: failure)
            break
        case .PUT:
            put(URLString, parameters: parameter, success: success, failure: failure)
            break
        case .PATCH:
            patch(URLString, parameters: parameter, success: success, failure: failure)
            break
        case .DELETE:
            delete(URLString, parameters: parameter, success: success, failure: failure)
            break
//        default:
//            break
        }
    }
    
    /// 多文件的网络上传
    ///
    /// - Parameters:
    ///   - URLString: 地址
    ///   - parameters: 参数
    ///   - dataDictionary: 上传的数据的字典（用文件file地址，扩展性好）
    ///   - networkDataBack: 回调
    func postData(URLString: String, parameters: [String: AnyObject]?, dataDictionary: [String: AnyObject],networkDataBack: @escaping HHNetworkDataBack) {
        // 1. 成功的回调闭包
        let  success = { (dataTask: URLSessionDataTask?, responseObject: Any?) -> Void in
            networkDataBack(responseObject as! [String:AnyObject]?, nil)
        }
        // 失败回调包
        let failure = { (dataTask: URLSessionDataTask?, error: Error?) -> Void in
            networkDataBack(nil, error)
        }
        post(URLString, parameters: parameters, constructingBodyWith: { (formData) -> Void in
            let nsDic:NSDictionary = NSDictionary(dictionary: dataDictionary)
            for (key, obj) in nsDic {
                // 创建文件名称
                let keyName = key as! String
                let fileName = keyName.appending("file")
                // 带异常处理的（throws）
                do {
                  try formData?.appendPart(withFileURL: URL(string: obj as! String), name: keyName, fileName: fileName, mimeType: "application/octet-stream")
                } catch {
                    print(error)
                    return
                }
            }
        }, success: success, failure: failure)
    }
}
