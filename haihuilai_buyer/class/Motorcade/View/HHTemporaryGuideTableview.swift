//
//  HHTemporaryGuideTableview.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/12.
//  Copyright © 2017年 haihuilai. All rights reserved.
//


@objc protocol HHTemporaryGuideDelegate:class{
    @objc optional func openTemporaryGuide(driverId:String?)
}
import UIKit
class HHTemporaryGuideTableview: UIView {
    
    weak var temporaryGuideDelegate: HHTemporaryGuideDelegate? // 代理
    var temporaryGuideArray: [HHTempGuideMode]? // 数据组
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self)
        }
        requireData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func requireData() {
        HHProgressHUD().showHUDAddedTo(title: nil, isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)

        HHNetworkClass().getTempGuideList(parameter: nil){ (response, errorSting) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
                self.temporaryGuideArray = response as! [HHTempGuideMode]?
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
        tableView.register(HHMotorcadeSecondCell.self, forCellReuseIdentifier: "HHMotorcadeSecondCell")
        return tableView
    }()
}

extension HHTemporaryGuideTableview: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temporaryGuideArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "HHMotorcadeSecondCell", for: indexPath) as! HHMotorcadeSecondCell
        let model:HHTempGuideMode = self.temporaryGuideArray![indexPath.row]
        orderCell.detailLabel.isHidden =  true
        orderCell.nameLabel.text = model.driver_name
        orderCell.selectionStyle = .none
    
        return orderCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model: HHTempGuideMode = self.temporaryGuideArray![indexPath.row]
        if self.temporaryGuideDelegate != nil {
            self.temporaryGuideDelegate?.openTemporaryGuide!(driverId: model.driver_id)
        }
    }
        
}
