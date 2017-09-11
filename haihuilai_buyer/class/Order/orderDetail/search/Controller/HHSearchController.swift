//
//  HHSearchController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHSearchController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

    }
    private func setUI(){
        view.addSubview(headerView)
        
        headerView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT-64, 0))
        }
    }
    
     /// 懒加载
    fileprivate lazy var headerView: HHHeaderView = {
        let header = HHHeaderView()
        header.headerDelegate = self
        return header
    }()
    fileprivate lazy var menuView: HHMenuView = {
        let menu = HHMenuView()
        menu.menuDelegate = self
        return menu
    }()
}

extension HHSearchController: HHHeaderViewDelegate{
    func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func choiceMenuAction() {
        // 创建MenuView
        menuView.frame = view.frame
        view.addSubview(menuView)
    }
}

extension HHSearchController:HHMenuViewDelegate{
    func chioceMenuViewCell() {
        HHPrint("点击MenuViewCell")
        menuView.removeFromSuperview()
//        menuView = nil
    }
}
