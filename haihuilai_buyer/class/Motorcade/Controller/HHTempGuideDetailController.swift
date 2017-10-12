//
//  HHTempGuideDetailController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/12.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHTempGuideDetailController: HHBaseTableViewController {
    // 被选择的cell的tag值
    fileprivate var choiceTag:Int?
    // 国家码
    fileprivate var countryNumber: String?
    // 控制全文是否可编辑
    fileprivate var isEdited:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarItem()
//        getInfo()
        
        tableView.register(HHDetailInfoCell.self, forCellReuseIdentifier: "HHDetailInfoCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHNextOrdelegateCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHImageViewCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHDetailInfoTwoCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceCountry(notice:)), name:  NSNotification.Name(rawValue: notification_country_number), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HHTempGuideDetailController.keyboardWillShow(notifice:)), name: .UIKeyboardWillShow, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    // 获取列表信息
    private func getInfo(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: "加载中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getPersonInfoSecond(parameter: nil) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if SUCCESSFUL(response){
                for key in self.showKeyArray {
                    let valueString: String? = response?["data"]?[key] as? String ?? ""
                    self.postParameterDict.updateValue(valueString!, forKey: key)
                }
                for key in self.showKeyArray {
                    let valueString: String? = response?["data"]?[key] as? String ?? ""
                    self.showParameterDict.updateValue(valueString!, forKey: key)
                }
                self.tableView.reloadData()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
        
    }
    //  设置可以编辑按钮
    private func setRightBarItem(){
        let rightBar = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(HHTempGuideDetailController.barItemAction))
        navigationItem.rightBarButtonItem = rightBar
        
    }
    // 给HHDetailInfoCell赋值
    fileprivate func setCellVuale(tableViewCell:HHDetailInfoCell?,index: IndexPath?){
        
        tableViewCell?.detailInfoText.tag = (index?.section)!
        tableViewCell?.detailInfoText.text = self.showParameterDict[self.showKeyArray[(index?.section)!]]
    }
    
    // 处理点击cell
    fileprivate func handleTouchCellForCompanySupplier(indexTag: Int){
        choiceTag = indexTag
//        if indexTag == 3 {
//            let datwPickerView =  HHPickerView()
//            datwPickerView.initWithArray(DataArray: [HHCommon.shareCommon.fromNowTo1970YearsArray()])
//            datwPickerView.pickerViewDelegate = self
//        }
        
    }
    
    fileprivate func handleTouchCellForDriversupply(indexTag: Int){
        choiceTag = indexTag
        switch indexTag {
        case 4:
//            let datwPickerView =  HHPickerView()
//            datwPickerView.initWithArray(DataArray: [HHCommon.shareCommon.fromNowTo1970YearsArray()])
//            datwPickerView.pickerViewDelegate = self
            break
        case 5:
            let dateChoice = HHDateChoice()
                dateChoice.setDatePicker(superView: self.view)
                dateChoice.dateChoiceDelegate = self
            break
        default:
            break
        }
        
    }
    // 选择照片
    fileprivate func choicePhotoImage(){
        let alertController: UIAlertController = UIAlertController.init(title: "", message: "请选择", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alert) in
            
        }))
        
        alertController.addAction(UIAlertAction.init(title: "相册", style: .default, handler: { (alert) in
            HHPhotoPickManager.shareTools.photoPick(pickerTypes: .PickerType_Photo, targetVC: self, photoPickCallBack: { (response, isDefault) in
                if isDefault {
                    self.handleChioceImage(image: response!["UIImagePickerControllerOriginalImage"] as! UIImage)
                }
            })
        }))
        alertController.addAction(UIAlertAction.init(title: "拍照", style: .default, handler: { (alert) in
            HHPhotoPickManager.shareTools.photoPick(pickerTypes: .PickerType_Camera, targetVC: self, photoPickCallBack: { (response, isDefault) in
                if isDefault {
                    self.handleChioceImage(image: response!["UIImagePickerControllerOriginalImage"] as! UIImage)
                }
                
            })
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 处理选择的照片
    private func handleChioceImage(image: UIImage){
        imageArray[choiceTag!] = image
        tableView.reloadRows(at: [IndexPath.init(row: 0, section: choiceTag!)], with: .none)
    }
    
    // 上传编辑的信息
    fileprivate func postInfo(){
        // 检测信息是否完整
        for key in self.showKeyArray {
            let valueString: String? = postParameterDict[key] ?? ""
            if valueString?.characters.count == 0 {
                HHProgressHUD.shareTool.showHUDAddedTo(title: "信息未填写完整，请填写完整", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
                return
            }
        }
        HHProgressHUD.shareTool.showHUDAddedTo(title: "资料提交中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().postPersonInfoThird(parameter: self.postParameterDict as [String : AnyObject]?) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if SUCCESSFUL(response){
                HHProgressHUD.shareTool.showHUDAddedTo(title: "资料提交成功", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
                HHPrint("进入下一步")
                
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
        
    }
    
    // #selector方法
    @objc private func barItemAction(barItem:UIBarButtonItem){
        view.endEditing(true)
        isEdited = !isEdited!
        
    }
    @objc private func observerChoiceLeader(notice:Notification){
        let model = notice.object as! HHChoiceLeaderModel
        
        self.postParameterDict.updateValue(String(model.team_id), forKey: "sub_team_id")
        self.showParameterDict.updateValue(model.fullname!, forKey: "team_leader_name")
        self.tableView.reloadData()
    }
    @objc private func observerChoiceLoaction(notice:Notification){
        let model = notice.object as! HHChoiceLoactionSonModel
        
        self.postParameterDict.updateValue(model.location_id!, forKey: "location_id")
        self.showParameterDict.updateValue(model.location_name!, forKey: "location_name")
        self.tableView.reloadData()
    }
    @objc private func observerChoiceCountry(notice:Notification){
        countryNumber = notice.object as? String
        tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .none)
    }
    @objc private func keyboardWillShow(notifice:NSNotification){
        if !isEdited! {
            view.endEditing(false)
        }
    }
    // 懒加载
    fileprivate var postParameterDict = [String: String]()
    fileprivate var showParameterDict = [String: String]()
    fileprivate var titleArray: [String] = ["真实姓名","联系电话","微信号","驾照","可提供保险","保险有效期","保险照",""]
    fileprivate var showKeyArray:[String] = ["driver_name","driver_mobile","driver_weixin","driver_insurance","driver_insurance_date","driver_id","driver_insurance_id"]
//    fileprivate var postKeyArray:[String] = ["full_name","mobile","weixin","insurance_date","driver_id","insurance_id"];
    fileprivate var imageArray:[UIImage?] = [nil,nil,nil,UIImage(named:"driver"),nil, nil, UIImage(named:"ensure"), nil]
}
/// 日历选择代理
extension HHTempGuideDetailController: HHDateChoiceDelegate{
    func dateEnsureBtnBack(stringfirst: String?) {
        
    }
}

// 点击detailInfoCell的代理
extension HHTempGuideDetailController: HHDetailInfoCellDelegate{
    func selectedDetailInfoCell(cellTag: Int) -> Bool {
        if !isEdited! {
            return false
        }
        if cellTag == 4 || cellTag == 5 {
            view.endEditing(true)
            handleTouchCellForDriversupply(indexTag: cellTag)
            return true
        }else{
            return true
        }
    }
    
    func writeDetailInfoCell(textFields: UITextField) {
        if !isEdited! {
            return
        }
        // 保存信息
        self.postParameterDict.updateValue(textFields.text!, forKey: self.showKeyArray[textFields.tag])
        self.showParameterDict.updateValue(textFields.text!, forKey: self.showKeyArray[textFields.tag])
        
    }
}
// 点击detailInfotwoCell的代理
extension HHTempGuideDetailController: HHDetailInfoTwoCellDelegate{
    func choiceCountryAction() {
        if !isEdited! {
            return
        }
        view.endEditing(true)
        navigationController?.pushViewController(HHChoiceCuntryController(), animated: true)
    }
    func writeDetailInfoTwoCell(textFields: UITextField) {
        
    }
    
}
// 点击HHImageViewCell的代理
extension HHTempGuideDetailController:HHImageViewCellDelegate{
    func choiceimageBtnAction(chioceBtn: UIButton) {
        choiceTag = chioceBtn.tag
        choicePhotoImage()
    }
}
// tableview 的代理和数据源方法
extension HHTempGuideDetailController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if indexPath.section == 7 {
            var nextCell: HHNextOrdelegateCell? = tableView.dequeueReusableCell(withIdentifier: "HHNextOrdelegateCell") as? HHNextOrdelegateCell
            if nextCell == nil {
                nextCell = HHNextOrdelegateCell.init(style: .default, reuseIdentifier: "HHNextOrdelegateCell")
            }
            nextCell?.nextTitle.text = "删除成员"
            nextCell?.selectionStyle = .none
            return nextCell!
        } else if indexPath.section == 3 || indexPath.section == 6{
            var imageCell: HHImageViewCell? = tableView.dequeueReusableCell(withIdentifier: "HHImageViewCell") as? HHImageViewCell
            if imageCell == nil {
                imageCell = HHImageViewCell.init(style: .default, reuseIdentifier: "HHImageViewCell")
            }
            imageCell?.imageViewCellBtn.setBackgroundImage(imageArray[indexPath.section], for: .normal)
            imageCell?.imageViewCellTitle.text = titleArray[indexPath.section]
            
            imageCell?.selectionStyle = .none
            imageCell?.imageViewCellDelegate = self
            imageCell?.imageViewCellBtn.tag = indexPath.section
            return imageCell!
        
        } else if indexPath.section == 1 {
            var twoCell: HHDetailInfoTwoCell? = tableView.dequeueReusableCell(withIdentifier: "HHDetailInfoTwoCell") as? HHDetailInfoTwoCell
            if twoCell == nil {
                twoCell = HHDetailInfoTwoCell.init(style: .default, reuseIdentifier: "HHDetailInfoTwoCell")
            }
            twoCell?.selectionStyle = .none
            // 给cell赋值样式
            if !is_empty_string(countryNumber) {
                twoCell?.detailInfoTwoBtn.setTitle(countryNumber, for: .normal)
                twoCell?.detailInfoTwoBtn.setTitleColor(HHWORDCOLOR(), for: .normal)
            }
            let tel = showParameterDict[showKeyArray[indexPath.section]]
            if !is_empty_string(tel) {
                twoCell?.detailInfoTwoTelephone.text = tel
            }
            twoCell?.detailInfoTwoCellDelegate = self
            return twoCell!

        }else{
            var oneCell: HHDetailInfoCell? = tableView.dequeueReusableCell(withIdentifier: "HHDetailInfoCell") as? HHDetailInfoCell
            if oneCell == nil {
                oneCell = HHDetailInfoCell.init(style: .default, reuseIdentifier: "HHDetailInfoCell")
            }
            if indexPath.section == 0 || indexPath.section == 2 {
                oneCell?.detailInfoImage.isHidden = true
            } else {
                oneCell?.detailInfoImage.isHidden = false
                oneCell?.detailInfoImage.image = UIImage(named:"GRZX-xljt")
            }
            oneCell?.selectionStyle = .none
            // 给cell赋值样式
            setCellVuale(tableViewCell:oneCell!,index: indexPath)
            oneCell?.detailInfoCellDelegate = self
            return oneCell!
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 7 {
            return 60
        } else if indexPath.section == 3 || indexPath.section == 6 {
            return 235
        }else{
            return 70
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

