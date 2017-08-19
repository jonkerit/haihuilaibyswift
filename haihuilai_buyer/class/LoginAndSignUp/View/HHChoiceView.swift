//
//  HHChoiceView.swift
//  haihuilai_buyer
//
//  Created by JJ on 2017/8/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceView: UIView {
    
    var imageName:String?{
        didSet{
            icon.image=UIImage.init(named: imageName!)
        }
    }
    var titleStr:String?{
        didSet{
            title.text=titleStr!
        }
    }
    var subStr:String?{
        didSet{
            subTitle.text=subStr!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.white
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        addSubview(icon)
        addSubview(title)
        addSubview(subTitle)
        icon.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.offset()(5)
            make?.top.equalTo()(self)?.offset()(5)
            make?.bottom.equalTo()(self)?.offset()(-5)
            make?.width.mas_equalTo()(70)
        }
        title.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.icon)?.offset()(10)
            make?.left.equalTo()(self.icon.mas_right)?.offset()(10)
            make?.right.equalTo()(self)?.offset()(-10)
            make?.height.mas_equalTo()(20)
        }
        subTitle.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.title.mas_bottom)
            make?.left.equalTo()(self.title)
            make?.right.equalTo()(self.title)
            make?.bottom.equalTo()(self)
        }
    }
    
    private lazy var icon:UIImageView={
       let img=UIImageView()
        return img
    }()

    private lazy var title:UILabel={
        let label=UILabel()
        return label
    }()
    
    private lazy var subTitle:UILabel={
       let sub=UILabel()
        return sub
    }()

}
