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
    
//    
//    private func test(){
//        let backGroundQueue = DispatchQueue(label: "currentQueue")
//        backGroundQueue.async(execute: <#T##() -> Void#>)
//    
//    }
//    
//    let wirte = DispatchWorkItem(flags: .barrier){
//          // write data
//          }
//    let dataQueue = DispatchQueue(label: "data",attributes: .concurrent)
//        dataQueue.async(execute: wirte)
}
