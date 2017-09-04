//
//  HHIndividualController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHIndividualController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = HHGRAYCOLOR()
        setUI()
    }
    private func setUI(){
        let scrollowView = UIScrollView()
        let NameView = UIView()
        let teamView = UIView()
        
        
        view.addSubview(scrollowView)
        scrollowView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self.view)
        }
        
        scrollowView.addSubview(warmLabel)
        scrollowView.addSubview(NameView)
        scrollowView.addSubview(teamView)
        scrollowView.addSubview(infoView)
        scrollowView.addSubview(incomeView)
    }
    
    private lazy var warmLabel: UILabel = {
        let label = UILabel.init(title: "fjkaljaklashudhjlakshdk", fontColor: RGBCOLOR(237, 78, 78), fontSize: 14, alignment: .left)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.init(title: "", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        return label
    }()
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel.init(title: "", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return label
    }()
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel.init(title: "", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return label
    }()
    private lazy var teamNunberLabel: UILabel = {
        let label = UILabel.init(title: "", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .left)
        return label
    }()
    private lazy var infoView: UIView = {
        let infoView = HHInfoView()
        return infoView
    }()
    private lazy var incomeView: UIView = {
        let view = UIView()
        let label = UILabel.init(title: "", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        view.addSubview(label)
        view.addSubview(self.imageViews)
        label.mas_makeConstraints({ (make) in
            make!.left.equalTo()(view)?.setOffset(15)
            make!.centerY.equalTo()(view)
        })
        self.imageViews.mas_makeConstraints({ (make) in
            make!.right.equalTo()(view)?.setOffset(-15)
            make!.centerY.equalTo()(view)
        })
        return view
    }()
    private lazy var imageViews: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "DL-jt"))
        return imageView
    }()
}

