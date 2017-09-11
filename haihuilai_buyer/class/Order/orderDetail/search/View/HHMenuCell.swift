//
//  HHMenuCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMenuCell: UITableViewCell {
    
    var menuModel: HHMenuModel?{
        didSet{
            menuTitle.setTitle(menuModel?.content, for: .normal)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.white
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        contentView.addSubview(menuBtn)
        contentView.addSubview(menuTitle)
        contentView.addSubview(line)
        menuTitle.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make!.centerY.equalTo()(self.contentView)
        }
        menuBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.contentView)?.setOffset(-15)
            make!.centerY.equalTo()(self.contentView)
        }
        line.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.contentView)
            make!.right.equalTo()(self.contentView)
            make!.top.equalTo()(self.contentView)
            make!.height.equalTo()(1)
        }
    }
    // 懒加载
    lazy var menuTitle: UIButton = {
        let label = UIButton.init(title: "城市", imageName: nil, fontColor: HHWORDCOLOR(), fontSize: 14)
        label.setTitleColor(HHMAINCOLOR(), for: .selected)
        return label
    }()
    lazy var menuBtn: UIButton = {
        let label = UIButton.init(title: "", imageName:"selected", fontColor: HHWORDCOLOR(), fontSize: 14)
        return label
    }()
    private lazy var line: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHGRAYCOLOR()
        return line

    }()
}
