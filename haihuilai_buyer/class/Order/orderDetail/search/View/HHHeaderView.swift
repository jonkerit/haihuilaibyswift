//
//  HHHeaderView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHHeaderViewDelegate:class{
    @objc optional func cancelAction()
    @objc optional func choiceMenuAction()
}
import UIKit

class HHHeaderView: UIView {
    // 代理
    weak var headerDelegate: HHHeaderViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = HHMAINDEEPCOLOR()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI(){
        addSubview(headerChoiceBtn)
        addSubview(headerInputView)
        addSubview(cancelBtn)
        headerChoiceBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make?.bottom.equalTo()(self)?.setOffset(-5)
            make!.size.mas_equalTo()(CGSize(width:80*SCREEN_WIDTH_MATCH, height:34))
        }
        cancelBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)?.setOffset(-15)
            make!.centerY.equalTo()(self.headerChoiceBtn)
            make!.width.equalTo()(40)
        }
        headerInputView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.headerChoiceBtn.mas_right)?.setOffset(10)
            make!.centerY.equalTo()(self.headerChoiceBtn)
            make?.right.equalTo()(self.cancelBtn.mas_left)?.setOffset(-10)
            make!.height.equalTo()(34)
        }
        
    }
    /// @objet 方法
    @objc private func btnAction(){
        if self.headerDelegate != nil {
            self.headerDelegate?.choiceMenuAction!()
        }
    }
    @objc private func cancelAction(){
        if self.headerDelegate != nil {
            self.headerDelegate?.cancelAction!()
        }
    }
    /// 懒加载
    lazy var headerChoiceBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHHeaderView.btnAction), target: self, title: "城市", imageName: "down", fontColor: HHWORDCOLOR(), fontSize: 14)
        btn.backgroundColor = UIColor.white
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -80)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        return btn
    }()
    lazy var headerInputView: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 4
        textField.layer.masksToBounds = true
        textField.placeholder = "输入开始或结束城市"
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .search
        textField.attributedPlaceholder = NSAttributedString(string: "输入开始或结束城市", attributes: [
            NSForegroundColorAttributeName : UIColor.gray,
            NSFontAttributeName: UIFont.systemFont(ofSize: 14)
            ])
        textField.textColor = HHWORDCOLOR()
        textField.delegate = self
        return textField
    }()
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHHeaderView.cancelAction), target: self, title: "取消", imageName: nil, fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
}
extension HHHeaderView: UITextFieldDelegate{
    

}
