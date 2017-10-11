//
//  HHJourneyChangeController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
enum JourneyChange: String {
    case CHANGE = "changeJourney"
    case OPINION = "postOpinion"
}
class HHJourneyChangeController: HHBaseViewController {
    // 订单号
    var journeyChangeBookingId: String?
    // 选择的图片
    var choiceImage: UIImage?
    // 提示语
    var warmString: String?
    // 标记
    var journeyChangeVC:JourneyChange?{
        didSet{
            if journeyChangeVC == .CHANGE {
                warmString = "行程变更"
                imageBtn.setBackgroundImage(UIImage(named:"upload_change"), for: .normal)
            } else {
                warmString = "上传意见单"
                imageBtn.setBackgroundImage(UIImage(named:"upload_service"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = warmString
        setUI()
    }
    private func setUI(){
        view.addSubview(titlelabel)
        view.addSubview(imageBtn)
        view.addSubview(postBtn)
        
        titlelabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)?.setOffset(10)
            make?.left.equalTo()(self.view)?.setOffset(10)
        }
        imageBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.titlelabel.mas_bottom)?.setOffset(10)
            make?.left.equalTo()(self.view)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-20,height: 195*APP_HEIGHT_MATCH))
        }
        postBtn.mas_makeConstraints { (make) in
            make!.bottom.equalTo()(self.view)
            make!.left.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height: 60))
        }
        
        
    }
    // 选择照片
    private func goToChioce(type:pickerType){
        HHPhotoPickManager.shareTools.photoPick(pickerTypes: type, targetVC: self, photoPickCallBack: { (response, isOK) in
            if isOK {
                self.choiceImage = response!["UIImagePickerControllerOriginalImage"] as? UIImage
                self.imageBtn.setBackgroundImage(self.choiceImage, for: .normal)
            }
        })
    }
    
    // #selector方法
    @objc private func choicePhoto(){
        let alertController: UIAlertController = UIAlertController.init(title: "", message: "请选择", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alert) in
            
        }))
        
        alertController.addAction(UIAlertAction.init(title: "相册", style: .default, handler: { (alert) in
            self.goToChioce(type: .PickerType_Photo)
        }))
        alertController.addAction(UIAlertAction.init(title: "相机", style: .default, handler: { (alert) in
            self.goToChioce(type: .PickerType_Camera)

        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    @objc private func postPhoto(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: "上传中", isImage: true, boardView: HHKeyWindow, animated: true)
        if journeyChangeVC == .CHANGE {
            HHNetworkClass().postTravelChangeImage(parameter: ["booking_id":self.journeyChangeBookingId as AnyObject], dataParameter: ["travel_change_info": self.choiceImage!], networkClassData: { (response, errorString) in
                HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            })
        } else {
            HHNetworkClass().postOpinionImage(parameter: ["booking_id":self.journeyChangeBookingId as AnyObject], dataParameter: ["opinion": self.choiceImage!], networkClassData: { (response, errorString) in
                HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            })
        }

    }
    
    private lazy var titlelabel:UILabel = {
        let title = UILabel.init(title: self.warmString!, fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return title
    }()
    
    private lazy var imageBtn: UIButton = {
        let btn = UIButton.init(action: #selector(choicePhoto), target: self, title: nil, backgroudImageName: "", fontColor: nil, fontSize: nil)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    private lazy var postBtn: UIButton = UIButton.init(action: #selector(postPhoto), target: self, title: "提交", backgroudImageName: "main_light", fontColor: UIColor.white, fontSize: 16)

}
