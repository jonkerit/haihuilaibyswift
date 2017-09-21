//
//  HHChoiceLoactionThirdController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/21.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceLoactionThirdController: HHBaseViewController {
    var locationThirdID: String?
    fileprivate var dataArray:[HHChoiceLoactionThirdModel]?
    fileprivate var indexArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        updata()
    }
    
    private func updata(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: "加载中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        
        HHNetworkClass().getLocationThirdList(parameter: ["location_id":locationThirdID as AnyObject]) { (response, errrorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil {
                self.dataArray = response as? [HHChoiceLoactionThirdModel]
                if self.dataArray?.count == 0{
                    return
                }
                for object in self.dataArray!{
                    self.indexArray.append(object.index!)
                }
                self.view.addSubview((self.indexView))
                self.tableView.reloadData()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errrorString, isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    
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
        tableView.register(HHChoiceLeaderCell.self, forCellReuseIdentifier: "HHChoiceLeaderCell")
        return tableView
    }()
    deinit {
        print("我被移除了")
    }

}
// 索引的代理
extension HHChoiceLoactionThirdController: HHIndexViewDelelgate{
    func tableViewIndex(_ tableViewIndex: HHIndexView, didSelectSection index:
        NSInteger, withTitle title: NSString) {
        if index < 0 || index > (indexArray.count-1) {
            return
        }
        self.tableView.scrollToRow(at: NSIndexPath.init(row: 0, section: index) as IndexPath, at: .middle, animated: true)
    }
}
// tableView dataDelegate
extension HHChoiceLoactionThirdController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataArray?[section]
        return model?.locations?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        var cell:HHChoiceLeaderCell?  = tableView.dequeueReusableCell(withIdentifier: "HHChoiceLeaderCell") as?  HHChoiceLeaderCell
        if cell == nil {
            cell = HHChoiceLeaderCell.init(style: .default, reuseIdentifier: "HHChoiceLeaderCell")
        }
        let model = self.dataArray?[indexPath.section]

        cell?.choiceLeaderTitle.text = model?.locations?[indexPath.row].location_name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HHCommon.shareCommon.createViewForHeaderView(tableView, (self.dataArray?[section].index)!, 16, HHMAINCOLOR())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArray?[indexPath.section]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_choiceLocation), object: model?.locations?[indexPath.row])
        let vc = navigationController?.viewControllers
        navigationController!.popToViewController((vc?[(vc?.count)!-4])!, animated: true)

    }
    
}
