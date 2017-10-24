//
//  HHIncomeHeaderView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/23.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

typealias incomeHeaderBackblock = () -> ()
typealias incomeHeaderAccountblock = () -> ()
typealias incomeHeaderWithdrawblock = () -> ()

import UIKit

class HHIncomeHeaderView: UIView {

    // 返回block
    var incomeBackblock: incomeHeaderBackblock?
    // 帐户block
    var incomeAccountblock: incomeHeaderAccountblock?
    // 提现block
    var incomeWithdrawblock: incomeHeaderWithdrawblock?
    //  数据的字典
    var incomeHeaderData: [String: AnyObject]?{
        didSet{
            //  给总金额赋值
            incomeHeaderNumber.text = incomeHeaderData?["locale_can_withdraw"] as! String?
            // 给三个label赋值
            incomeHeaderTotalNum.text = incomeHeaderData?["locale_received"] as! String?
            incomeHeaderAlreadyNum.text = incomeHeaderData?["locale_withdrawal"] as! String?
            incomeHeaderDoingNum.text = incomeHeaderData?["locale_review_withdraw"] as! String?
        }
    }
    override func layoutSubviews() {
        setUI()
    }
    private func setUI(){
        self.addSubview(backViewOne)
        self.addSubview(backViewTwo)
        
        backViewOne.addSubview(incomeHeaderBack)
        backViewOne.addSubview(incomeHeaderTitle)
        backViewOne.addSubview(incomeHeaderBarBtn)
        backViewOne.addSubview(incomeHeaderBalance)
        backViewOne.addSubview(incomeHeaderNumber)
        backViewOne.addSubview(incomeHeaderCashBtn)
        
        backViewTwo.addSubview(incomeHeaderTotalImage)
        backViewTwo.addSubview(incomeHeaderTotal)
        backViewTwo.addSubview(incomeHeaderTotalNum)
        
        backViewTwo.addSubview(incomeHeaderLineOne)
        backViewTwo.addSubview(incomeHeaderAlreadyImage)
        backViewTwo.addSubview(incomeHeaderAlready)
        backViewTwo.addSubview(incomeHeaderAlreadyNum)
        
        backViewTwo.addSubview(incomeHeaderLineTwo)
        backViewTwo.addSubview(incomeHeaderDoingImage)
        backViewTwo.addSubview(incomeHeaderDoing)
        backViewTwo.addSubview(incomeHeaderDoingNum)
        
        backViewOne.mas_makeConstraints { (make) in
            make!.left.equalTo()(self)
            make!.top.equalTo()(self)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:154))
        }
        backViewTwo.mas_makeConstraints { (make) in
            make!.left.equalTo()(self)?.setOffset(10)
            make!.top.equalTo()(self.backViewOne.mas_bottom)?.setOffset(10)
            make!.width.mas_equalTo()(SCREEN_WIDTH - 20)
            make!.bottom.equalTo()(self)?.setOffset(-10)
        }

        incomeHeaderBack.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.backViewOne)?.setOffset(40)
            make!.top.equalTo()(self.backViewOne)?.setOffset(25)
        }
        incomeHeaderTitle.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.backViewOne)
            make!.centerY.equalTo()(self.incomeHeaderBack)
        }
        incomeHeaderBarBtn.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self.incomeHeaderBack)
            make!.right.equalTo()(self.backViewOne)?.setOffset(-15)
        }
        incomeHeaderBalance.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.backViewOne)?.setOffset(15)
            make!.bottom.equalTo()(self.incomeHeaderNumber.mas_top)?.setOffset(5)
        }
        incomeHeaderNumber.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.backViewOne)?.setOffset(15)
            make!.bottom.equalTo()(self.backViewOne)?.setOffset(-10)
            make!.right.equalTo()(self.incomeHeaderCashBtn.mas_left)?.setOffset(15)
        }
        incomeHeaderCashBtn.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.backViewOne)?.setOffset(-15)
            make!.bottom.equalTo()(self.backViewOne)?.setOffset(-15)
            make!.size.mas_equalTo()(CGSize(width:70,height:30))
        }

        incomeHeaderTotalImage.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.backViewTwo)?.setOffset(-SCREEN_WIDTH/3)
            make!.top.equalTo()(self.backViewTwo)?.setOffset(15)
        }
        incomeHeaderTotal.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.incomeHeaderTotalImage)
            make!.top.equalTo()(self.incomeHeaderTotalImage.mas_bottom)
        }
        incomeHeaderTotalNum.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.incomeHeaderTotalImage)
            make!.top.equalTo()(self.incomeHeaderTotal.mas_bottom)?.setOffset(5)
        }

        incomeHeaderAlreadyImage.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.backViewTwo)
            make!.top.equalTo()(self.backViewTwo)?.setOffset(15)
        }
        incomeHeaderAlready.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.incomeHeaderAlreadyImage)
            make!.top.equalTo()(self.incomeHeaderAlreadyImage.mas_bottom)
        }
        incomeHeaderAlreadyNum.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.incomeHeaderAlreadyImage)
            make!.top.equalTo()(self.incomeHeaderAlready.mas_bottom)?.setOffset(5)
        }
        
        incomeHeaderDoingImage.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.backViewTwo)?.setOffset(SCREEN_WIDTH/3)
            make!.top.equalTo()(self.backViewTwo)?.setOffset(15)
        }
        incomeHeaderDoing.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.incomeHeaderDoingImage)
            make!.top.equalTo()(self.incomeHeaderDoingImage.mas_bottom)
        }
        incomeHeaderDoingNum.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.incomeHeaderDoingImage)
            make!.top.equalTo()(self.incomeHeaderDoing.mas_bottom)?.setOffset(5)
        }
        incomeHeaderLineOne.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.backViewTwo)?.setOffset(-SCREEN_WIDTH/6)
            make!.top.equalTo()(self.backViewTwo)?.setOffset(15)
            make!.bottom.equalTo()(self.backViewTwo)?.setOffset(-15)
            make!.width.equalTo()(1)

        }
        incomeHeaderLineTwo.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.backViewTwo)?.setOffset(SCREEN_WIDTH/6)
            make!.top.equalTo()(self.backViewTwo)?.setOffset(15)
            make!.bottom.equalTo()(self.backViewTwo)?.setOffset(-15)
            make!.width.equalTo()(1)
            
        }

    }
    // #selector 方法
    @objc private func clickAction(){
        if self.incomeBackblock != nil {
            self.incomeBackblock!()
        }
    }
    @objc private func accountAction(){
        if self.incomeAccountblock != nil {
            self.incomeAccountblock!()
        }
    }
    @objc private func cashBtnAction(){
        if self.incomeWithdrawblock != nil {
            self.incomeWithdrawblock!()
        }
    }
    // 懒加载
    private lazy var incomeHeaderBack: UIButton = {
        var btn:UIButton = UIButton.init(action: #selector(clickAction), target: self, title: "返回", imageName: "back", fontColor: UIColor.white, fontSize: 16)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        return btn
    }()
    
    private lazy var incomeHeaderTitle: UILabel = UILabel.init(title: "我的收入", fontColor: UIColor.white, fontSize: 18, alignment: .center)
    
    private lazy var incomeHeaderBarBtn: UIButton = UIButton.init(action: #selector(accountAction), target: self, title: "帐户", imageName: nil, fontColor: UIColor.white, fontSize: 16)
    
    private lazy var incomeHeaderBalance: UILabel = UILabel.init(title: "余额", fontColor: UIColor.white, fontSize: 14, alignment: .left)
    
    private lazy var incomeHeaderNumber: UILabel = UILabel.init(title: "$100000000000000000000", fontColor: UIColor.white, fontSize: 40, alignment: .left)
    
    private lazy var incomeHeaderCashBtn: UIButton = {
        let btn = UIButton.init(action: #selector(cashBtnAction), target: self, title: "提现", backgroudImageName: "white", fontColor: HHMAINCOLOR(), fontSize: 16)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        return btn
    }()
    private lazy var backViewOne: UIView = {
        let backViewOne = UIView()
        backViewOne.backgroundColor = HHMAINDEEPCOLOR()
        return backViewOne
    }()
    private lazy var backViewTwo: UIView = {
        let backViewOne = UIView()
        backViewOne.backgroundColor = UIColor.white
        backViewOne.layer.cornerRadius = 4
        backViewOne.layer.masksToBounds = true
        return backViewOne
    }()
    
    private lazy var incomeHeaderLineOne: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHGRAYCOLOR()
        return line
    }()
    private lazy var incomeHeaderLineTwo: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHGRAYCOLOR()
        return line
    }()
    
    private lazy var incomeHeaderTotalImage: UIImageView = UIImageView.init(imageName: "income_total")
    private lazy var incomeHeaderTotal: UILabel = UILabel.init(title: "总收入", fontColor: HHMAINCOLOR(), fontSize: 14, alignment: .center)
    private lazy var incomeHeaderTotalNum: UILabel = UILabel.init(title: "$10000", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .center)

    private lazy var incomeHeaderAlreadyImage: UIImageView = UIImageView.init(imageName: "income_already")
    private lazy var incomeHeaderAlready: UILabel = UILabel.init(title: "已提现", fontColor: HHMAINCOLOR(), fontSize: 14, alignment: .center)
    private lazy var incomeHeaderAlreadyNum: UILabel = UILabel.init(title: "$10000", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .center)
    
    private lazy var incomeHeaderDoingImage: UIImageView = UIImageView.init(imageName: "income_doing")
    private lazy var incomeHeaderDoing: UILabel = UILabel.init(title: "提现中", fontColor: HHMAINCOLOR(), fontSize: 14, alignment: .center)
    private lazy var incomeHeaderDoingNum: UILabel = UILabel.init(title: "$10000", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .center)
    
}
