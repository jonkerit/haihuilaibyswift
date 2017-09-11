//
//  HHNewsTableView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/8.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHNewsTableViewDelegate:class{
    @objc optional func openNewsTableView(ID:String?)
}
import UIKit
import MJRefresh

class HHNewsTableView: UIView {
    weak var newsTableViewDelegate: HHNewsTableViewDelegate? // 代理
    var listType: String? // 列表类型
    var dataArray: [HHNewsModel]? // 数据组
    var pagNum: Int = 2 // 分页页码
    init(type: String?, frame: CGRect?) {
        super.init(frame: frame!)
        listType = type
        tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:(frame?.size.height)!-64)
        addSubview(tableView)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func requireDataForHeader() {
        HHNetworkClass().getNewsList(parameter: ["type":self.listType as AnyObject,"page":"1" as AnyObject]) { (response, errorSting) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.resetNoMoreData()
            if response != nil{
                self.dataArray = response as! [HHNewsModel]?
                self.tableView.reloadData()
            }else{
                //                HHProgressHUD().showHUDAddedTo(title: errorSting, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    @objc fileprivate func requireDataForfooter() {
        HHNetworkClass().getNewsList(parameter: ["type":self.listType as AnyObject,"page":pagNum as AnyObject]) { (response, errorSting) in
            self.tableView.mj_footer.endRefreshing()
            if response != nil{
                if (response?.count)! > 0 {
                    self.dataArray =  self.dataArray! + (response as? [HHNewsModel])!
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
        tableView.register(HHNewsCell.self, forCellReuseIdentifier: "HHNewsCell")
        let header = MJRefreshNormalHeader()
        let footer = MJRefreshBackNormalFooter()
        header.setRefreshingTarget(self, refreshingAction: #selector(HHNewsTableView.requireDataForHeader))
        footer.setRefreshingTarget(self, refreshingAction: #selector(HHNewsTableView.requireDataForfooter))
        tableView.mj_header = header
        tableView.mj_footer = footer
        header.beginRefreshing()
        return tableView
    }()
}

extension HHNewsTableView: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var orderCell: HHNewsCell? = tableView.dequeueReusableCell(withIdentifier: "HHNewsCell") as? HHNewsCell
        if orderCell == nil {
            orderCell = HHNewsCell.init(style: .default, reuseIdentifier: "HHNewsCell")
        }
        orderCell?.selectionStyle = .none
        orderCell?.newsModel = dataArray?[indexPath.row]
        // 预加载数据
        if indexPath.row + 3 ==  dataArray?.count{
            requireDataForfooter()
        }
        return orderCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.newsTableViewDelegate != nil {

        }
    }
    
}

