//
//  RegistProtocolController.swift
//  haihuilai_buyer
//
//  Created by JJ on 2017/8/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHRegistProtocolController: HHBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(agreeBtn)
        agreeBtn.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.right.equalTo()(self.view)
            make!.bottom.equalTo()(self.view)
            make!.height.mas_equalTo()(60)
        }
    }
    
    @objc private func agree(){
        let chioceVC=HHChioceRoleController()
        self.navigationController?.pushViewController(chioceVC, animated: true)
    }
    
    fileprivate lazy var webView:UIWebView={
        let webview=UIWebView(frame: self.view.bounds)
        let str=HH_SERVER_URL+"/app/accounts/net_sign"
        let registUrl=URL(string: str)
        let request=URLRequest(url: registUrl!)
        webview.loadRequest(request)
        return webview
    }()
    
    fileprivate lazy var agreeBtn:UIButton={
        
        let btn=UIButton.init()
        btn.setTitle("同意并注册", for: .normal)
        btn.backgroundColor = HHMAINCOLOR()
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(agree), for: .touchUpInside)
        return btn
    }()
}
