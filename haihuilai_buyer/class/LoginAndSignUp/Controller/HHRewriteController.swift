//
//  HHRewriteController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/19.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHRewriteController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        view.addSubview(imageView)
        view.addSubview(warmLabel)
        view.addSubview(rewriteBtn)

        imageView.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.view)
            make?.top.equalTo()(self.view)?.setOffset(65*SCREEN_HEIGHT_MATCH)
        }
        warmLabel.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.view)
            make?.top.equalTo()(self.imageView.mas_bottom)?.setOffset(25*SCREEN_HEIGHT_MATCH)
            make!.width.equalTo()(160*SCREEN_HEIGHT_MATCH)
        }
        rewriteBtn.mas_makeConstraints { (make) in
           make!.left.equalTo()(self.view)
            make?.bottom.equalTo()(self.view.mas_bottom)?.setOffset(-180*SCREEN_HEIGHT_MATCH)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
    }
    @objc private func rewriteAction(){
        navigationController?.pushViewController(HHDetailInfoController(), animated: true)
    }
    
    private lazy var imageView: UIImageView = UIImageView.init(imageName: "ZC－zlbhg")
    private lazy var warmLabel: UILabel = UILabel.init(title: "账号未激活", fontColor: HHWORDGAYCOLOR(), fontSize: 18, alignment: .center)
    private lazy var rewriteBtn: UIButton = {
        let btn :UIButton = UIButton.init(action: #selector(HHRewriteController.rewriteAction), target: self, title: "重新填写", imageName: nil, fontColor: UIColor.white, fontSize: 16)
        btn.backgroundColor = HHMAINCOLOR()
        return btn
    }()
}
