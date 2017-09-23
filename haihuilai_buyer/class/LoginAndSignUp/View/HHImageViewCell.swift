//
//  HHImageViewCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHImageViewCellDelegate: class{
    @objc optional func choiceimageBtnAction(chioceBtn:UIButton)
}
import UIKit

class HHImageViewCell: UITableViewCell {
    
    weak var imageViewCellDelegate: HHImageViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        contentView.addSubview(imageViewCellTitle)
        contentView.addSubview(imageViewCellBtn)
        imageViewCellTitle.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.contentView.mas_top)?.setOffset(15)
        }
        imageViewCellBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.contentView)?.setOffset(15)
            make?.top.equalTo()(self.imageViewCellTitle.mas_bottom)?.setOffset(10)
            make?.right.equalTo()(self.contentView)?.setOffset(-15)
            make?.bottom.equalTo()(self.contentView)?.setOffset(-5)
        }
    }
    // #selector方法
    @objc private func imageBtnAction(btn:UIButton){
        if self.imageViewCellDelegate != nil{
            self.imageViewCellDelegate?.choiceimageBtnAction!(chioceBtn:btn)
        }
    }
    // 懒加载
    lazy var imageViewCellTitle: UILabel = {
        let label = UILabel.init(title: "真实姓名", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    lazy var imageViewCellBtn: UIButton = {
        let imageBtn = UIButton.init(action: #selector(HHImageViewCell.imageBtnAction(btn:)), target: self, title: nil, imageName: nil, fontColor: nil, fontSize: nil)
        imageBtn.setBackgroundImage(UIImage(named:"ensure"), for: .normal)
        imageBtn.layer.cornerRadius = 4
        imageBtn.layer.masksToBounds = true
        return imageBtn
    }()
    
}
