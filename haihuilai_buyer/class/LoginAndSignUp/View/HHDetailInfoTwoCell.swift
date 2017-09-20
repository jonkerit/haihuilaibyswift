//
//  HHDetailInfoTwoCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/18.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHDetailInfoTwoCell: UITableViewCell {
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
            make!.top.equalTo()(self.detailInfoTwoBtn.mas_bottom)?.setOffset(10)
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
    
    
    // 懒加载
    lazy var detailInfoTwoTitle: UILabel = {
        let label = UILabel.init(title: "真实姓名", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    lazy var detailInfoTwoLine: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = HHWORDCOLOR()
        return label
    }()
    lazy var detailInfoTwoBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHDetailInfoController.choiceCountryNumber), target: HHDetailInfoController.self, title: "国家码", imageName: "", fontColor: RGBCOLOR(216, 216, 216), fontSize: 16)
        return btn
    }()
    lazy var detailInfoTwoTelephone: UIButton = {
        let btn = UIButton.init(action: #selector(HHDetailInfoController.choiceCountryNumber), target: HHDetailInfoController.self, title: "手机号码", imageName: "", fontColor: RGBCOLOR(216, 216, 216), fontSize: 16)
        return btn
    }()
}
