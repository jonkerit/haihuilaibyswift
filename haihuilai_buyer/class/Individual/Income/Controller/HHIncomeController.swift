//
//  HHIncomeController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/23.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHIncomeController: HHBaseViewController {

    // 数据字典
    private var dataDic: [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        upDate()
        dealBlock()
    }
    
    private func upDate(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: nil, isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getIncomeInfo(parameter: nil) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if SUCCESSFUL(response){
                self.dataDic = response?["data"] as! [String : AnyObject]?
                self.headerView.incomeHeaderData = self.dataDic
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    
    private func setUI(){
        view.addSubview(headerView)
        view.addSubview(tableView)
        headerView.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.top.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:294))
        }
        tableView.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.view)
            make!.top.equalTo()(self.headerView.mas_bottom)
            make!.right.mas_equalTo()(self.view)
            make!.bottom.equalTo()(self.view)
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    // block
    private func dealBlock(){
        weak var weakSelf = self
        headerView.incomeBackblock = {
            weakSelf?.navigationController?.popViewController(animated: true)
        }
        headerView.incomeAccountblock = {
            // 
            HHPrint("添加帐户")
        }
        headerView.incomeWithdrawblock = {
            //
            HHPrint("提现")
        }
    }
    //  懒加载
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.bounces = false
        tableView.register(HHMotorcadeSecondCell.self, forCellReuseIdentifier: "HHMotorcadeSecondCell")
        return tableView
    }()
    private lazy var headerView: HHIncomeHeaderView = {
        let headerView = HHIncomeHeaderView()
        return headerView
    }()
}

extension HHIncomeController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let Cell = tableView.dequeueReusableCell(withIdentifier: "HHMotorcadeSecondCell", for: indexPath) as! HHMotorcadeSecondCell
        Cell.detailLabel.isHidden = true
        Cell.selectionStyle = .none
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}

