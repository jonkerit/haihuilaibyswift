//
//  HHNextOrdelegateCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/18.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHNextOrdelegateCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI(){
        contentView.backgroundColor = HHMAINCOLOR()
        contentView.addSubview(nextTitle)
        nextTitle.mas_makeConstraints { (make) in
            make!.center.equalTo()(self.contentView)
        }
    }
    
    // 懒加载
    lazy var nextTitle: UILabel = {
        let label = UILabel.init(title: "下一步", fontColor: UIColor.white, fontSize: 16, alignment: .left)
        return label
    }()
    
}
