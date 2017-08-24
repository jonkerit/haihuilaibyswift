//
//  HHMotorcadeFirstCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMotorcadeFirstCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        addSubview(nameLabel)
        addSubview(descibleBtn)
        addSubview(lineLabel)
        
        nameLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make?.centerY.equalTo()(self)?.setOffset(-10)
        }
        descibleBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make?.centerY.equalTo()(self)?.setOffset(10)
        }
        lineLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make!.bottom.equalTo()(self)
            make!.right.equalTo()(self)
            make!.height.mas_equalTo()(1)
        }
    }
    
    lazy var nameLabel: UILabel = {
        let name = UILabel.init(title: "大哥", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        return name
    }()
    lazy var lineLabel: UILabel = {
        let name = UILabel.init()
        name.backgroundColor = HHGRAYCOLOR()
        return name
    }()
    lazy var descibleBtn: UIButton = {
        let btn = UIButton.init(title: " 车队队长", imageName: "captain_icon", fontColor: RGBCOLOR(255, 168, 110), fontSize: 12)
        return btn
    }()
    
}
