//
//  HHSignUpController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/14.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHSignUpController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "注册账号（2/4）"
        setUI()
    }
    
    private func setUI(){
        view.addSubview(phoneNumber)
        view.addSubview(countryNumberBtn)
        view.addSubview(lineThree)
        view.addSubview(phoneNUmberTextFild)
        view.addSubview(lineOne)
        view.addSubview(testNumber)
        view.addSubview(testTextFild)
        view.addSubview(sendTestBtn)
        view.addSubview(lineTwo)
        view.addSubview(secretNumber)
        view.addSubview(secretTextFild)
        view.addSubview(lineFour)
        view.addSubview(nextBtn)
        view.addSubview(layerBtn)
        
        phoneNumber.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.view)?.setOffset(15)
            make!.size.mas_equalTo()(CGSize(width:100,height:13))

        }
        countryNumberBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.phoneNumber.mas_bottom)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:80,height:17))
        }
        lineThree.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.countryNumberBtn.mas_right)?.setOffset(10)
            make!.centerY.equalTo()(self.countryNumberBtn)
            make!.size.mas_equalTo()(CGSize(width:15,height:1))
        }
        phoneNUmberTextFild.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.lineThree.mas_right)?.setOffset(15)
            make!.centerY.equalTo()(self.countryNumberBtn)
            make!.size.mas_equalTo()(CGSize(width:150,height:17))
        }
        lineOne.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.phoneNUmberTextFild.mas_bottom)?.setOffset(15)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-15,height:1))
        }
        testNumber.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.lineOne.mas_bottom)?.setOffset(15)
            make!.size.mas_equalTo()(CGSize(width:100,height:13))
        }
        testTextFild.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.testNumber.mas_bottom)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:180,height:17))
        }
        sendTestBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.view)?.setOffset(-15)
            make?.top.equalTo()(self.lineOne.mas_bottom)?.setOffset(17)
            make!.size.mas_equalTo()(CGSize(width:96,height:35))
        }
        lineTwo.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.testTextFild.mas_bottom)?.setOffset(15)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-15,height:1))
        }
        secretNumber.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.lineTwo.mas_bottom)?.setOffset(15)
            make!.size.mas_equalTo()(CGSize(width:100,height:13))
        }
        secretTextFild.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(15)
            make?.top.equalTo()(self.secretNumber.mas_bottom)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:180,height:17))
        }
       
        lineFour.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make?.top.equalTo()(self.secretTextFild.mas_bottom)?.setOffset(15)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:30))
        }
        
        nextBtn.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.view)
            make!.top.equalTo()(self.lineFour.mas_bottom)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
        layerBtn.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.view)
            make!.top.equalTo()(self.nextBtn.mas_bottom)?.setOffset(15)
        }
    }
    
    // #selector方法
    @objc private func changeIntoChoiceCountryNumber(){
    
    }
    // 懒加载
    private var phoneNumber: UILabel = UILabel.init(title: "手机号码", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
    private var testNumber: UILabel = UILabel.init(title: "验证码", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
    private var secretNumber: UILabel = UILabel.init(title: "密码", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
    
    private var lineOne: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHGRAYCOLOR()
        return line
    }()
    private var lineTwo: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHGRAYCOLOR()
        return line
    }()
    private var lineThree: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHWORDCOLOR()
        return line
    }()
    private var lineFour: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHGRAYCOLOR()
        return line
    }()
    private var countryNumberBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHSignUpController.changeIntoChoiceCountryNumber), target: self as AnyObject, title: "国家码", imageName: nil, fontColor: RGBCOLOR(216, 216, 216), fontSize: 16)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
        return btn
    }()
    private var sendTestBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHSignUpController.changeIntoChoiceCountryNumber), target: self as AnyObject, title: "发送验证码", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 14)
        btn.setBackgroundImage(UIImage(named:"gray"), for: .selected)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4
        return btn
    }()
    private var nextBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHSignUpController.changeIntoChoiceCountryNumber), target: self as AnyObject, title: "下一步", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 16)
        btn.setBackgroundImage(UIImage(named:"main_dark"), for: .highlighted)
        return btn
    }()
    private var layerBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHSignUpController.changeIntoChoiceCountryNumber), target: self as AnyObject, title: "注册即代表同意法律声明及隐私政策", backgroudImageName: nil, fontColor: HHWORDGAYCOLOR(), fontSize: 14)
        btn.titleLabel?.attributedText = HHCommon.shareCommon.drawLineForString(inputString: "注册即代表同意法律声明及隐私政策", fontColor: HHMAINCOLOR(), ColorRange: NSRange(location: 7,length: 9))
        return btn
    }()
    
    private var phoneNUmberTextFild: UITextField = {
        let textFild = UITextField.init(placeholders: "手机号码", title: nil, fontColor: HHWORDCOLOR(), fontSize: 16)
        return textFild
    }()
    private var secretTextFild: UITextField = {
        let textFild = UITextField.init(placeholders: "请输入密码", title: nil, fontColor: HHWORDCOLOR(), fontSize: 16)
        return textFild
    }()
    private var testTextFild: UITextField = {
        let textFild = UITextField.init(placeholders: "请输入验证码", title: nil, fontColor: HHWORDCOLOR(), fontSize: 16)
        return textFild
    }()
}
