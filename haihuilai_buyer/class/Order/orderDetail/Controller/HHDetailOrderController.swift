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
            if (dataDic?["change_driver"]?.boolValue)! {
                buttonName = "改派导游"
                isInteractionEnabled = true
                settingSingleBtn()
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
        setRightBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upData()
    }
    
    private func setRightBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下载行程单", style: .plain, target: self, action: #selector(rightItemAction))
    }
    
    private func upData(){
        if is_empty_string(detailOrderBookingId){
            return
        }
        // 移除已有按钮
        if view.subviews.count > 0 {
            for objct in view.subviews {
                objct.removeFromSuperview()
            }
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
        let email = HHAccountViewModel.shareAcount.accountEmail?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let token = HHAccountViewModel.shareAcount.accountToken
        let urlStringone = "http://test.haihuilai.com" + (dataDic?["url"] as! String)
        let urlStringtwo = urlStringone + "?user_email=" + email! + "&user_token="
        let urlStringthree = urlStringtwo + token! + "&version=Ios_"
        let urlString = urlStringthree + (vision as! String)
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
    // 派单
    private func distributeOrder(){
        //
    }
    // 开始服务
    private func startService(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: "状态更新中", isImage: true, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().postDetailOrderStart(parameter: ["booking_id":detailOrderBookingId as AnyObject]) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
               self.upData()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    // 结束服务
    private func endService(){
        let alertController: UIAlertController = UIAlertController.init(title: "", message: "请选择", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alert) in
            
        }))
        
        alertController.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (alert) in
            HHProgressHUD.shareTool.showHUDAddedTo(title: "状态更新中", isImage: true, boardView: HHKeyWindow, animated: true)
            HHNetworkClass().postDetailOrderEnd(parameter: ["booking_id": self.detailOrderBookingId as AnyObject]) { (response, errorString) in
                HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
                if response != nil{
                    self.upData()
                }else{
                    HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
                }
            }

        }))
        self.present(alertController, animated: true, completion: nil)
    }
    // 上传意见单或者行程单
    private func postSomething(journeyChange: JourneyChange){
        let vc = HHJourneyChangeController()
        vc.journeyChangeVC = journeyChange
        navigationController?.pushViewController(vc, animated: true)
    }
    // 微信分享
    private func openWeiXins(){
        HHPrint("微信分享")
    }
    // 分享或者下载行程单
    fileprivate func shareInfo(WitchType: PostType){
        let vc = HHPostEmailController()
        vc.postEmailType = WitchType
        vc.postEmailBookingId = detailOrderBookingId
        navigationController?.pushViewController(vc, animated: true)
    }
    // Selector方法
    @objc private func firstBtnAction(btn:UIButton){
        // 根据不同的状态做不同的跳转
        if detailOrderStatus == "no_driver" {
            distributeOrder()
        } else if detailOrderStatus == "change_driver" {
            let alertController: UIAlertController = UIAlertController.init(title: "改派导游", message: dataDic!["alert_message"] as! String?, preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alert) in
                
            }))
            alertController.addAction(UIAlertAction.init(title: "确定改派", style: .default, handler: { (alert) in
                self.distributeOrder()
            }))
            self.present(alertController, animated: true, completion: nil)

        } else if detailOrderStatus == "can_travelling" {
            startService()
        } else {
            postSomething(journeyChange: .CHANGE)
        }
    }
    @objc private func secondBtnAction(btn:UIButton){
        if detailOrderStatus == "can_travelled" {
            endService()
        } else {
            postSomething(journeyChange: .OPINION)
        }
    }
    @objc private func rightItemAction(){
        let alertController: UIAlertController = UIAlertController.init(title: nil, message: "选择接收方式", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alert) in
            
        }))
        alertController.addAction(UIAlertAction.init(title: "微信分享", style: .default, handler: { (alert) in
            self.openWeiXins()
        }))
        alertController.addAction(UIAlertAction.init(title: "邮件发送", style: .default, handler: { (alert) in
            self.shareInfo(WitchType: .CONFIRM)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    // 懒加载
    var nameDic = ["can_travelling":"开始服务","travelling":"结束服务","can_travelled":"结束服务","complain":"上传意见单","closed":"上传意见单","starting_soon":"即将开始","travelled":"上传意见单","cancelling":"退单中","cancelled":"退单完成","no_driver":"指派导游","change_driver":"改派导游"]
    
    private lazy var firstBtn:UIButton = {
        let btn = UIButton.init(action: #selector(firstBtnAction(btn:)), target: self, title: "fisrt", backgroudImageName: "orange-on", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
    private lazy var secondBtn:UIButton = {
        let btn = UIButton.init(action: #selector(secondBtnAction(btn:)), target: self, title: "second", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
    private lazy var orderWebview: WKWebView = {
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
        if (message.body as! String) == "下载附件" {
            self.shareInfo(WitchType: .DOWNLOAD)
        }
    }
}
// webview的代理
extension HHDetailOrderController: UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        HHProgressHUD.shareTool.showHUDAddedTo(title: nil, isImage: true, boardView: HHKeyWindow, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        HHProgressHUD.shareTool.showHUDAddedTo(title: "网页加载失败", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
    }
}
