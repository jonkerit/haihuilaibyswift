//
//  HHAcountViewModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/15.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit
typealias HHNetworkDataBacks = (_ responses: Any?,_ errors: Error?) -> ()

class HHAccountViewModel: NSObject {
    // 创建一个单利
    static let shareAcount = HHAccountViewModel()

    
    var accountModel: HHAccountModel?
    
    var accountToken: String?{
        return accountModel?.user_token
    }
    var accountEmail: String?{
        return accountModel?.user_email
    }
    
    var isLogin: Bool{
        
        return accountToken != nil
    }
    
    override init(){
        super.init()
        accountModel = foundUserAccount()
    }
    func userLogin(urlString: String, paramters: [String: AnyObject], networkDataBacks: @escaping HHNetworkDataBacks) {
        HHNetworkTools.shareTools.request(isLogin: false, method: .POST, URLString: urlString, parameters: paramters, networkDataBack: { (response, error) -> Void in
            // 处理返回结果
            if response != nil {
                if response?["status"] as! String == SUCCESSFUL{
                    self.accountModel = HHAccountModel(dict: response?["data"] as! [String : AnyObject])
                    self.saveUseAccount(response?["data"] as! [String : AnyObject])
                    networkDataBacks(true,nil)
                }else{
                    networkDataBacks(response?["msg"],nil)
                }
            }else{
                networkDataBacks(nil,error)
            }
        })
    }
    
    // 保存登陆信息
    func saveUseAccount(_ dictionary: [String: AnyObject]) -> Void {
        UserDefaults.standard.setValue(dictionary, forKey: KEY_USER_ACCOUNT)
    }
    
    // 取出登陆信息
    func foundUserAccount() -> HHAccountModel? {
        let accountDic = UserDefaults.standard.value(forKey: KEY_USER_ACCOUNT) as? [String:AnyObject]
        
        if ((accountDic?.count) != nil) {
            return  HHAccountModel.init(dict: accountDic!)
        }else{
            //－－－－－－ 跳转到登陆界面
            
            
            return nil
        }
    }
    
}
