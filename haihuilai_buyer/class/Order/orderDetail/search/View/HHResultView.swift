//
//  HHResultView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHResultView: UIView {
    var dataArray: [HHOrderModel]? // 数据组
    weak var orderTableViewDelegate: HHOrderTableViewDelegate? // 代理
    
    init() {
        super.init(frame: CGRect.zero)
        tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:self.frame.size.height)
        addSubview(tableView)
        requireData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requireData() {
        HHNetworkClass().getOrderList(parameter: nil) { (response, errorSting) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.resetNoMoreData()
            if response != nil{
                self.dataArray = response as! [HHOrderModel]?
                self.tableView.reloadData()
            }else{
                HHProgressHUD().showHUDAddedTo(title: errorSting, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
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

extension HHResultView: UITableViewDelegate, UITableViewDataSource{
    
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
        if self.orderTableViewDelegate != nil {
            //            let bookingID = dataArray?[indexPath.row].booking_id
            //            if !is_empty_string(bookingID) {
            //                self.orderTableViewDelegate?.openOrderTableView!(bookingId: bookingID)
            //            }else{
            //                HHProgressHUD.shareTool.showHUDAddedTo(title: "订单号不存在", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            //            }
        }
    }
    
}

