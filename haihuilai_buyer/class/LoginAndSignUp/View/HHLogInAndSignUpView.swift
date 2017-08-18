//
//  HHLogInView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/2.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

@objc protocol signUpOrLoginDelegate: class{
    @objc optional func signUp(account: String)
    @objc optional func login(account: String)
}
typealias signUpOrLoginblock = (_ account: String?) -> (String)

import UIKit
class HHLogInAndSignUpView: UIView {
    weak var delegate: signUpOrLoginDelegate?
    var signUpOrLoginblocks: signUpOrLoginblock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setUI() {
        addSubview(logInBtn)
        addSubview(signUpBtn)
        
        logInBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self)
            make!.centerX.equalTo()(self)?.setOffset(-78)
            make!.size.mas_equalTo()(CGSize(width:140,height:45))
        }
        signUpBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self)
            make!.centerX.equalTo()(self)?.setOffset(78)
            make!.size.mas_equalTo()(CGSize(width:140,height:45))
        }
    }
    
    
    lazy var logInBtn:UIButton = {
        let btn = UIButton.init(action: #selector(HHLogInAndSignUpView.logIn), target: self, title: "登录", imageName: nil, fontColor: HHMAINCOLOR(), fontSize: 16)
        btn.layer.cornerRadius = 22.0
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor.white

        return btn
    }()
    lazy var signUpBtn:UIButton = {
        let btn = UIButton.init(action: #selector(HHLogInAndSignUpView.signUp), target: self, title: "注册", imageName: nil, fontColor: UIColor.white, fontSize: 16)
        btn.layer.cornerRadius = 22.0
        btn.layer.masksToBounds = true
        btn.backgroundColor = HHMAINCOLOR()

        return btn
    }()
    
    @objc private func logIn(){
        print("logIn")
        if self.delegate != nil{
            self.delegate?.login!(account:(logInBtn.titleLabel?.text)!)
        }
        
    }
    @objc private func signUp(){
        print("signUp")
        if self.signUpOrLoginblocks != nil {
            signUpBtn.setTitle(self.signUpOrLoginblocks!((signUpBtn.titleLabel?.text)!), for: UIControlState.normal)
            
        }
    }
   
}
