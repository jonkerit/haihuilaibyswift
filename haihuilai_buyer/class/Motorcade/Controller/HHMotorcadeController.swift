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
         let barItem = UIBarButtonItem.init(image: UIImage(named: HHAccountViewModel.shareAcount.noticeImageName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(HHMotorcadeController.openNewCenter))
        navigationItem.leftBarButtonItem = barItem
    }
    private func setRightBar(){
        let barItem = UIBarButtonItem.init(image: UIImage(named: "top_add")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(HHMotorcadeController.invite))
        navigationItem.rightBarButtonItem = barItem
        
    }
    // 微信邀请
    private func inviteByChat(){
    
    }
    // 电话薄邀请
    private func inviteByPhoneDirectory(){
        navigationController?.pushViewController(HHInviteController(), animated: true)
    }

    /// @objc方法
    @objc private func openNewCenter(){
        self.navigationController?.pushViewController(HHBaseNewsController(), animated: true)

    }
    @objc private func invite(){
        let alertController: UIAlertController = UIAlertController.init(title: "邀请车队导游", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "微信邀请", style: .default, handler: { (alter) in
            self.inviteByChat()
        }))
        alertController.addAction(UIAlertAction.init(title: "通讯录邀请", style: .default, handler: { (alter) in
            self.inviteByPhoneDirectory()
        }))
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alter) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
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
        var titleArray: [String]?
        if self.motorcadeDataArray == nil {
            titleArray = [" ","临时导游","车队导游 (0)"]
        }else{
            let str:String = "车队导游 (" + String(self.motorcadeDataArray!.count) + ")"
            titleArray = [" ","临时导游",str]
        }
        return HHCommon.shareCommon.createViewForHeaderView(tableView, (titleArray?[section])!, 14, HHWORDCOLOR())
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
        if indexPath.section == 1 {
            navigationController?.pushViewController(HHTemporaryGuideListController(), animated: true)
        }else if indexPath.section == 2 {
            let vc = HHMemberDetailController()
            vc.memberDetailDriverId = motorcadeDataArray?[indexPath.row].driver_supplier_id
            vc.memberDetailFrom = .EDITTEMPGUIDE
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}
