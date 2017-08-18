//
//  HHChioceRoleController.swift
//  haihuilai_buyer
//
//  Created by JJ on 2017/8/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChioceRoleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "选择身份(1/4)"
        navigationItem.leftBarButtonItem = nil
        view.backgroundColor=RGBCOLOR(243, 243, 243)
        view.addSubview(tip1)
        view.addSubview(tip2)
        view.addSubview(cheDaoV)
        view.addSubview(duiZhangV)
        view.addSubview(nextBtn)
        tip1.mas_makeConstraints{ (make) in
            make!.left.equalTo()(self.view)
            make!.right.equalTo()(self.view)
            make!.top.equalTo()(self.view)?.setOffset(10)
            make!.height.equalTo()(30)
        }
        tip2.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.right.equalTo()(self.view)
            make!.top.equalTo()(self.tip1.mas_bottom)
        }
        cheDaoV.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.right.equalTo()(self.view)
            make!.top.equalTo()(self.tip2.mas_bottom)?.setOffset(5)
            make!.height.mas_equalTo()(80)
        }
        duiZhangV.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.right.equalTo()(self.view)
            make!.top.equalTo()(self.cheDaoV.mas_bottom)?.setOffset(10)
            make!.height.mas_equalTo()(80)
        }
        nextBtn.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.right.equalTo()(self.view)
            make!.bottom.equalTo()(self.view)
            make!.height.mas_equalTo()(60)
        }
    }
    
    @objc func nextStep(){
        print("下一步")
        
    }
    @objc func choiceCheDao(){
        print("车导")
        cheDaoV.backgroundColor=HHMAINCOLOR()
    }
    @objc func choiceDuiZhang(){
        print("车队")
        duiZhangV.backgroundColor=HHMAINCOLOR()
    }
    
    fileprivate lazy var tip1:UILabel={
       let label=UILabel()
        label.text="  请选择你在车队中的身份"
        label.textColor=HHMAINCOLOR()
        return label
    }()
    fileprivate lazy var tip2:UILabel={
        let label=UILabel()
        label.text="  请慎重选择，身份一旦选择后不可更改"
        label.font=UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    fileprivate lazy var cheDaoV:HHChoiceView={
       let choice = HHChoiceView()
        choice.imageName="ZC-cd"
        choice.titleStr="我是车导"
        choice.subStr="这是车导"
        var tap=UIGestureRecognizer(target: self, action: #selector(choiceCheDao))
        choice.addGestureRecognizer(tap)
        return choice
    }()
    
    fileprivate lazy var duiZhangV:HHChoiceView={
       let choice = HHChoiceView()
        choice.imageName="ZC-dz-f"
        choice.titleStr="我是队长"
        choice.subStr="这是队长"
        var tap=UIGestureRecognizer(target: self, action: #selector(choiceDuiZhang))
        return choice
    }()
    fileprivate lazy var nextBtn:UIButton={
       let btn=UIButton()
        btn.backgroundColor=HHMAINCOLOR()
        btn.setTitle("下一步", for: .normal)
        btn.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        return btn
    }()

}
