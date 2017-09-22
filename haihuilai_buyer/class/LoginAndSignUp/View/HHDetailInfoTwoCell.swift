//
//  HHDetailInfoTwoCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/18.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHDetailInfoTwoCellDelegate: class{
    @objc optional func choiceCountryAction()
    @objc optional func writeDetailInfoTwoCell(textFields: UITextField)
    
}
import UIKit

class HHDetailInfoTwoCell: UITableViewCell {
    
    weak var detailInfoTwoCellDelegate: HHDetailInfoTwoCellDelegate?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        contentView.addSubview(detailInfoTwoTitle)
        contentView.addSubview(detailInfoTwoBtn)
        contentView.addSubview(detailInfoTwoTelephone)
        contentView.addSubview(detailInfoTwoLine)
        
        detailInfoTwoTitle.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.contentView)?.setOffset(15)
        }
        detailInfoTwoBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make!.top.equalTo()(self.detailInfoTwoTitle.mas_bottom)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:60,height:17))
        }
        detailInfoTwoTelephone.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.detailInfoTwoLine.mas_right)?.setOffset(10)
            make!.centerY.equalTo()(self.detailInfoTwoBtn)
            make!.size.mas_equalTo()(CGSize(width:250, height:17))
        }
        detailInfoTwoLine.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.detailInfoTwoBtn.mas_right)?.setOffset(10)
            make!.centerY.equalTo()(self.detailInfoTwoBtn)
            make!.size.mas_equalTo()(CGSize(width:15, height:1))
        }
    }
    // #selector 方法
    @objc private func choiceCountryNumber(){
        if self.detailInfoTwoCellDelegate != nil {
            self.detailInfoTwoCellDelegate?.choiceCountryAction!()
        }
    }
    
    // 懒加载
    lazy var detailInfoTwoTitle: UILabel = {
        let label = UILabel.init(title: "紧急联系人电话号码", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    lazy var detailInfoTwoLine: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = HHWORDCOLOR()
        return label
    }()
    lazy var detailInfoTwoBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHDetailInfoTwoCell.choiceCountryNumber), target: self, title: "国家码", imageName: "", fontColor: RGBCOLOR(216, 216, 216), fontSize: 16)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
        return btn
    }()
    lazy var detailInfoTwoTelephone: UITextField = {
        let textField = UITextField.init(placeholders: "手机号码", title: nil, fontColor: HHWORDCOLOR(), fontSize: 16)
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()
}
extension HHDetailInfoTwoCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.keyboardType = .numbersAndPunctuation
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.detailInfoTwoCellDelegate != nil {
            self.detailInfoTwoCellDelegate?.writeDetailInfoTwoCell!(textFields: textField)
        }
        return true
    }
}
