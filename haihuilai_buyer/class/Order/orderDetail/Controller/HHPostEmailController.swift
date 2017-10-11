//
//  HHPostEmailController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

enum PostType: String {
    case DOWNLOAD = "download" // 附件
    case CONFIRM = "confirm_ticket" // 行程单
}
class HHPostEmailController: HHBaseViewController {

    // 订单号
    var postEmailBookingId: String?
    // 标记
    var postEmailType: PostType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setRightBar()
    }
    private func setRightBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: .plain, target: self, action: #selector(rightItemAction))
    }

    private func setUI(){
        view.addSubview(backView)
        view.addSubview(warmLabel)
        backView.addSubview(titleLabel)
        backView.addSubview(fieldText)
        
        backView.mas_makeConstraints { (make) in
            make!.top.equalTo()(self.view)?.setOffset(10)
            make!.left.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:70))
        }
        warmLabel.mas_makeConstraints { (make) in
            make!.top.equalTo()(self.backView.mas_bottom)?.setOffset(10)
            make!.left.equalTo()(self.view)?.setOffset(10)
            make!.width.equalTo()(SCREEN_WIDTH-20)
        }
        titleLabel.mas_makeConstraints { (make) in
            make!.top.equalTo()(self.backView.mas_top)?.setOffset(10)
            make!.left.equalTo()(self.view)?.setOffset(10)
        }
        fieldText.mas_makeConstraints { (make) in
            make!.top.equalTo()(self.titleLabel.mas_bottom)?.setOffset(5)
            make!.left.equalTo()(self.view)?.setOffset(10)
            make!.width.equalTo()(SCREEN_WIDTH-20)
        }
    }
    // selector方法
    @objc private func rightItemAction(){
        view.endEditing(true)
        if is_empty_string(fieldText.text) {
            HHProgressHUD.shareTool.showHUDAddedTo(title: "请输入邮箱", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            return
        }
        HHProgressHUD.shareTool.showHUDAddedTo(title: nil, isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().postEmail(parameter: ["email": fieldText.text as AnyObject, "booking_id": postEmailBookingId as AnyObject]) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
                self.navigationController?.popViewController(animated: true)
                
                HHProgressHUD.shareTool.showHUDAddedTo(title: "保存成功,资料将随后发送至您的邮箱中", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    
    //  懒加载
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    private lazy var titleLabel: UILabel = UILabel.init(title: "邮箱", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
    private lazy var warmLabel: UILabel = {
        var nc: String?
        if self.postEmailType == .DOWNLOAD {
            nc = "点击发送后，行程单将会发送至您填写的这个邮箱，您可前往邮箱查看信息"
        } else {
            nc = "点击发送后，所有的附件将会发送至您填写的这个邮箱，您可前往邮箱查看信息"
        }
        let warm = UILabel.init(title: nc! , fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .left)
        warm.numberOfLines = 0
        return warm
    }()

    lazy var fieldText: UITextField = {
        let text = UITextField.init(placeholders: "请输入正确的邮箱地址", title: nil, fontColor: HHWORDCOLOR(), fontSize: 16)
        text.delegate = self
        text.keyboardType = .emailAddress
        return text
    }()
}

extension HHPostEmailController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if HHCommon.shareCommon.validateEmail(email: textField.text) {
            return true
        } else {
            HHProgressHUD.shareTool.showHUDAddedTo(title: "请输入正确的邮箱", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            return false
        }
    }
    
}



