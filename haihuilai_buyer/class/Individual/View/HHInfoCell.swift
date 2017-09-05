//
//  HHInfoCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/5.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHInfoCell: UITableViewCell {
    var rate: CGFloat?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        contentView.addSubview(lineLabel)
        contentView.addSubview(headerImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(imageViews)
        lineLabel.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.contentView)?.setOffset(15)
            make!.right.equalTo()(self.contentView)
            make!.height.equalTo()(1)
            make!.top.equalTo()(self.contentView)
        }
        headerImageView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make!.centerY.equalTo()(self.contentView)
        }
        titleLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.headerImageView.mas_right)?.setOffset(10)
            make!.centerY.equalTo()(self.contentView)
        }
        detailLabel.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.imageViews.mas_left)?.setOffset(-10)
            make!.centerY.equalTo()(self.contentView)
        }
        imageViews.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.contentView)?.setOffset(-15)
            make!.centerY.equalTo()(self.contentView)
        }
    }
    
    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView.init(imageName: "GRZX-gzmx")
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(title: "车辆信息", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        return label
    }()
    lazy var detailLabel: UILabel = {
        let label = UILabel.init(title: "未添加", fontColor: HHWORDGAYCOLOR(), fontSize: 14, alignment: .left)
        return label
    }()
    private lazy var imageViews: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "DL-jt"))
        return imageView
    }()
    private lazy var lineLabel: UILabel = {
        let label = UILabel.init(title: "", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        label.backgroundColor = HHGRAYCOLOR()
        return label
    }()
}
