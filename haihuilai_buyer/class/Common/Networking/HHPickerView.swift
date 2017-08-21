//
//  HHPickerView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/18.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

@objc protocol HHPickerViewDelegate: class{
    @objc optional func cancelBtnBack()
    @objc optional func ensureBtnBack(stringfirst:String?, stringSecond: String?)
    
}

import UIKit

class HHPickerView: UIView {
    weak var pickerViewDelegate: HHPickerViewDelegate?
    var dataArray: [[Any]]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.alpha = 0.05
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWithArray(DataArray: [[Any]]) {
        assert(DataArray.count > 0, "传入的数组不能为空")
        dataArray = DataArray
        setUI()
    }
    
    private func setUI(){
        HHKeyWindow?.addSubview(self)
        HHKeyWindow?.addSubview(backgroundView)
        backgroundView.addSubview(headView)
        backgroundView.addSubview(pickView)
        headView.addSubview(cancelBtn)
        headView.addSubview(ensureBtn)
        
        self.mas_makeConstraints { (make) in
            make!.edges.equalTo()(HHKeyWindow)
        }
        backgroundView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self)?.setInsets(UIEdgeInsetsMake(SCREEN_HEIGHT-260*SCREEN_HEIGHT_MATCH, 0, 0, 0))
        }
        pickView.mas_makeConstraints { (make) in
            make?.edges.mas_equalTo()(self.backgroundView)?.setInsets(UIEdgeInsetsMake(40*SCREEN_HEIGHT_MATCH, 0, 0, 0))
        }
        headView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.backgroundView)?.setInsets(UIEdgeInsetsMake(0, 0, 220*SCREEN_HEIGHT_MATCH, 0))
        }
        cancelBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self.headView)
            make!.left.equalTo()(self.headView)?.setOffset(20)
        }
        ensureBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self.headView)
            make!.right.equalTo()(self.headView)?.setOffset(-20)
        }
        
    }
    
    private func removeView(){
        self.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
    
    @objc private func cancelActin(){
        if self.pickerViewDelegate != nil {
            self.pickerViewDelegate?.ensureBtnBack!(stringfirst: "en", stringSecond: nil)
        }
        removeView()
    }
    @objc private func ensureActin(){
        if self.pickerViewDelegate != nil {
            self.pickerViewDelegate?.cancelBtnBack!()
        }
        removeView()
    }

    fileprivate lazy var backgroundView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.alpha = 1
        return backView
    }()
    fileprivate lazy var headView: UIView = {
        let headView = UIView()
        headView.backgroundColor = HHMAINDEEPCOLOR()
        return headView
    }()
    fileprivate lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHPickerView.cancelActin), target: self, title: "取消", backgroudImageName: "main_dark", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
    fileprivate lazy var ensureBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHPickerView.ensureActin), target: self, title: "确定", backgroudImageName: "main_dark", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
    fileprivate lazy var pickView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()

}

extension HHPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    // 每行的高度
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40*SCREEN_HEIGHT_MATCH
    }
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return (dataArray?.count) ?? 0
    }

    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray![component].count
    }
    
    // 每个格子的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray![component][row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}



