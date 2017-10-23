//
//  HHMemberDetailTwoCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/19.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHMemberDetailTwoCell: UITableViewCell {
 
    //  车导的ID
    var cellDriver_supplier_id : String?
    // 日期（YY－MM）
    var dateString: String?
        {
        didSet{
            getInfo()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 获取列表信息
    private func getInfo(){
        // 区分
        HHProgressHUD.shareTool.showHUDAddedTo(title: "加载中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        let parameters = ["driver_supplier_id":cellDriver_supplier_id, "month": dateString]
        HHNetworkClass().getDriverStockList(parameter: parameters as [String : AnyObject]) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
                self.calenderView.setCalenderButton(choiceButtonArray: response as! [HHMotorCadeDetailModel]?)
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
        
    }
    

    
    private func setUI(){
        calenderView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:420)
        calenderView.inputDate = Date()
        contentView.addSubview(calenderView)
        weak var weakSelf = self
        // block 处理
        calenderView.backForFront = {(_ date) in
            let ndf = DateFormatter()
            ndf.dateFormat = "yyyy-MM"
            weakSelf?.dateString = ndf.string(from: date)
        }
        // block 处理
        calenderView.backForNext = {(_ date) in
            let ndf = DateFormatter()
            ndf.dateFormat = "yyyy-MM"
            weakSelf?.dateString = ndf.string(from: date)
        }

    }
    
    // 懒加载
    lazy var calenderView: HHCalenderView = {
        let view = HHCalenderView()
        return view
    }()
}
