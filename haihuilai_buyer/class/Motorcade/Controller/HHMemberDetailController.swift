//
//  HHMemberDetailController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/19.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
import UIKit
enum MemberDetailFrom: String{
    case NEWSVC = "newsVc"
    case EDITTEMPGUIDE = "editTempGuide"
    case DELIVETEMPGUIDE = "deliveTmpGuide"
}

class HHMemberDetailController: HHBaseTableViewController {
    // 导游的ID
    var memberDetailDriverId: String?
    //  导游的已完成的订单数量
    var memberDataDic: [String: AnyObject]?
    // 订单ID
    var memberDetailBookingId: String?
    // 从where进来的
    var memberDetailFrom: MemberDetailFrom?
    // 记录cell
    var threeView: HHMemberDetailThreeView?
    
    private var dataDict: [String: String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        tableView.register(HHDetailInfoCell.self, forCellReuseIdentifier: "HHMemberDetailOneCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHNextOrdelegateCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHMemberDetailTwoCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHMemberDetailThreeCell")
        NotificationCenter.default.addObserver(self, selector: #selector(observerCalenderButton(notice:)), name:  NSNotification.Name(rawValue: notification_CalenderBtn), object: nil)

//        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceCountry(notice:)), name:  NSNotification.Name(rawValue: notification_country_number), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(HHTempGuideDetailController.keyboardWillShow(notifice:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func getInfo(){
        var parameters = ["driver_supplier_id": memberDetailDriverId]
        if memberDetailFrom == .DELIVETEMPGUIDE {
            parameters.updateValue(memberDetailBookingId, forKey: "booking_id")
        }
        HHNetworkClass().getGuideInfo(parameter: parameters as [String : AnyObject]) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if SUCCESSFUL(response){
                self.memberDataDic = response?["data"] as! [String : AnyObject]?
                self.tableView.reloadData()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }

    }
    
    //  #selector 方法
    @objc private func observerCalenderButton(notice: Notification){
        let array = (notice.object as! HHMotorCadeDetailModel).bookings
        
        self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 2), at: .middle, animated: true)

        let time = DispatchTimeInterval.seconds(1)
        let delayTime: DispatchTime = DispatchTime.now() + time
        DispatchQueue.global().asyncAfter(deadline: delayTime) {
            DispatchQueue.main.async {
                self.threeView?.memberDetailThreeArray = array
            }
        }

    }
    
    // 懒加载
    fileprivate lazy var nameArray = ["基本信息","订单","车导认证"]

}

// tableview 的代理和数据源方法
extension HHMemberDetailController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if indexPath.section == 0 {
            var oneCell = tableView.dequeueReusableCell(withIdentifier: "HHMemberDetailOneCell") as? HHMemberDetailOneCell
            if oneCell == nil {
                oneCell = HHMemberDetailOneCell.init(style: .default, reuseIdentifier: "HHMemberDetailOneCell")
            }
            oneCell?.selectionStyle = .none
            oneCell?.memberDetailOneNameLabel.text = nameArray[indexPath.row]
            if indexPath.row == 1 && memberDataDic != nil{
                oneCell?.memberDetailOneDetailLabel.text = String(describing: memberDataDic!["bookings_count"]!)
            }else{
                oneCell?.memberDetailOneDetailLabel.text = ""
            }
            return oneCell!
        }else if indexPath.section == 1 {
            var twoCell = tableView.dequeueReusableCell(withIdentifier: "HHMemberDetailTwoCell") as? HHMemberDetailTwoCell
            if twoCell == nil {
                twoCell = HHMemberDetailTwoCell.init(style: .default, reuseIdentifier: "HHMemberDetailTwoCell")
            }
            twoCell?.selectionStyle = .none
            twoCell?.cellDriver_supplier_id = memberDetailDriverId
            let ndf = DateFormatter()
            ndf.dateFormat = "yyyy-MM"
            twoCell?.dateString = ndf.string(from: Date())
            return twoCell!
        }else if indexPath.section == 2 {
            var threeCell = tableView.dequeueReusableCell(withIdentifier: "HHMemberDetailThreeCell") as? HHMemberDetailThreeCell
            if threeCell == nil {
                threeCell = HHMemberDetailThreeCell.init(style: .default, reuseIdentifier: "HHMemberDetailThreeCell")
            }
            threeView = threeCell?.memberDetailThreeView
            threeCell?.selectionStyle = .none
            return threeCell!
        }else{
            
            var nextCell = tableView.dequeueReusableCell(withIdentifier: "HHNextOrdelegateCell") as? HHNextOrdelegateCell
            if nextCell == nil {
                nextCell = HHNextOrdelegateCell.init(style: .default, reuseIdentifier: "HHMemberDetailThreeCell")
            }
            nextCell!.nextTitle.text = "删除成员"
            nextCell!.selectionStyle = .none
            return nextCell!
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }else if indexPath.section == 1 {
            return 420
        }else if indexPath.section == 2 {
            return 140
        }else{
            return 70
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return HHCommon.shareCommon.createViewForHeaderView(tableView, "日常安排", 14, HHWORDGAYCOLOR())
        }else{
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }else{
            return 0.01
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 7 {
            // 确认
        } else if indexPath.section == 3 || indexPath.section == 6 {
            // 选择图片
        }
        
    }
}

