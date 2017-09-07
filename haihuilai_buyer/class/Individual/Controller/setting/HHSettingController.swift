//
//  HHSettingController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/7.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHSettingController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
    }
    private func setUI(){
        let labelOne = UILabel.init(title: "订单行程同步手机日历", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        let labelTwo = UILabel.init(title: "关于我们", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        let labelLine = UILabel()
        labelLine.backgroundColor = HHGRAYCOLOR()
        let imageView = UIImageView.init(imageName: "DL-jt")
        let backView = UIView()
        backView.backgroundColor = HHGRAYCOLOR()
        let signOutBtn = UIButton.init(action: #selector(HHSettingController.signOut), target: self, title: "推出登录", backgroudImageName: "main_dark", fontColor: UIColor.white, fontSize: 16)
        view.addSubview(signOutBtn)
        view.addSubview(labelOne)
        view.addSubview(switchs)
        view.addSubview(labelLine)
        view.addSubview(labelTwo)
        view.addSubview(imageView)
        view.addSubview(backView)
        
        signOutBtn.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.top.equalTo()(backView.mas_bottom)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH, height:60))
        }
        labelOne.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)?.setOffset(15)
            make!.top.equalTo()(self.view)?.setOffset(22)
        }
        switchs.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.view)?.setOffset(-15)
            make!.centerY.equalTo()(labelOne)
        }
        labelLine.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)?.setOffset(15)
            make!.top.equalTo()(labelOne.mas_bottom)?.setOffset(22)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-15, height:1))
        }
        labelTwo.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)?.setOffset(15)
            make!.top.equalTo()(labelLine.mas_bottom)?.setOffset(22)
        }
        imageView.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.view)?.setOffset(-15)
            make!.centerY.equalTo()(labelTwo)
        }
        backView.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.top.equalTo()(labelTwo.mas_bottom)?.setOffset(22)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH, height:30))
        }
    }
    
    @objc private func signOut(){
        HHCommon.shareCommon.handleClearAPP()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_changeinto_rootController), object: "HHLoginController", userInfo: nil)
    }
    
    private lazy var switchs: UISwitch = {
        let switchs = UISwitch()
        switchs.onTintColor = HHMAINCOLOR()
        return switchs
    }()
    
}
