//
//  HHLayerController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
import Foundation
class HHLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI(){
        let agreeBtn = UIButton.init(title:"同意并注册", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 18)
        agreeBtn.addTarget(self, action:#selector(HHLayerController.nextPage), for: .touchDown)
        let webView = UIWebView()
        webView.delegate = self
        
        let urlStr:String = HH_SERVER_URL + "/app/accounts/secret"
        let urls:URL = URL.init(string: urlStr)!
        webView.loadRequest(URLRequest.init(url: urls))
        
        
        view.addSubview(webView)
        view.addSubview(agreeBtn)
        
        agreeBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(0)
            make?.right.equalTo()(self.view)?.setOffset(0)
            make?.bottom.equalTo()(self.view)?.setOffset(0)
            make!.height.equalTo()(64)
        }
        webView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(0, 0, 64, 0))
        }
    }
    @objc private func nextPage() {
            navigationController?.pushViewController(HHChioceRoleController(), animated: true)
        
    }
    
}

extension HHLayerController:UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
}
