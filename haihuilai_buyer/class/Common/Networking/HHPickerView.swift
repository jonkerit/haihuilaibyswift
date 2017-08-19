//
//  HHPickerView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/18.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

@objc protocol HHPickerViewDelegate: class{
    
    
}

import UIKit

class HHPickerView: UIView {
    weak var pickerViewDelegate: HHPickerViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.alpha = 0.05
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWithArray(DataArray: [Any]) {
        assert(DataArray.count == 0, "传入的数组不能为空")
        
    }
    
    private func setUI(){
        HHKeyWindow?.addSubview(self)
        self.addSubview(backgroundView)
        backgroundView.addSubview(headView)
        backgroundView.addSubview(pickView)
        headView.addSubview(cancelBtn)
        headView.addSubview(ensureBtn)
        
        self.mas_makeConstraints { (make) in
            make!.edges.equalTo()(HHKeyWindow)
        }
        pickView.mas_makeConstraints { (make) in
            make?.edges.mas_equalTo()(self.backgroundView)?.setInsets(UIEdgeInsetsMake(40, 0, 0, 0))
        }
    }
    
    @objc private func cancelActin(){
    
    
    }
    @objc private func ensureActin(){
        
        
    }

    fileprivate lazy var backgroundView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    fileprivate lazy var headView: UIView = {
        let headView = UIView()
        headView.backgroundColor = HHMAINDEEPCOLOR()
        return headView
    }()
    fileprivate lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHPickerView.cancelActin), target: self, title: "取消", backgroudImageName: "main_dark", fontColor: UIColor.white, fontSize: 14)
        return btn
    }()
    fileprivate lazy var ensureBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHPickerView.ensureActin), target: self, title: "确定", backgroudImageName: "main_dark", fontColor: UIColor.white, fontSize: 14)
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
        return 40
    }
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    // 每个格子的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "1"
    }

}



