//
//  HHNewsCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/8.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHNewsCell: UITableViewCell {
    
    var newsModel: HHNewsModel?{
        didSet{
            newsCellTitle.text = newsModel?.content
            newsCelldetail.text = newsModel?.subject
            newsCellDate.text = newsModel?.date
            
            if  newsModel?.is_read == "0" {
                newsCellimageView.isHidden = false
                if #available(iOS 8.2, *) {
                    newsCellTitle.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
                    newsCellDate.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)

                } else {
                    // Fallback on earlier versions
                }

            }else{
                newsCellimageView.isHidden = true
                if #available(iOS 8.2, *) {
                    newsCellTitle.font = UIFont.systemFont(ofSize: 14)
                    newsCellDate.font = UIFont.systemFont(ofSize: 14)

                } else {
                    // Fallback on earlier versions
                }
               
            }
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
        contentView.addSubview(newsCellimageView)
        contentView.addSubview(newsCellTitle)
        contentView.addSubview(newsCelldetail)
        contentView.addSubview(newsCellDate)
        
        newsCellimageView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.contentView)?.setOffset(20)
            make!.size.mas_equalTo()(CGSize(width: 5,height: 5))
        }
        newsCellTitle.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.contentView)?.setOffset(30)
            make!.top.equalTo()(self.contentView)?.setOffset(12)
            make?.right.equalTo()(self.newsCellDate.mas_left)?.setOffset(-10)
        }
        newsCellDate.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.contentView)?.setOffset(-15)
            make!.centerY.equalTo()(self.newsCellTitle)
            make!.width.equalTo()(100)
        }
        newsCelldetail.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.contentView)?.setOffset(30)
            make!.top.equalTo()(self.newsCellTitle.mas_bottom)?.setOffset(10)
            make?.right.equalTo()(self.contentView)?.setOffset(-30)
        }
        
    }
    
    
    
    lazy var newsCellimageView: UIImageView = {
        let imageView = UIImageView.init(imageName: "reddot")
        return imageView
    }()
    lazy var newsCellTitle: UILabel = {
        let label = UILabel.init(title: "你好还得和 i 啊扈 i", fontColor: HHWORDCOLOR(), fontSize: 14, alignment: .left)
        return label
    }()
    lazy var newsCelldetail: UILabel = {
        let label = UILabel.init(title: "你好还得和 i 啊扈 i", fontColor: HHWORDCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    lazy var newsCellDate: UILabel = {
        let label = UILabel.init(title: "2012-3-03", fontColor: HHWORDCOLOR(), fontSize: 14, alignment: .right)
        return label
    }()
}
