//
//  HHbaseController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHbaseBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }
    
    private func addChildViewControllers(){
        let nav0 = HHNavigationController.init(rootViewController: HHOrderController())
        self.addChildViewController(nav0)
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            let nav1 = HHNavigationController.init(rootViewController: HHMotorcadeController())
            self.addChildViewController(nav1)
        } else {
            let nav1 = HHNavigationController.init(rootViewController: HHCalendarController())
            self.addChildViewController(nav1)
        }
        let nav2 = HHNavigationController.init(rootViewController: HHHomeController())
        self.addChildViewController(nav2)
        let nav3 = HHNavigationController.init(rootViewController: HHIndividualController())
        self.addChildViewController(nav3)
        
        var i = 0
        
        for navigationController in self.childViewControllers {
            navigationController.tabBarItem = UITabBarItem.init(title: nil, image: UIImage(named:(imageArray?[i])!)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:(imageSelectArray?[i])!)?.withRenderingMode(.alwaysOriginal))
            i += 1
            navigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        }
        
    }
    
    
    
    // 懒加载
    lazy var imageArray: [String]? = {
        if HHAccountViewModel.shareAcount.isCompanySupplier == true {
            let imageArray:Array = ["TAB-dd","TAB－cd","TAB-sdzjBRed","TAB-w"]
            return imageArray
        }else{
            let imageArray:Array = ["TAB-dd","TAB-rc","TAB-sdzjBRed","TAB-w"]
            return imageArray
        }
    }()
    lazy var imageSelectArray: [String]? = {
        if HHAccountViewModel.shareAcount.isCompanySupplier == true {
            let imageSelectArray:Array = ["TAB-dd-sel","TAB－cd-sel","TAB-sdzjBRed-sel","TAB-w-sel"]
            return imageSelectArray
        }else{
            let imageSelectArray:Array = ["TAB-dd-sel","TAB-rc-sel","TAB-sdzjBRed-sel","TAB-w-sel"]
            return imageSelectArray
        }
    }()
}
