//
//  HHChoiceCuntryController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
import UIKit

class HHChoiceCuntryController: HHBaseViewController {
    var dataArray = [HHChoiceCountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUI()
         update()
    }
    
    private func setUI(){
        view.addSubview(tableView)
    }
    private func update(){
        // 请求数据
        HHProgressHUD.shareTool.showHUDAddedTo(title: "网络加载中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getCountryNumber(parameter: nil) {[weak self] (dataArray, error) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            self?.dataArray = dataArray as! [HHChoiceCountryModel]
            for objet in (self?.dataArray)!{
                self?.indexArray.append(objet.index ?? "")
            }
            self?.view.addSubview((self?.indexView)!)
            self?.tableView.reloadData()
        }
    }
    
    lazy fileprivate var indexArray = [Any]()
    lazy fileprivate var indexView:HHIndexView = {
        let xx = (Int(SCREEN_HEIGHT) - (Int(16*self.indexArray.count) + 20))/2
        let index = HHIndexView.init(frame:CGRect(x:Int(SCREEN_WIDTH - 25),y:xx/2,width:25,height:16*self.indexArray.count + 20),dataArray: self.indexArray as [AnyObject])
        index.indexViewDelelgate = self
        return index
    }()
    lazy fileprivate var tableView: UITableView = {
        let rect = CGRect(x:0,y:0,width:self.view.frame.size.width - 25,height:self.view.frame.size.height - 64)
        let tableView = UITableView.init(frame:rect)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = HHGRAYCOLOR()
        tableView.register(UINib.init(nibName: "HHChoiceCountryCell", bundle: nil), forCellReuseIdentifier: "HHChoiceCountryCell")
        return tableView
    }()
    deinit {
        print("我被移除了")
    }
}

extension HHChoiceCuntryController: HHIndexViewDelelgate{
    func tableViewIndex(_ tableViewIndex: HHIndexView, didSelectSection index:
        NSInteger, withTitle title: NSString) {
            if index < 0 || index > (indexArray.count-1) {
                return
            }
            tableView.scrollToRow(at: NSIndexPath.init(row: 0, section: index) as IndexPath, at: .middle, animated: true)
        }
}

// tableView dataDelegate
extension HHChoiceCuntryController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let choiceCountryModel = dataArray[section]
        return (choiceCountryModel.countries?.count) ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let choiceCountryModel = dataArray[section]
        return HHCommon.shareCommon.createViewForHeaderView(tableView, choiceCountryModel.index!, 16, HHMAINCOLOR())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choiceModel = dataArray[indexPath.section].countries?[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_country_number), object: choiceModel?.val, userInfo: nil)
        navigationController!.popViewController(animated: true)
    }
}

