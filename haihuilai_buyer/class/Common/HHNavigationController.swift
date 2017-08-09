//
//  HHNavigationController.swift
//  haihuilaiForSupplier
//
//  Created by jonker on 16/12/8.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit

class HHNavigationController: UINavigationController ,UINavigationControllerDelegate{
        
    var popDelegate:Any?
    
    override class func initialize (){
        // 设置navBar背景图、字体颜色、透明度
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "dark_gray"), for: UIBarMetrics.default)
        UINavigationBar.appearance().isTranslucent = false
    }
    
    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        addChildViewController(rootViewController)
        
        self.delegate = self
        popDelegate = self.interactivePopGestureRecognizer?.delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count != 0 {
            let barButton = UIBarButtonItem(customView: navBar)
            viewController.navigationItem.leftBarButtonItem = barButton
            super.pushViewController(viewController, animated: true)
            
        }
    }
    // 控制手势的有无（根目录没有手势）
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers.first {
            interactivePopGestureRecognizer?.delegate = popDelegate as! UIGestureRecognizerDelegate?
        }else{
            interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    private lazy var navBar: UIButton = {
        var btn:UIButton = UIButton.init(action: #selector(clickAction), target: self, title: "返回", imageName: "back", color: UIColor.red, fontSize: 20)
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0)
        btn.frame = CGRect(x:0, y:0, width:100, height:50)
        return btn
    }()
    @objc private func clickAction(){
        popViewController(animated: true)
    }
}
