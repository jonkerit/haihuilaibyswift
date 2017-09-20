//
//  HHChoiceLeaderCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/20.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceLeaderCell: UITableViewCell {
    var choiceLeaderModel: HHChoiceLeaderModel?{
        didSet{
            choiceLeaderTitle.text = choiceLeaderModel?.fullname
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
        contentView.addSubview(choiceLeaderTitle)
        contentView.addSubview(choiceLeaderImage)
        contentView.addSubview(choiceLeaderLine)
        
        choiceLeaderTitle.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make!.centerY.equalTo()(self.contentView)
        }
        choiceLeaderImage.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.contentView)?.setOffset(-15)
            make!.centerY.equalTo()(self.contentView)
        }
        choiceLeaderLine.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.setOffset(-1)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-15, height:1))
        }
    }
    
    // 懒加载
    lazy var choiceLeaderTitle: UILabel = {
        let label = UILabel.init(title: "阿牛", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        return label
    }()
    
    lazy var choiceLeaderImage: UIImageView = UIImageView.init(imageName: "DL-jt")
    lazy var choiceLeaderLine: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = HHGRAYCOLOR()
        return label
    }()
}
