//
//  HHOrderTableView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHOrderTableViewDelegate:class{
    @objc optional func openOrderTableView(bookingId:String?)
}
import UIKit
import MJRefresh
class HHOrderTableView: UIView {
    
    weak var orderTableViewDelegate: HHOrderTableViewDelegate? // 代理
    var listType: String? // 列表类型
    var dataArray: [HHOrderModel]? // 数据组
    var pagNum: Int = 2 // 分页页码
    
    init(type: String?, frame: CGRect?) {
        super.init(frame: frame!)
        listType = type
        tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:self.frame.size.height)
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

   @objc func requireDataForHeader() {
        HHNetworkClass().getOrderList(parameter: ["status":self.listType as AnyObject,"page":"1" as AnyObject]) { (response, errorSting) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.resetNoMoreData()
            if response != nil{
                self.dataArray = response as! [HHOrderModel]?
                self.tableView.reloadData()
            }else{
//                HHProgressHUD().showHUDAddedTo(title: errorSting, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    @objc func requireDataForfooter() {
        HHNetworkClass().getOrderList(parameter: ["status":self.listType as AnyObject,"page":pagNum as AnyObject]) { (response, errorSting) in
            self.tableView.mj_footer.endRefreshing()
            if response != nil{
                if (response?.count)! > 0 {
                    self.dataArray =  self.dataArray! + (response as? [HHOrderModel])!
                    self.tableView.reloadData()
                    self.pagNum += 1
                }else{
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
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
        let header = MJRefreshNormalHeader()
        let footer = MJRefreshBackNormalFooter()
        header.setRefreshingTarget(self, refreshingAction: #selector(HHOrderTableView.requireDataForHeader))
        footer.setRefreshingTarget(self, refreshingAction: #selector(HHOrderTableView.requireDataForfooter))
        tableView.mj_header = header
        tableView.mj_footer = footer
        header.beginRefreshing()
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
        // 预加载数据
        if indexPath.row + 3 ==  dataArray?.count{
            requireDataForfooter()
        }
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
            let bookingID = dataArray?[indexPath.row].booking_id
            if !is_empty_string(bookingID) {
                self.orderTableViewDelegate?.openOrderTableView!(bookingId: bookingID)
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: "订单号不存在", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }

}
