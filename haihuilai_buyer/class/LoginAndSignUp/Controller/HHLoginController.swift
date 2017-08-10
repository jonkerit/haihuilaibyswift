//
//  HHLoginController.swift
//  haihuilaiForSupplier
//
//  Created by jonker on 16/12/8.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit
import Foundation
class HHLoginController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        dealBoclk()
        
        NotificationCenter.default.addObserver(self, selector: #selector(HHLoginController.keyboardWillShow(notifice:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HHLoginController.keyboardWillHide(notifice:)), name: .UIKeyboardWillHide, object: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setUI(){
        view.addSubview(backImageViw)
        backImageViw.addSubview(logInAndSignUpView)
        backImageViw.addSubview(loginView)
        
        backImageViw.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self.view)
        }
        logInAndSignUpView.mas_makeConstraints { (make) in
            make!.bottom.equalTo()(self.backImageViw.mas_bottom)?.setOffset(-100)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:45))
            make!.left.equalTo()(self.backImageViw)
        }
        loginView.mas_makeConstraints { (make) in
            make!.bottom.equalTo()(self.backImageViw.mas_bottom)?.setOffset(-55)
            make!.size.mas_equalTo()(CGSize(width:325,height:300))
            make!.centerX.equalTo()(self.backImageViw)?.setOffset(SCREEN_WIDTH)
        }
    }
//        let btn = UIButton(action: #selector(action), target:self, title: "dainji", imageName: nil, color: UIColor.red, fontSize: 16)
//        btn.frame = CGRect(x:10, y:150, width:100, height:50)
//        btn.backgroundColor = UIColor.brown
//        view.addSubview(btn)
//        view.addSubview(logInView)
////        weak var weakSelf = self －－第一种解决循环 ；[weak self] 第二种解决方案
//        logInView.signUpOrLoginblocks = {[weak self](sd:String?)-> String in
//            print(sd ?? "没有值")
////            self?.action()
//            return "改变了"
//        }
    
    private func dealBoclk(){
        weak var weakSelf = self
        loginView.choiceCountryB = {
            print("choiceCountryB")
            weakSelf?.navigationController?.pushViewController(HHChoiceCuntryController(), animated: true)
        }
        loginView.forgetSecretB = {
            print("forgetSecretB")
        }
        loginView.signupB = {
            print("signupB")
        }
        loginView.loginB = {(_ countryNumber: String?, _ phoneNumber: String?, _ secretNumber: String?) -> Void in
             print(countryNumber ?? "空值哦",phoneNumber ?? "空值哦")
        }
    
    }

    
    @objc fileprivate func action(){
        let paramters = Dictionary(dictionaryLiteral: ("country_code","86"), ("mobile","18812345678"),("password","12345678"))
        
        HHAccountViewModel.shareAcount.userLogin(urlString: "/app/suppliers/token", paramters: paramters as [String : AnyObject], networkDataBacks: { (response, error) -> Void in
            // 处理返回结果
            if response != nil {
                self.navigationController?.pushViewController(HHTestViewController(), animated: true)
            }
        })
    }
    @objc private func keyboardWillShow(notifice:NSNotification){
        let hight = (notifice.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect).size.height
//        let offset = (self.dengLuView.frame.origin.y+self.dengLuView.frame.size.height+40) - (self.view.frame.size.height - kbHeight);
        let time = notifice.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        weak var weakself = self
        if hight>0 {
            UIView.animate(withDuration: TimeInterval(time), animations: {
                weakself?.loginView.frame.origin.y = (weakself?.loginView.frame.origin.y)!-hight
            })
        }

    }
    @objc private func keyboardWillHide(notifice:NSNotification){
        let hight = (notifice.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect).size.height
        let time = notifice.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        weak var weakself = self
        if time>0 {
            UIView.animate(withDuration: TimeInterval(time), animations: {
                weakself!.loginView.frame.origin.y = SCREEN_HEIGHT-hight-55
            })
        }
    }
    @objc private func end(){
        view.endEditing(true)
    }
    
    fileprivate lazy var logInAndSignUpView:HHLogInAndSignUpView = {
        let logInAndSignUpView = HHLogInAndSignUpView.init()
        logInAndSignUpView.delegate = self
        return logInAndSignUpView
    }()
    
    fileprivate lazy var backImageViw:UIButton = {
        let imageView = UIButton.init(title: nil, backgroudImageName: "starting", color: nil, fontSize: nil)
        imageView.setBackgroundImage(UIImage(named:"starting"), for: .highlighted)
        imageView.addTarget(self, action: #selector(HHLoginController.end), for: .touchUpInside)
        return imageView
    }()
    fileprivate lazy var loginView:HHLogInView = {
        let loginView = HHLogInView.loadFromNib()
        loginView.layer.cornerRadius = 8
        loginView.layer.masksToBounds = true
        loginView.btnForLogin.layer.cornerRadius = 22
        loginView.btnForLogin.layer.masksToBounds = true
        return loginView
    }()
}

extension HHLoginController: signUpOrLoginDelegate{
    func login(account: String) {
        print(account)
        weak var weakSelf = self
        UIView.animate(withDuration: 1, animations: {
            weakSelf!.logInAndSignUpView.frame = CGRect(x:-SCREEN_WIDTH, y:weakSelf!.logInAndSignUpView.frame.origin.y, width:weakSelf!.logInAndSignUpView.frame.size.width, height:weakSelf!.logInAndSignUpView.frame.size.height)
            
            weakSelf!.loginView.frame = CGRect(x:(SCREEN_WIDTH-weakSelf!.loginView.frame.size.width)/2, y:weakSelf!.loginView.frame.origin.y, width:weakSelf!.loginView.frame.size.width, height:weakSelf!.loginView.frame.size.height)
        }) { (_) in
           weakSelf!.loginView.mas_updateConstraints({ (make) in
                make!.centerX.equalTo()(self.backImageViw)
           })
            weakSelf!.logInAndSignUpView.mas_updateConstraints({ (make) in
                 make!.left.equalTo()(self.backImageViw)?.setOffset(SCREEN_WIDTH)
            })
        }
    }
}

