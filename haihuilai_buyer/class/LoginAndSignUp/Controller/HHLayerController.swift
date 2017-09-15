//
//  HHLayerController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
import Foundation
class HHLayerController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI(){
//        let agreeBtn = UIButton.init(title:"同意并注册", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 18)
//        agreeBtn.addTarget(self, action:#selector(HHLayerController.nextPage), for: .touchDown)
        let webView = UIWebView.init(frame: self.view.bounds)
        webView.delegate = self
        
        let urlStr:String = HH_SERVER_URL + "/app/accounts/secret"
        let urls:URL = URL.init(string: urlStr)!
        webView.loadRequest(URLRequest.init(url: urls))
        view.addSubview(webView)
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
