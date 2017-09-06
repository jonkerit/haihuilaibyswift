//
//  HHMotorcadeController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
import MJRefresh

class HHMotorcadeController: HHBaseTableViewController {

    fileprivate var motorcadeDataArray:[HHMotorcadeModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "车队"
        tableView.register(NSClassFromString("HHMotorcadeFirstCell"), forCellReuseIdentifier: "HHMotorcadeFirstCell")
        tableView.register(NSClassFromString("HHMotorcadeSecondCell"), forCellReuseIdentifier: "HHMotorcadeSecondCell")
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(HHMotorcadeController.updata))
        header.beginRefreshing()
        tableView.mj_header = header
        setRightBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshNewsButton()
    }
    /// 给标签赋值
    private func refreshNewsButton(){
        let barItem = UIBarButtonItem.init(title: "", imageName: HHAccountViewModel.shareAcount.noticeImageName, target: self, action: #selector(HHMotorcadeController.openNewCenter))
        navigationItem.leftBarButtonItem = barItem
    }
    private func setRightBar(){
        let barItem:UIBarButtonItem = UIBarButtonItem.init(title: "", imageName: "top_add", target: self, action: #selector(HHMotorcadeController.invite))
        navigationItem.rightBarButtonItem = barItem
        
    }
    
    /// @objc方法
    @objc private func openNewCenter(){
        print("进消息中心")
        
    }
    @objc private func invite(){
        print("添加好友")
    }
    @objc private func updata(){
        HHNetworkClass().getDriverList(parameter: nil) { (response, errorSting) in
            self.tableView.mj_header.endRefreshing()
            if response != nil{
                self.motorcadeDataArray = response as! [HHMotorcadeModel]?
                self.tableView.reloadData()
            }else{
                HHProgressHUD().showHUDAddedTo(title: errorSting, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    
    fileprivate func createViewForHeaderView(_ tableView: UITableView,section: Int) -> UIView? {
        let backView = UIView()
        backView.backgroundColor = HHGRAYCOLOR()
        var titleArray: [String]?
        if self.motorcadeDataArray == nil {
            titleArray = [" ","临时导游","车队导游 (0)"]
        }else{
            let str:String = "车队导游 (" + String(self.motorcadeDataArray!.count) + ")"
            titleArray = [" ","临时导游",str]
        }
        let label = UILabel.init(title: titleArray![section], fontColor: HHWORDGAYCOLOR(), fontSize: 14, alignment: .left)
        backView.addSubview(label)
        label.mas_makeConstraints { (make) in
            make?.left.equalTo()(backView)?.setOffset(15)
            make!.centerY.equalTo()(backView)
        }
        return backView
    }
}

extension HHMotorcadeController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return motorcadeDataArray?.count ?? 0
        }else{
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if indexPath.section == 0 {
            var cell:HHMotorcadeFirstCell? = tableView.dequeueReusableCell(withIdentifier: "HHMotorcadeFirstCell") as? HHMotorcadeFirstCell
            if cell == nil {
                cell = HHMotorcadeFirstCell.init(style: .default, reuseIdentifier: "HHMotorcadeFirstCell")
            }
            cell?.selectionStyle = .none
            cell?.lineLabel.isHidden = true
            return cell!
        } else {
            var cell:HHMotorcadeSecondCell? = tableView.dequeueReusableCell(withIdentifier: "HHMotorcadeSecondCell") as? HHMotorcadeSecondCell
            if cell == nil {
                cell = HHMotorcadeSecondCell.init(style: .default, reuseIdentifier: "HHMotorcadeSecondCell")
            }
            if indexPath.section == 1 {
                cell?.detailLabel.isHidden = true
                cell?.nameLabel.text = "临时导游"
                cell?.lineLabel.isHidden = true
            }else{
                cell?.detailLabel.isHidden = false
                cell?.model = motorcadeDataArray?[indexPath.row]
                cell?.lineLabel.isHidden = false
            }
            
            return cell!

        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        }else{
            return 60
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return createViewForHeaderView(tableView, section: section)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 40
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
