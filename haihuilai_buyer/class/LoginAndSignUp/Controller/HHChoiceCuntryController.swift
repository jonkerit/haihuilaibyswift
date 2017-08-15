//
//  HHChoiceCuntryController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHChoiceCountryDelegate: class{
    @objc optional func getCountryNumber(countryName: String?, countryNumber: String?)
}

import UIKit

class HHChoiceCuntryController: HHBaseTableViewController {

    weak var delegate: HHChoiceCountryDelegate?
    
    var dataArray = [HHChoiceCountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "HHChoiceCountryCell", bundle: nil), forCellReuseIdentifier: "HHChoiceCountryCell")
        
        
        // 请求数据
//        weak var seakself = self
        HHNetworkClass().getCountryNumber(parameter: nil) {[weak self] (dataArray, error) in
            self?.dataArray = dataArray as! [HHChoiceCountryModel]
            self?.tableView.reloadData()
        }
    }
    deinit {
        print("我被移除了")
    }
}

// tableView dataDelegate
extension HHChoiceCuntryController{

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let choiceCountryModel = dataArray[section]
        return (choiceCountryModel.countries?.count) ?? 0
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HHChoiceCountryCell", for: indexPath) as! HHChoiceCountryCell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let choiceModelArray = dataArray[indexPath.section].countries
        if indexPath.row == (choiceModelArray?.count)!-1 {
            cell.line.isHidden = true
        }else{
            cell.line.isHidden = false
        }
        cell.choiceModel = choiceModelArray?[indexPath.row] 
        return cell
     }

}

// tableView dataScourceDelegate
extension HHChoiceCuntryController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let choiceCountryModel = dataArray[section]

        return choiceCountryModel.index
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegate != nil {
            let choiceModel = dataArray[indexPath.section].countries?[indexPath.row]
            self.delegate?.getCountryNumber!(countryName: choiceModel?.name, countryNumber: choiceModel?.val)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

