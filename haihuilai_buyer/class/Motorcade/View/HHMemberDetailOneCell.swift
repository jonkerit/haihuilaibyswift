//
//  HHMemberDetailOneCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/19.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMemberDetailOneCell: UITableViewCell {
    var model: HHMotorcadeModel?{
        didSet{
            memberDetailOneNameLabel.text = model?.driver_supplier_name
            memberDetailOneDetailLabel.text = model?.driver_supplier_mobile
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        addSubview(memberDetailOneNameLabel)
        addSubview(memberDetailOneDetailLabel)
        addSubview(memberDetailOneArrowImage)
        addSubview(memberDetailOneLineLabel)
        
        memberDetailOneNameLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make!.centerY.equalTo()(self)
            make?.right.equalTo()(self)?.setOffset(40)
        }
        memberDetailOneArrowImage.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)?.setOffset(-15)
            make!.centerY.equalTo()(self)
        }
        memberDetailOneDetailLabel.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.memberDetailOneArrowImage.mas_left)?.setOffset(-10)
            make!.centerY.equalTo()(self)
            
        }
        memberDetailOneLineLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make!.bottom.equalTo()(self)
            make!.right.equalTo()(self)
            make!.height.mas_equalTo()(1)
        }
        
    }
    
    lazy var memberDetailOneNameLabel: UILabel = {
        let name = UILabel.init(title: "大哥", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        return name
    }()
    lazy var memberDetailOneDetailLabel: UILabel = {
        let name = UILabel.init(title: "13288888", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return name
    }()
    lazy var memberDetailOneArrowImage: UIImageView = {
        let arrow = UIImageView.init(imageName: "DL-jt")
        return arrow
    }()
    lazy var memberDetailOneLineLabel: UILabel = {
        let name = UILabel.init()
        name.backgroundColor = HHGRAYCOLOR()
        return name
    }()
    
}
