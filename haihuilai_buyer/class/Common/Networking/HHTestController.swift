//
//  HHTestController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let calenderView = HHCalenderView.init(frame: CGRect(x:0,y:100,width:SCREEN_WIDTH,height:450))
        view.addSubview(calenderView)
        calenderView.backgroundColor = UIColor.yellow
//        calenderView.mas_makeConstraints { (make) in
//            make!.right.equalTo()(self.view)
//            make!.top.equalTo()(self.view)?.setOffset(100)
//            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:450))
//        }
        

        calenderView.inputDate = Date.init(timeIntervalSinceNow: 60 * 60 * 24 * 63)

    }

}
