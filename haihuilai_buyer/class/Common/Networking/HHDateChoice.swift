//
//  HHDateChoice.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/12.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHDateChoiceDelegate: class{
    @objc optional func dateCancelBtnBack()
    @objc optional func dateEnsureBtnBack(stringfirst:String?)
    
}

import UIKit

class HHDateChoice: UITextField {
    weak var dateChoiceDelegate:HHDateChoiceDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        DatePicker()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func DatePicker(){
        inputAccessoryView = self.headView
        inputView = self.datePicker
        cancelBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self.headView)
            make!.left.equalTo()(self.headView)?.setOffset(20)
        }
        ensureBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self.headView)
            make!.right.equalTo()(self.headView)?.setOffset(-20)
        }
        HHKeyWindow?.addSubview(self)
        self.becomeFirstResponder()
    }
    
    // @objc方法
    @objc private func pickERCancelActin(){
       endEditing(true)
    }
    @objc private func ensureActin(){
        endEditing(true)
        let ndf = DateFormatter()
        ndf.dateFormat = "yyyy-MM-dd"
        let time = ndf.string(from: self.datePicker.date)
        if self.dateChoiceDelegate != nil {
            self.dateChoiceDelegate?.dateEnsureBtnBack!(stringfirst: time)
        }
    }

    // 懒加载
    fileprivate lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale.init(localeIdentifier: "zh") as Locale
        datePicker.backgroundColor = UIColor.white
        return datePicker
    }()

    fileprivate lazy var headView: UIView = {
        let headView = UIView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:50))
        headView.backgroundColor = HHMAINDEEPCOLOR()
        headView.addSubview(self.cancelBtn)
        headView.addSubview(self.ensureBtn)
        return headView
    }()
    fileprivate lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHDateChoice.pickERCancelActin), target: self, title: "取消", backgroudImageName: "main_dark", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
    fileprivate lazy var ensureBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHDateChoice.ensureActin), target: self, title: "确定", backgroudImageName: "main_dark", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()

}
