//
//  HHOrderTableView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHOrderTableView: UIView {
    
    var listType: String?
    var dataArray: [HHOrderModel]?
    init(type: String?, frame: CGRect?) {
        super.init(frame: frame!)
        listType = type
        tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:self.frame.size.height)
        addSubview(tableView)
        requireData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func requireData() {
        HHNetworkClass().getOrderList(parameter: ["status":self.listType as AnyObject,"page":"1" as AnyObject]) { (response, errorSting) in
            if response != nil{
                self.dataArray = response as! [HHOrderModel]?
                self.tableView.reloadData()
            }else{
                HHProgressHUD().showHUDAddedTo(title: errorSting, isImage: false, isHidden: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = HHGRAYCOLOR()
        tableView.register(UINib.init(nibName: "HHOrderCell", bundle: nil), forCellReuseIdentifier: "HHOrderCell")
        return tableView
    }()
}

extension HHOrderTableView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "HHOrderCell", for: indexPath) as! HHOrderCell
        orderCell.selectionStyle = .none
        orderCell.listType = listType
        orderCell.orderModel = dataArray?[indexPath.row]
        return orderCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let driverOrderModel = dataArray?[indexPath.row]
        if HHAccountViewModel.shareAcount.isCompanySupplier == true {
            if driverOrderModel?.is_change_info == true || driverOrderModel?.is_upload_opinion == true {
                return 193;
            } else {
                return 173;
            }
        }else{
            if driverOrderModel?.is_change_info == true || driverOrderModel?.is_upload_opinion == true {
                return 173;
            } else {
                return 143;
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
