//
//  HHMotorcadeSecondCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMotorcadeSecondCell: UITableViewCell {
    
    var model: HHMotorcadeModel?{
        didSet{
            nameLabel.text = model?.driver_supplier_name
            detailLabel.text = model?.driver_supplier_mobile
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
        addSubview(nameLabel)
        addSubview(detailLabel)
        addSubview(arrowImage)
        addSubview(lineLabel)
        
        nameLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make!.centerY.equalTo()(self)
            make?.right.equalTo()(self)?.setOffset(40)
        }
        arrowImage.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)?.setOffset(-15)
            make!.centerY.equalTo()(self)
        }
        detailLabel.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.arrowImage.mas_left)?.setOffset(-10)
            make!.centerY.equalTo()(self)

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
    lazy var detailLabel: UILabel = {
        let name = UILabel.init(title: "13288888", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return name
    }()
    lazy var arrowImage: UIImageView = {
        let arrow = UIImageView.init(imageName: "DL-jt")
        return arrow
    }()
    lazy var lineLabel: UILabel = {
        let name = UILabel.init()
        name.backgroundColor = HHGRAYCOLOR()
        return name
    }()

}
