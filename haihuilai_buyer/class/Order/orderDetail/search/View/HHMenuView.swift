//
//  HHMenuView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHMenuViewDelegate:class{
    @objc optional func chioceMenuViewCell(_ menuModel:HHMenuModel?)
}
import UIKit
class HHMenuView: UIView {
    var choiceCell: HHMenuCell?
    
    var dataArray: [HHMenuModel]? // 数据组
    weak var menuDelegate: HHMenuViewDelegate? // 代理

    init() {
        super.init(frame: CGRect.zero)
        setUI()
        requireData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        let backView = UIView()
        backView.backgroundColor = UIColor.black
        backView.alpha = 0.1
        addSubview(backView)
        addSubview(tableView)
        
        backView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self)
        }
        tableView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make?.top.equalTo()(self)?.setOffset(74)
            make!.size.mas_equalTo()(CGSize(width:140, height:250))
        }
    }
    
    private func requireData() {
        HHProgressHUD().showHUDAddedTo(title: nil, isImage: true, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getSearchMenuList(parameter: nil){ (response, errorSting) in
            HHProgressHUD().hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
                self.dataArray = response as! [HHMenuModel]?
                self.tableView.mas_updateConstraints{ (make) in
                    make!.size.mas_equalTo()(CGSize(width:140, height:30+44*(self.dataArray?.count)!))
                }
                self.tableView.reloadData()
            }else{
                HHProgressHUD().showHUDAddedTo(title: errorSting, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.layer.cornerRadius = 4
        tableView.layer.masksToBounds = true
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = HHGRAYCOLOR()
        tableView.register(HHMenuCell.self, forCellReuseIdentifier: "HHMenuCell")
        return tableView
    }()
}

extension HHMenuView: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        var cell:HHMenuCell? = tableView.dequeueReusableCell(withIdentifier: "HHMenuCell") as? HHMenuCell
        if cell == nil {
            cell = HHMenuCell.init(style: .default, reuseIdentifier: "HHMenuCell")
        }
        cell?.selectionStyle = .none
        cell?.menuModel = dataArray?[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HHCommon.shareCommon.createViewForHeaderView(tableView, "搜索方式", 14, HHWORDGAYCOLOR())
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:HHMenuCell = tableView.cellForRow(at: indexPath) as! HHMenuCell
        if choiceCell == cell {
            cell.menuTitle.isSelected = !cell.menuTitle.isSelected
            cell.menuBtn.isHidden = !cell.menuBtn.isHidden
        } else {
            if choiceCell != nil {
                choiceCell?.menuTitle.isSelected = false
                choiceCell?.menuBtn.isHidden = true
            }
            choiceCell = cell
            choiceCell?.menuTitle.isSelected = true
            choiceCell?.menuBtn.isHidden = false
            if self.menuDelegate != nil {
                self.menuDelegate?.chioceMenuViewCell!(self.dataArray?[indexPath.row])
            }
        }
    }
    
}

