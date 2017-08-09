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
        NotificationCenter.default.addObserver(self, selector: #selector(action), name: NSNotification.Name(rawValue: "A"), object: nil)
        DispatchQueue.global().async{
            DispatchQueue.concurrentPerform(iterations: 10) { (index) in
                print("Iteration times:\(index),Thread = \(Thread.current)")
            }
        }
       
        setUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setUI(){
        let btn = UIButton(action: #selector(action), target:self, title: "dainji", imageName: nil, color: UIColor.red, fontSize: 16)
        btn.frame = CGRect(x:10, y:150, width:100, height:50)
        btn.backgroundColor = UIColor.brown
        view.addSubview(btn)
        view.addSubview(logInView)
//        weak var weakSelf = self －－第一种解决循环 ；[weak self] 第二种解决方案
        logInView.signUpOrLoginblocks = {[weak self](sd:String?)-> Void in
            self?.action()
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
    
    
    fileprivate lazy var logInView:HHLogInView = {
        let logInView = HHLogInView.init(frame: CGRect(x:0, y:350, width:SCREEN_WIDTH, height:150))
        logInView.delegate = self
        return logInView;
    }()

}

extension HHLoginController: signUpOrLoginDelegate{
    func login(account: String) {
        print(account)
        action()
    }
}

