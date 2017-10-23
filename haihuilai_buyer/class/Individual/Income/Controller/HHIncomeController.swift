//
//  HHIncomeController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/23.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHIncomeController: HHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
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
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "HHMotorcadeSecondCell", for: indexPath) as! HHMotorcadeSecondCell
        orderCell.selectionStyle = .none
        return orderCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}

