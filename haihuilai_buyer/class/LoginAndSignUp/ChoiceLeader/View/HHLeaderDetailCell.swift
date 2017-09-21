//
//  HHLeaderDetailCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/21.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHLeaderDetailCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        contentView.addSubview(leaderDetailTitle)
        contentView.addSubview(leaderDetail)
        contentView.addSubview(leaderDetailLine)
        
        leaderDetailTitle.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(15)
        }
        leaderDetail.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.leaderDetailTitle.mas_bottom)?.setOffset(10)
            make?.right.equalTo()(self.contentView.mas_right)?.setOffset(-15)
        }
        leaderDetailLine.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(-1)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-15, height:1))
        }
    }
    
    // 懒加载
    lazy var leaderDetailTitle: UILabel = {
        let label = UILabel.init(title: "真实姓名", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    lazy var leaderDetail: UILabel = {
        let field = UILabel.init(title: "", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        field.numberOfLines = 0
        return field
    }()
    
    lazy var leaderDetailLine: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = HHGRAYCOLOR()
        return label
    }()
}

