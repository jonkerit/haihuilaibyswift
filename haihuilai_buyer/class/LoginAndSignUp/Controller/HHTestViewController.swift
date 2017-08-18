//
//  HHTestViewController.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/20.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit

class HHTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RGBCOLOR(135, 155, 155)
        
        print(HHAccountViewModel.shareAcount.accountToken ?? "失败")
        print(student8)
        view.addSubview(btn)

    }

    struct Student {
        var chinese: Int = 50
        var math: Int = 50
        var english: Int = 50
        init() {}
        init(chinese: Int, math: Int, english: Int) {
            self.chinese = chinese
            self.math = math
            self.english = english
        }
        init(stringScore: String) {
            let cme = stringScore.characters.split(separator: ",")
            chinese = Int(atoi(String(cme.first!)))
            math = Int(atoi(String(cme[1])))
            english = Int(atoi(String(cme.last!)))
        }
    }
    let student6 = Student()
    let student7 = Student(chinese: 90, math: 80, english: 70)
    let student8 = Student(stringScore: "70,80,90")
    deinit {
        
    }
    
    @objc private func chiocePhone(){
        HHPhotoPickManager.shareTools.photoPick(pickerTypes: pickerType(rawValue: 0)!, targetVC: self) {(infoDic, isOk) in
            
            if infoDic != nil {
                self.btn.setImage(infoDic!["UIImagePickerControllerOriginalImage"] as! UIImage?, for: .normal)
            }
        }
    }
    private lazy var btn: UIButton = {
       let btn = UIButton.init(action: #selector(HHTestViewController.chiocePhone), target: self, title: nil, backgroudImageName: "main_dark", fontColor: nil, fontSize: 16)
        btn.frame = CGRect(x:10, y:150, width:100, height:50)
        return btn
    }()
}
