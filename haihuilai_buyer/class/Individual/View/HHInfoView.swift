//
//  HHInfoView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/4.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHIndividualDelegate:class{
    @objc optional func openInfoView(bookingId:String?)
}
import UIKit

class HHInfoView: UIView {
    weak var individualDelegate: HHIndividualDelegate? // 代理
    var dataArray: [Any]?
    var rate: CGFloat?{
        didSet{
            rateLabel.text = "信息完整度 " + String(describing: rate)
            rateimage.progress = Float(rate!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH-20, height:280)
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = HHGRAYCOLOR()
        tableView.register(HHInfoCell.self, forCellReuseIdentifier: "HHInfoCell")
        return tableView
    }()
     fileprivate lazy var rateLabel: UILabel = {
        let label = UILabel.init(title: "信息完整度 50%", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    fileprivate lazy var rateimage: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = HHMAINDEEPCOLOR()
        progress.trackTintColor = HHGRAYCOLOR()
        progress.layer.cornerRadius = 5
        progress.layer.masksToBounds = true
        return progress
    }()
    fileprivate lazy var titleNameArray:[String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier{
            return ["车辆信息","服务区域","资质证明","加分项"]
        }else{
            return ["车导认证","车辆信息"]
        }
    }()
    fileprivate lazy var imageNameArray:[String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier{
            return ["GRZX-gzmx","GRZX-fwqy","GRZX-zzzm","GRZX-jfx"]
        }else{
            return ["GRZX-cdrz","GRZX-gzmx"]
        }
    }()

}

extension HHInfoView: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return 4
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let infoCell = tableView.dequeueReusableCell(withIdentifier: "HHInfoCell", for: indexPath) as! HHInfoCell
        infoCell.selectionStyle = .none
        infoCell.headerImageView.image = UIImage(named: imageNameArray[indexPath.row])
        infoCell.titleLabel.text = titleNameArray[indexPath.row]
       
        return infoCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.addSubview(rateLabel)
        view.addSubview(rateimage)
        rateLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(view)?.setOffset(15)
            make!.centerY.equalTo()(view)
        }
        rateimage.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.rateLabel.mas_right)?.setOffset(30)
            make!.centerY.equalTo()(view)
            make!.right.equalTo()(view)?.setOffset(-15)
            make!.height.equalTo()(10)
        }
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
