//
//  HHTempGuideDetailController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/12.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

enum DeliveTempGuide: String{
    case ADDTEMPGUIDE = "addTempGuide"
    case EDITTEMPGUIDE = "editTempGuide"
    case DELIVETEMPGUIDE = "deliveTmpGuide"
}
import UIKit
import SDWebImage
class HHTempGuideDetailController: HHBaseTableViewController {
    
    // 订单号
    var tempGuideBookingId: String?
    // driver_id
    var tempGuideDriver_id: String?
    // 被选择的cell的tag值
    fileprivate var choiceTag:Int?
    // 国家码
    fileprivate var countryNumber: String?
    // 保险的字典
    fileprivate var insuranceDic = [String: String]()
    //
    // 控制全文是否可编辑
    fileprivate var isEdited:Bool = false {
        didSet{
            if isEdited {
                rightBarBtn.setTitle("保存", for: .normal)
            } else {
                rightBarBtn.setTitle("编辑", for: .normal)
            }
        }
        
    }
    // 打开页面的来源
    var tempGuidefrom: DeliveTempGuide?{
        didSet{
            switch tempGuidefrom! {
            case .ADDTEMPGUIDE:
                break
            case .EDITTEMPGUIDE:
                break
            case .DELIVETEMPGUIDE:
                break
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarItem()
        if tempGuidefrom == .EDITTEMPGUIDE || tempGuidefrom == .DELIVETEMPGUIDE {
             getInfo()
        }
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
        if is_empty_string(tempGuideDriver_id) {
            return
        }
        HHProgressHUD.shareTool.showHUDAddedTo(title: "加载中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getTempGuideInfo(parameter: ["driver_id":tempGuideDriver_id! as AnyObject]) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            if SUCCESSFUL(response){
                self.countryNumber = response?["data"]?["driver_country_code"] as! String?
                for key in self.showKeyArray {
                    let valueString: String? = response?["data"]?[key] as? String ?? ""
                    self.showParameterDict.updateValue(valueString!, forKey: key)
                }
                for key in self.postKeyArray {
                    let valueString: String? = response?["data"]?[key] as? String ?? ""
                    self.postParameterDict.updateValue(valueString!, forKey: key)
                }
                self.tableView.reloadData()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
        
    }
    //  设置可以编辑按钮
    private func setRightBarItem(){
        let rightBar = UIBarButtonItem.init(customView: rightBarBtn)
        navigationItem.rightBarButtonItem = rightBar
        
    }
    // 给HHDetailInfoCell赋值
    fileprivate func setCellVuale(tableViewCell:HHDetailInfoCell?,index: IndexPath?){
        
        tableViewCell?.detailInfoText.tag = (index?.section)!
        tableViewCell?.detailInfoBtn.tag = (index?.section)!
        tableViewCell?.detailInfoTitle.text = titleArray[(index?.section)!]
        tableViewCell?.detailInfoText.text = self.showParameterDict[self.showKeyArray[(index?.section)!]]
    }
    
    // 处理点击cell
//    fileprivate func handleTouchCellForCompanySupplier(indexTag: Int){
//        choiceTag = indexTag
//        if indexTag == 3 {
//            let datwPickerView =  HHPickerView()
//            datwPickerView.initWithArray(DataArray: [HHCommon.shareCommon.fromNowTo1970YearsArray()])
//            datwPickerView.pickerViewDelegate = self
//        }
        
//    }
    
    fileprivate func handleTouchCellForDriversupply(indexTag: Int){
        choiceTag = indexTag
        switch indexTag {
        case 4:
            HHProgressHUD.shareTool.showHUDAddedTo(title:nil, isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
            HHNetworkClass().getInsuranceIist(parameter: ["has_no": "0" as AnyObject], networkClassData: { (response, errorString) in
                HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
                if SUCCESSFUL(response) {
                    var insuranceName = [String]()
                    for obj in response?["data"] as! [[String: AnyObject]] {
                        insuranceName.append(obj["insurance"] as! String)
                        self.insuranceDic.updateValue(obj["insurance_id"] as! String, forKey: obj["insurance"] as! String)
                    }
                    let datwPickerView =  HHPickerView()
                    datwPickerView.initWithArray(DataArray: [insuranceName])
                    datwPickerView.pickerViewDelegate = self
                }else{
                    HHProgressHUD.shareTool.showHUDAddedTo(title:errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
                }
            })
            break
        case 5:
            let dateChoice = HHDateChoice()
                dateChoice.dateChoiceDelegate = self
            break
        default:
            break
        }
        
    }
    // 选择照片
    fileprivate func choicePhotoImage(){
        if !isEdited {
            return
        }
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
        isEdited = !isEdited
        view.endEditing(true)
        
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
        if !isEdited {
            view.endEditing(false)
        }
    }
    // 懒加载
    fileprivate lazy var postParameterDict = [String: String]()
    fileprivate lazy var showParameterDict = [String: String]()
    fileprivate lazy var titleArray: [String] = ["真实姓名","联系电话","微信号","驾照","可提供保险","保险有效期","保险照",""]
    fileprivate lazy var showKeyArray:[String] = ["driver_name","driver_mobile","driver_weixin","driver_picture","driver_insurance","driver_insurance_date","driver_safe_certificate","driver_id"]
    fileprivate lazy var postKeyArray:[String] = ["full_name","mobile","weixin","driver_picture","driver_insurance_id","insurance_date","driver_safe_certificate","driver_id"];
    fileprivate lazy var imageArray:[UIImage?] = [nil,nil,nil,UIImage(named:"driver"),nil, nil, UIImage(named:"ensure"), nil]
    fileprivate lazy var postImageArray:[UIImage?] = [nil,nil,nil,nil,nil, nil, nil, nil]
    fileprivate lazy var rightBarBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHTempGuideDetailController.barItemAction), target: self as AnyObject, title: "编辑", imageName: "DL-jt", fontColor: UIColor.white, fontSize: 16)
        return btn
    }()
}
/// 日历选择代理
extension HHTempGuideDetailController: HHDateChoiceDelegate{
    func dateEnsureBtnBack(stringfirst: String?) {
        // 保存信息
        self.postParameterDict.updateValue(stringfirst!, forKey: self.showKeyArray[5])
        self.showParameterDict.updateValue(stringfirst!, forKey: self.showKeyArray[5])
        self.tableView.reloadRows(at: [IndexPath.init(item: 0, section: 5)], with: .none)
    }
}

// 点击detailInfoCell的代理
extension HHTempGuideDetailController: HHDetailInfoCellDelegate{
    func selectedDetailInfoCell(cellTag: Int){
        if !isEdited {
            return
        }
        if cellTag == 4 || cellTag == 5 {
            view.endEditing(true)
            handleTouchCellForDriversupply(indexTag: cellTag)
        }
    }
    
    func writeDetailInfoCell(textFields: UITextField) {
        if !isEdited {
            return
        }
        // 保存信息
        self.postParameterDict.updateValue(textFields.text!, forKey: self.showKeyArray[textFields.tag])
        self.showParameterDict.updateValue(textFields.text!, forKey: self.showKeyArray[textFields.tag])
        self.tableView.reloadRows(at: [IndexPath.init(item: 0, section: textFields.tag)], with: .none)
        
    }
}
// 点击detailInfotwoCell的代理
extension HHTempGuideDetailController: HHDetailInfoTwoCellDelegate{
    func choiceCountryAction() {
        if !isEdited {
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
// 保险类型选择
extension HHTempGuideDetailController: HHPickerViewDelegate{
    func pickerEnsureBtnBack(stringfirst: String?, stringSecond: String?) {
        // 保存信息
        self.postParameterDict.updateValue(insuranceDic[stringfirst!]!, forKey: self.showKeyArray[4])
        self.showParameterDict.updateValue(stringfirst!, forKey: self.showKeyArray[4])
        self.tableView.reloadRows(at: [IndexPath.init(item: 0, section: 4)], with: .none)
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
            let urlString =  self.showParameterDict[self.showKeyArray[indexPath.section]]
            //  下载照片
            if !is_empty_string(urlString) && self.postImageArray [indexPath.section] == nil {
                let str = HH_SERVER_URL + urlString!
                imageCell?.imageViewCellBtn.sd_setBackgroundImage(with: URL.init(string: str), for: .normal, completed: { (images, error, models, url) in
                    if images != nil {
                        self.imageArray[indexPath.section] = images
                        self.postImageArray [indexPath.section] = images
                    }
                })
            }
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
                oneCell?.detailInfoBtn.isHidden = true
                oneCell?.detailInfoImage.image = UIImage(named:"DL-jt")
            } else {
                oneCell?.detailInfoImage.isHidden = false
                oneCell?.detailInfoBtn.isHidden = false
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
        if !isEdited {
            return
        }
        if indexPath.section == 7 {
            // 确认
        } else if indexPath.section == 3 || indexPath.section == 6 {
            // 选择图片
        }
        
    }
}

