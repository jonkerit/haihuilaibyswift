//
//  HHOrderHeadView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
typealias orderHeadViewBlock = (_ tag: Int?) ->()
import UIKit

class HHOrderHeadView: UIView {

    var orderHeadViewBlocks: orderHeadViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = HHMAINDEEPCOLOR()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        addSubview(newsBtn)
        addSubview(titleView)
        addSubview(researchBtn)
        addSubview(movingBtn)
        addSubview(servingBtn)
        addSubview(unBeginBtn)
        addSubview(finishedBtn)
        
        newsBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make?.top.equalTo()(self)?.setOffset(33)
        }
        titleView.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self)
            make!.centerY.equalTo()(self.newsBtn)
        }
        researchBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self.newsBtn)
            make?.right.equalTo()(self)?.setOffset(-15)
        }
        movingBtn.mas_makeConstraints { (make) in
            make!.size.mas_equalTo()(CGSize(width: 70,height: 26))
            make!.bottom.equalTo()(self)?.setOffset(-7)
            make!.left.equalTo()(self)?.setOffset((SCREEN_WIDTH/3-70)/2)

        }
        servingBtn.mas_makeConstraints { (make) in
            make!.size.mas_equalTo()(CGSize(width: SCREEN_WIDTH/3, height: 40))
            make!.bottom.equalTo()(self)
            make!.left.equalTo()(self)
        }
        unBeginBtn.mas_makeConstraints { (make) in
            make!.size.mas_equalTo()(CGSize(width: SCREEN_WIDTH/3, height: 40))
            make!.bottom.equalTo()(self)
            make!.centerX.equalTo()(self)
        }
        finishedBtn.mas_makeConstraints { (make) in
            make!.size.mas_equalTo()(CGSize(width: SCREEN_WIDTH/3, height: 40))
            make!.bottom.equalTo()(self)
            make!.right.equalTo()(self)
        }
        
    }
    
    /// 懒加载
    lazy var servingBtn: UIButton = {
        let btn: UIButton = UIButton.init(action: #selector(HHOrderHeadView.servingAction(btnTag:)), target: self, title: "未开始", backgroudImageName: "", fontColor: UIColor.white, fontSize: 14)
        btn.tag = 0
        
        return btn
    }()
    lazy var unBeginBtn: UIButton = {
        let btn: UIButton = UIButton.init(action: #selector(HHOrderHeadView.servingAction(btnTag:)), target: self, title: "服务中", backgroudImageName: "", fontColor: UIColor.white, fontSize: 14)
        btn.tag = 1
        
        return btn
    }()
    lazy var finishedBtn: UIButton = {
        let btn: UIButton = UIButton.init(action: #selector(HHOrderHeadView.servingAction(btnTag:)), target: self, title: "历史", backgroudImageName: "", fontColor: UIColor.white, fontSize: 14)
        btn.tag = 2
        
        return btn
    }()
    lazy var movingBtn: UIButton = {
        let btn: UIButton = UIButton.init(action: nil, target: self, title: "", backgroudImageName: "white", fontColor: HHMAINDEEPCOLOR(), fontSize: 14)
        btn.layer.cornerRadius = 13
        btn.layer.masksToBounds = true
        return btn
    }()
    lazy var newsBtn: UIButton = {
        let btn: UIButton = UIButton.init(action: #selector(HHOrderHeadView.servingAction(btnTag:)), target: self, title: nil, imageName: HHAccountViewModel.shareAcount.noticeImageName, fontColor: UIColor.white, fontSize: 14)
        btn.tag = 3
        return btn
    }()
    private lazy var researchBtn: UIButton = {
        let btn: UIButton = UIButton.init(action: #selector(HHOrderHeadView.servingAction(btnTag:)), target: self, title: nil, imageName: "search", fontColor: UIColor.white, fontSize: 14)
        btn.tag = 4
        return btn
    }()
    private lazy var titleView: UIImageView = {
        let mageView: UIImageView = UIImageView.init(image:UIImage(named: "ZC－logo"), highlightedImage: UIImage(named: "ZC－logo"))
        return mageView
    }()
    /// #selector方法
    @objc private func servingAction(btnTag: UIButton){
        if orderHeadViewBlocks != nil {
            self.orderHeadViewBlocks!(btnTag.tag)
        }
    }

}
