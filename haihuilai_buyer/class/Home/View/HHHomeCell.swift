//
//  HHHomeCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/4.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHHomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self.contentView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView:UIImageView = UIImageView.init()
}
