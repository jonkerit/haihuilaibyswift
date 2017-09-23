//
//  HHDetailInfoCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/18.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHDetailInfoCellDelegate: class{
    @objc optional func selectedDetailInfoCell(cellTag:Int)
    @objc optional func writeDetailInfoCell(textFields: UITextField)

}

import UIKit

class HHDetailInfoCell: UITableViewCell {
    
    weak var detailInfoCellDelegate:HHDetailInfoCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        contentView.addSubview(detailInfoTitle)
        contentView.addSubview(detailInfoText)
        contentView.addSubview(detailInfoImage)
        contentView.addSubview(detailInfoLine)
        
        detailInfoTitle.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(15)
        }
        detailInfoText.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.detailInfoTitle.mas_bottom)?.setOffset(10)
            make!.width.equalTo()(250)
        }
        detailInfoImage.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.contentView)?.setOffset(-15)
            make!.centerY.equalTo()(self.detailInfoText)
        }
        detailInfoLine.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.detailInfoText.mas_bottom)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-15, height:1))
        }
    }
    
    // 懒加载
    lazy var detailInfoTitle: UILabel = {
        let label = UILabel.init(title: "真实姓名", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    lazy var detailInfoText: UITextField = {
        let field = UITextField.init(placeholders: "点击添加", title: nil, fontColor: HHWORDCOLOR(), fontSize: 16)
        field.delegate = self
        field.returnKeyType = .done
        return field
    }()
    lazy var detailInfoImage: UIImageView = UIImageView.init(imageName: "DL-jt")
    lazy var detailInfoLine: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = HHGRAYCOLOR()
        return label
    }()
}
extension HHDetailInfoCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            if textField.tag == 3{
                // 跳转页面
                if self.detailInfoCellDelegate != nil {
                    self.detailInfoCellDelegate?.selectedDetailInfoCell!(cellTag: textField.tag)
                }
                return false
            } else {
                return true
            }
        } else {
            if textField.tag > 2{
                // 跳转页面
                if self.detailInfoCellDelegate != nil {
                    self.detailInfoCellDelegate?.selectedDetailInfoCell!(cellTag: textField.tag)
                }
                return false
            } else {
                return true
            }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.detailInfoCellDelegate != nil {
            self.detailInfoCellDelegate?.writeDetailInfoCell!(textFields: textField)
        }
        return true
    }
}
