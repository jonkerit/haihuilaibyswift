//
//  HHChoiceLoactionFirstController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/21.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceLoactionFirstController: HHBaseTableViewController {

    fileprivate var dataArray:[HHChoiceLoactionFirstModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        updata()
        tableView.register(HHChoiceLeaderCell.self, forCellReuseIdentifier: "HHChoiceLeaderCell")
        
    }
    private func updata(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: "加载中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)

        HHNetworkClass().getLocationFirstList(parameter: nil) { (response, errrorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil {
                self.dataArray = response as? [HHChoiceLoactionFirstModel]
                self.tableView.reloadData()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errrorString, isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
            }
        }
    }
}
    // tableView dataDelegate
extension HHChoiceLoactionFirstController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        var cell:HHChoiceLeaderCell?  = tableView.dequeueReusableCell(withIdentifier: "HHChoiceLeaderCell") as?  HHChoiceLeaderCell
        if cell == nil {
            cell = HHChoiceLeaderCell.init(style: .default, reuseIdentifier: "HHChoiceLeaderCell")
        }
        cell?.choiceLeaderTitle.text = self.dataArray?[indexPath.row].location_name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cv = HHChoiceLoactionSecondController()
        cv.locationSecondID = self.dataArray?[indexPath.row].location_id
        navigationController?.pushViewController(cv, animated: true)
    }
    
}
