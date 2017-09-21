//
//  HHLeaderDetailController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/21.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHLeaderDetailController: HHBaseViewController {

    // 数据模型
    var leaderDetailModel:HHChoiceLeaderModel?
        {
        didSet{
            dataArray = [(leaderDetailModel?.fullname)!, (leaderDetailModel?.team_name)! ,String(stringInterpolationSegment: leaderDetailModel!.team_id), (leaderDetailModel?.services)!]
        }
    }
    fileprivate var dataArray: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    private func setUI(){
        nextBtn.backgroundColor = HHMAINCOLOR()
        view.addSubview(tableView)
        view.addSubview(nextBtn)
        
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(0, 0, 60, 0))
        }
        nextBtn.mas_makeConstraints { (make) in
           make!.bottom.equalTo()(self.view)
           make!.left.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
    }
    
    @objc private func nextBtnAction(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_choiceLeader), object: leaderDetailModel!)
        let vc = navigationController?.viewControllers
        navigationController!.popToViewController((vc?[(vc?.count)!-3])!, animated: true)
    }
    
    // 懒加载
    lazy fileprivate var nextBtn = UIButton.init(action: #selector(HHLeaderDetailController.nextBtnAction), target: self as AnyObject, title: "确认选择", imageName: nil, fontColor: UIColor.white, fontSize: 16)
    lazy fileprivate var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.register(HHLeaderDetailCell.self, forCellReuseIdentifier: "HHLeaderDetailCell")
        return tableView
        
    }()
    
    lazy fileprivate var titleArray: [String] = ["队长姓名","车队名称","车队ID","服务区域"]
}

// tableView dataDelegate
extension HHLeaderDetailController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        var cell:HHLeaderDetailCell?  = tableView.dequeueReusableCell(withIdentifier: "HHLeaderDetailCell") as?  HHLeaderDetailCell
        if cell == nil {
            cell = HHLeaderDetailCell.init(style: .default, reuseIdentifier: "HHLeaderDetailCell")
        }
        cell?.leaderDetailTitle.text = titleArray[indexPath.row]
        cell?.leaderDetail.text = dataArray?[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HHCommon.shareCommon.createViewForHeaderView(tableView, "请再次确认信息是否正确", 14, HHWORDGAYCOLOR())
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return HHCommon.shareCommon.obtainStringLength(leaderDetailModel?.services, 16, CGSize(width:SCREEN_WIDTH-30,height:CGFloat(MAXFLOAT))).height + 50
        } else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
