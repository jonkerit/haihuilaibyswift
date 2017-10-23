//
//  HHMemberDetailThreeCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/19.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMemberDetailThreeCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setUI()
    }
    private func setUI(){
        contentView.backgroundColor = HHGRAYCOLOR()
        contentView.addSubview(memberDetailThreeView)
        memberDetailThreeView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.contentView)?.setInsets(UIEdgeInsetsMake(10, 15, 10, 15))
        }
        
    }
    
    // 懒加载
    lazy var memberDetailThreeView: HHMemberDetailThreeView = {
        let view = HHMemberDetailThreeView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()

}
