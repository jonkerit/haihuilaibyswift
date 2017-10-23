//
//  HHMemberDetailThreeView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/19.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHMemberDetailThreeViewDelegate:class{
    @objc optional func openMemberDetailThreeView(driverId:String)
}

import UIKit

class HHMemberDetailThreeView: UIView {
    weak var memberDetailThreeDelegate: HHMemberDetailThreeViewDelegate? // 代理
    var memberDetailThreeArray: [HHMotorCadeBookingModel]?{
        didSet{
            self.tableView.reloadData()
        }
    } // 数据组
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self)
        }
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
        tableView.register(HHMemberDetailOneCell.self, forCellReuseIdentifier: "HHMemberDetailOneCell")
        return tableView
    }()
}

extension HHMemberDetailThreeView: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberDetailThreeArray?.count ?? 0
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "HHMemberDetailOneCell", for: indexPath) as! HHMemberDetailOneCell
        orderCell.memberDetailOneDetailLabel.isHidden =  true
        orderCell.memberDetailOneArrowImage.isHidden =  true
        orderCell.memberDetailOneNameLabel.text = memberDetailThreeArray?[indexPath.row].title
        orderCell.selectionStyle = .none
        
        return orderCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let model: HHTempGuideMode = self.memberDetailThreeArray![indexPath.row]
//        if self.memberDetailThreeDelegate != nil {
//            self.memberDetailThreeDelegate?.openMemberDetailThreeView!(driverId: model.driver_id!)
//        }
    }
    
}

