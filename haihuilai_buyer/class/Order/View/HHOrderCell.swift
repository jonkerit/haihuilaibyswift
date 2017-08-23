//
//  HHOrderCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHOrderCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var startPlace: UILabel!
    @IBOutlet weak var endPlace: UILabel!
    @IBOutlet weak var channel: UILabel!
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var localPrice: UILabel!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var status_cn: UILabel!
    @IBOutlet weak var changeInfoBtn: UIButton!

    var listType: String?
    
    var orderModel: HHOrderModel? {
        didSet{
            if orderModel == nil {
                return
            }
            startPlace.text = orderModel?.locations
            endPlace.text = orderModel?.end_place
            status_cn.text = orderModel?.status_cn
            type.text = orderModel?.type
            dates.text = orderModel?.dates
            driverImageView.image = UIImage(named:setDriverImageView(type_en: orderModel?.type_en)!)
            // 对
            if HHAccountViewModel.shareAcount.isCompanySupplier == true{
                localPrice.text = orderModel?.locale_price
                setSriverName()
                localPrice.isHidden = false
                driverName.isHidden = false
            } else {
                localPrice.isHidden = true
                driverName.isHidden = true
            }
            // 信息变更提示
            if orderModel?.is_change_info == true {
                changeInfoBtn.setTitle("订单信息有变更", for: .normal)
            }
            if orderModel?.is_upload_opinion == true {
                changeInfoBtn.setTitle("未上传意见单", for: .normal)
            }
            
            if orderModel?.is_change_info == true || orderModel?.is_upload_opinion == true{
                changeInfoBtn.isHidden = false
            } else {
                changeInfoBtn.isHidden = true
            }
            status_cn.textColor = setStatus_cnWordColor(typeForOrder: orderModel?.status)
            repeatChannel(channelString: orderModel?.channel)
            backView.layer.cornerRadius = 6
            backView.layer.masksToBounds = true
        }
    }
    
    // 设置图片
    private func setDriverImageView(type_en: String?) -> String? {
        var imageName: String?
        if type_en == "air_booking" {
            imageName = "order_list_1"
        } else if type_en == "train_booking" {
            imageName = "order_list_4"
        }else{
            imageName = "order_list_3"
        }
        return imageName
    }
    // 设置字体颜色
    private func setStatus_cnWordColor(typeForOrder: String?) -> UIColor? {
        if typeForOrder == "cancelled" || typeForOrder == "cancelling" {
            return HHWORDGAYCOLOR()
        } else if typeForOrder == "complain" {
            return UIColor.red
        }else{
            return HHWORDGAYCOLOR()
        }
    }
    // 设置订单标签边框
    private func repeatChannel(channelString: String?){
        if is_empty_string(channelString) {
            channel.isHidden = true
        }else{
            channel.isHidden = false
            channel.text = channelString
            let channelLayer = channel.layer
            channelLayer.cornerRadius = 2.0
            channelLayer.masksToBounds = true
            channelLayer.borderWidth = 1.0
            channelLayer.borderColor = HHWORDGAYCOLOR().cgColor
        }
    }
    // 设置导游名称显示driver_name
    private func setSriverName(){
        if is_empty_string(orderModel?.driver_name){
            driverName.text = "未指派导游"
            if listType == "supplier_unstart" {
                driverName.textColor = UIColor.red
            } else {
                driverName.textColor = HHWORDGAYCOLOR()
            }
        } else {
            driverName.text = "导游  "+(orderModel?.driver_name)!
            driverName.textColor = HHWORDGAYCOLOR()
        }
    }
}
