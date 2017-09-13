//
//  HHInviteCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/13.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHInviteCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        contentView.addSubview(inviteCellImage)
        contentView.addSubview(inviteCellTitle)
        contentView.addSubview(inviteCellDetail)
    
        inviteCellImage.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make!.centerY.equalTo()(self.contentView)
            make!.size.mas_equalTo()(CGSize(width:15,height:15))
        }
        inviteCellTitle.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.inviteCellImage.mas_right)?.setOffset(10)
            make!.centerY.equalTo()(self.contentView)
            make!.width.equalTo()(100)
        }
        inviteCellDetail.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.contentView)?.setOffset(-10)
            make!.centerY.equalTo()(self.contentView)
        }
    }
    
    lazy var inviteCellImage: UIButton = {
        let imageView = UIButton.init(title: nil, imageName: "select_off", fontColor: nil, fontSize: nil)
        imageView.setImage(UIImage(named:"select_on"), for: .selected)
        return imageView
    }()
    lazy var inviteCellTitle: UILabel = {
        let label = UILabel.init(title: "标题", fontColor: HHWORDCOLOR(), fontSize: 14, alignment: .left)
        return label
    }()
    lazy var inviteCellDetail: UILabel = {
        let label = UILabel.init(title: "1234565432", fontColor: HHWORDCOLOR(), fontSize: 14, alignment: .right)
        return label
    }()
}
