//
//  HHIndividualController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHIndividualController: HHBaseViewController {
    // 提示字符串的高度
    var stringHeight: CGFloat?
    // 提示字符串的内容
    var warmString: String?{
        didSet{
            let height = HHCommon.shareCommon.obtainStringLength(warmString, 14, CGSize(width: SCREEN_WIDTH - 30,height:CGFloat(Int.max))).height
            if height == 0 {
                stringHeight = 0
            } else {
                stringHeight = HHCommon.shareCommon.obtainStringLength(warmString, 14, CGSize(width: SCREEN_WIDTH - 30,height:CGFloat(Int.max))).height + 26
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = HHGRAYCOLOR()
        warmString = "说来的地洒了很久了多哈健康监控力度撒回家了回家的卡萨和蝴蝶结阿克苏 打火机卡号多久啊了很久后的撒娇哭会对哈手机客户端撒娇哭的哈萨克领导喝酒啊好多拉黑就多哈健康"
        setUI()
        updata()
    }
    private func setUI(){
        let backView = UIView()
        let scrollowView = UIScrollView()
        scrollowView.showsVerticalScrollIndicator = false
        let NameView = UIView()
        NameView.backgroundColor = UIColor.white
        let teamView = UIView()
        teamView.backgroundColor = UIColor.white
        
        view.addSubview(scrollowView)
        scrollowView.addSubview(backView)
        scrollowView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self.view)
        }
        backView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(scrollowView)
            make!.width.equalTo()(SCREEN_WIDTH)
        }
        
        backView.addSubview(warmLabel)
        backView.addSubview(NameView)
        backView.addSubview(teamView)
        backView.addSubview(infoView)
        infoView.mas_makeConstraints { (make) in
            make?.top.equalTo()(teamView.mas_bottom)?.setOffset(10)
            make!.left.equalTo()(backView)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH - 20,height:280))
        }
        warmLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(backView)?.setOffset(15)
            make?.right.equalTo()(backView)?.setOffset(-15)
            make?.top.equalTo()(backView)?.setOffset(13)
        }
        NameView.mas_makeConstraints { (make) in
            make?.top.equalTo()(backView)?.setOffset(self.stringHeight!)
            make!.left.equalTo()(backView)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
        teamView.mas_makeConstraints { (make) in
            make?.top.equalTo()(NameView.mas_bottom)?.setOffset(10)
            make!.left.equalTo()(backView)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
        NameView.addSubview(nameLabel)
        NameView.addSubview(phoneNumberLabel)
        let imageView1 = UIImageView.init(image: UIImage(named: "DL-jt"))
        NameView.addSubview(imageView1)
        nameLabel.mas_makeConstraints { (make) in
            make!.left.equalTo()(NameView)?.setOffset(15)
            make!.centerY.equalTo()(NameView)
        }
        imageView1.mas_makeConstraints { (make) in
            make!.right.equalTo()(NameView)?.setOffset(-15)
            make!.centerY.equalTo()(NameView)
        }
        phoneNumberLabel.mas_makeConstraints { (make) in
            make!.right.equalTo()(imageView1.mas_left)?.setOffset(-10)
            make!.centerY.equalTo()(NameView)
        }
        
        let label = UILabel.init(title: "车队", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        teamView.addSubview(label)
        teamView.addSubview(teamNameLabel)
        teamView.addSubview(teamNunberLabel)
        teamNameLabel.mas_makeConstraints { (make) in
            make!.right.equalTo()(teamView)?.setOffset(-25)
            make!.centerY.equalTo()(teamView)
        }
        label.mas_makeConstraints { (make) in
            make!.left.equalTo()(teamView)?.setOffset(15)
            make!.centerY.equalTo()(teamView)?.setOffset(-10)
        }
        teamNunberLabel.mas_makeConstraints { (make) in
            make!.left.equalTo()(teamView)?.setOffset(15)
            make!.centerY.equalTo()(teamView)?.setOffset(10)
        }
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            backView.addSubview(incomeView)
            incomeView.mas_makeConstraints { (make) in
                make?.top.equalTo()(self.infoView.mas_bottom)?.setOffset(10)
                make!.left.equalTo()(backView)?.setOffset(10)
                make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH - 20,height:60))
                make!.bottom.equalTo()(backView)?.setOffset(-10)
            }
        }else{
            infoView.mas_updateConstraints({ (make) in
                make!.bottom.equalTo()(backView)?.setOffset(-10)
            })
        }
    }
    
    //  数据处理
    private func updata(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: nil, isImage: true, boardView: HHKeyWindow, animated: true)
        //获取系统存在的全局队列
        let queue = DispatchQueue.global(qos: .default)
        //定义一个group
        let group = DispatchGroup()
        //并发任务，顺序执行
        queue.async(group: group) {
            HHNetworkClass().getReviewStatus(parameter: nil, networkClassData: { (response, errorString) in
                print("getReviewStatus")
                
            })
        }
        queue.async(group: group) {
            HHNetworkClass().getIndividualInfo(parameter: nil, networkClassData: { (response, errorString) in
                print("getIndividualInfo")
                
            })
        }
        queue.async(group: group) {
            
            HHNetworkClass().getInfoViewList(parameter: nil, networkClassData: { (response, errorString) in
                print("getInfoViewList")
            })
        }
        
        //1,所有任务执行结束汇总，不阻塞当前线程
        group.notify(queue: .global(), execute: {
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
        })
    }
    
    private lazy var warmLabel: UILabel = {
        let label = UILabel.init(title: "话", fontColor: RGBCOLOR(237, 78, 78), fontSize: 14, alignment: .left)
        label.text = self.warmString
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.init(title: "大哥", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        return label
    }()
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel.init(title: "18812345678", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return label
    }()
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel.init(title: "你好", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return label
    }()
    private lazy var teamNunberLabel: UILabel = {
        let label = UILabel.init(title: "车队ID 2333", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    private lazy var infoView: UIView = {
        let infoView = HHInfoView.init(frame: CGRect.zero)
        infoView.layer.cornerRadius = 4
        infoView.layer.masksToBounds = true
        return infoView
    }()
    private lazy var incomeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        let label = UILabel.init(title: "我的收入", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
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

