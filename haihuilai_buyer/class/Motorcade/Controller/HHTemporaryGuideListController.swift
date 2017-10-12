//
//  HHTemporaryGuideListController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/12.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHTemporaryGuideListController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    private func setUI(){
        temporaryGuideTableview.temporaryGuideDelegate = self
        view.addSubview(temporaryGuideTableview)
        view.addSubview(addBtn)
        
        addBtn.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.bottom.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
        temporaryGuideTableview.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.top.equalTo()(self.view)
            make!.right.equalTo()(self.view)
            make!.bottom.equalTo()(self.addBtn.mas_top)

        }
    }
    
    // #selector方法
    @objc private func addTemporaryGuide(){
        let vc = HHTempGuideDetailController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 懒加载
    private lazy var temporaryGuideTableview:HHTemporaryGuideTableview = HHTemporaryGuideTableview()
    private lazy var addBtn: UIButton = UIButton.init(action: #selector(addTemporaryGuide), target: self, title: "添加临时导游", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 16)
}

extension HHTemporaryGuideListController: HHTemporaryGuideDelegate{
    func openTemporaryGuide(driverId: String?) {
        let vc = HHTempGuideDetailController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
