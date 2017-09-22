//
//  HHAdvertisementController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/19.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHAdvertisementController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
        wait()
    }
    private func wait(){
        if HHAccountViewModel.shareAcount.isLogin {
            getStatus()
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_changeinto_rootController), object: "HHLoginController")
        }
    }
    private func setUI(){
        let imageView = UIImageView.init(imageName: "starting")
        imageView.frame = view.frame
        view.addSubview(imageView)
        
    }
    private func getStatus(){
        HHNetworkClass().getReviewStatus(parameter: nil) { (response, erorString) in
            var status:String?
            if SUCCESSFUL(response){
                status = response?["data"]?["review_status"] as? String
                self.switchToRootController(status: status)
                // 存储审核状态
                UserDefaults.standard.set(status, forKey: CHECK_STATUS_KEY)
            } else {
                self.addNetWorkAlterView()
            }
        }
    }
    private func addNetWorkAlterView(){
        let alertController: UIAlertController = UIAlertController.init(title: "服务器开小差了", message: "正在努力尝试连接中，可稍后重试", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "再等等看", style: .default, handler: { (alter) in
            self.getStatus()
        }))
        alertController.addAction(UIAlertAction.init(title: "退出", style: .cancel, handler: { (alter) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    private func switchToRootController(status: String?){
        var className: String?
        if status == "inactive" {
            className = "HHRewriteController"
        }else if status == "inactive" {
            className = "HHIndividualController"
        }else{
            className = "HHRewriteController"
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_changeinto_rootController), object: className)
    }
}
