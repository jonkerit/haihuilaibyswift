//
//  HHdetailOrderController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
import WebKit

class HHDetailOrderController: HHBaseViewController {

    // 订单号码
    var detailOrderBookingId: String?
    // 数据信息
    var dataDic: [String: AnyObject]?{
        didSet{
            self.detailOrderStatus = dataDic?["status"] as! String?
        }
    }

    // 按钮的名称
    var buttonName: String?
    // 按钮的可使用状态
    var isInteractionEnabled = false
    // 订单的状态
    var detailOrderStatus: String?{
        didSet{
            if is_empty_string(detailOrderStatus) {
                return
            }
            buttonName = nameDic[detailOrderStatus!]
            switch detailOrderStatus! {
            case "can_travelled":
                isInteractionEnabled = true
                settingDoubleBtn()
                break
            case "travelling":
                isInteractionEnabled = false
                settingDoubleBtn()
                break
            case "no_driver":
                isInteractionEnabled = true
                settingSingleBtn()
                break
            case "change_driver":
                isInteractionEnabled = true
                settingSingleBtn()
                break
            case "starting_soon":
                isInteractionEnabled = false
                settingSingleBtn()
                break
            case "can_travelling":
                isInteractionEnabled = true
                settingSingleBtn()
                break
            case "cancelling":
                isInteractionEnabled = false
                settingSingleBtn()
                break
            case "cancelled":
                isInteractionEnabled = false
                settingSingleBtn()
                break
            default:
                // 接送机和包车区别对待
                if (dataDic?["is_air_booking"]?.boolValue)! {
                    buttonName = "服务已结束"
                    isInteractionEnabled = false
                }else{
                    buttonName = "上传意见单"
                    isInteractionEnabled = true
                }
                settingDoubleBtn()
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upData()
    }
    
    private func upData(){
        if is_empty_string(detailOrderBookingId){
            return
        }
        HHProgressHUD.shareTool.showHUDAddedTo(title: "加载中", isImage: true, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getDetailOrderInfo(parameter: ["booking_id":detailOrderBookingId as AnyObject]) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
                self.dataDic = response?["data"] as! [String : AnyObject]?
                self.setUI()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
        
    }
    
    private func setUI(){
        // 加载webView
        orderWebview.navigationDelegate = self
        orderWebview.uiDelegate = self
        let vision = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        let email = HHAccountViewModel.shareAcount.accountEmail
        let token = HHAccountViewModel.shareAcount.accountToken
        let urlStringone = "http://test.haihuilai.com" + (dataDic?["url"] as! String)
        let urlStringtwo = urlStringone + "?user_email=" + email! + "&user_token="
        let urlStringthree = urlStringtwo + token! + "&version=Ios_"
        var urlString = urlStringthree + (vision as! String)
        let utf8Data = urlString.data(using: String.Encoding.utf8)
        print(utf8Data)
        urlString = String(data: utf8Data!, encoding: String.Encoding.utf8)!
        print(urlString)
        let url = URL.init(string: urlString)
        orderWebview.load(URLRequest.init(url: url!))
        
        view.addSubview(orderWebview)
        orderWebview.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(0, 0, 60, 0))
        }
    }
    
    // 设置双按钮
    private func settingDoubleBtn(){
        view.addSubview(firstBtn)
        // 第一个按钮
        firstBtn.setTitle("行程变更", for: .normal)
        firstBtn.setBackgroundImage(UIImage(named:"orange-on"), for: .normal)
        firstBtn.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.bottom.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH/2,height:60))
        }
        // 第二个按钮
        view.addSubview(secondBtn)
        var backgroundImage = "gray"
        var wordColor = HHWORDGAYCOLOR()
        if isInteractionEnabled {
            backgroundImage = "main_light"
            wordColor = UIColor.white
        } else {
            backgroundImage = "gray"
            wordColor = HHWORDGAYCOLOR()
        }
        secondBtn.setTitle(buttonName, for: .normal)
        secondBtn.setBackgroundImage(UIImage(named:backgroundImage), for: .normal)
        secondBtn.setTitleColor(wordColor, for: .normal)
        secondBtn.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.view)
            make!.bottom.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH/2,height:60))
        }
        
    }
    // 设置单按钮
    private func settingSingleBtn(){
        view.addSubview(firstBtn)
        var backgroundImage = "gray"
        var wordColor = HHWORDGAYCOLOR()
        if isInteractionEnabled {
            backgroundImage = "main_light"
            wordColor = UIColor.white
        } else {
            backgroundImage = "gray"
            wordColor = HHWORDGAYCOLOR()
        }
        firstBtn.setTitle(buttonName, for: .normal)
        firstBtn.setBackgroundImage(UIImage(named:backgroundImage), for: .normal)
        firstBtn.setTitleColor(wordColor, for: .normal)
        firstBtn.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.bottom.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
    }
    // Selector方法
    @objc private func firstBtnAction(btn:UIButton){
        
    }
    @objc private func secondBtnAction(btn:UIButton){
        
    }
    
    // 懒加载
    var nameDic = ["can_travelling":"开始服务","travelling":"结束服务","can_travelled":"结束服务","complain":"上传意见单","closed":"上传意见单","starting_soon":"即将开始","travelled":"上传意见单","cancelling":"退单中","cancelled":"退单完成","no_driver":"指派导游","change_driver":"改派导游"]
    
    lazy var firstBtn:UIButton = {
        let btn = UIButton.init(action: #selector(firstBtnAction(btn:)), target: self, title: "fisrt", backgroudImageName: "orange-on", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
    lazy var secondBtn:UIButton = {
        let btn = UIButton.init(action: #selector(secondBtnAction(btn:)), target: self, title: "second", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
    lazy var orderWebview: WKWebView = {
        let webViewConfiguration = WKWebViewConfiguration.init()
        webViewConfiguration.userContentController = WKUserContentController()
        webViewConfiguration.userContentController.add(self, name: iOSLoadOrderEnclosure)
        let webView = WKWebView.init(frame: CGRect.zero, configuration: webViewConfiguration)
        return webView
    }()
}

// 处理JS交互的代理
extension HHDetailOrderController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
extension HHDetailOrderController: UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate{
    
}
