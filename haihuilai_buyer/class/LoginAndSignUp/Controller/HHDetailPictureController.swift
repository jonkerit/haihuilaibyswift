//
//  HHDetailPictureController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHDetailPictureController: HHBaseTableViewController {
    // 被选择的cell的tag值
    fileprivate var choiceTag:Int?
    // 是否有保险
    fileprivate var isEnsure:Bool? = false
//    // 紧急联系人电话号码
//    fileprivate var telehoneNumber: String?
    // 控制全文是否可编辑
    fileprivate var isEdited:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarItem()
        getInfo()
        tableView.register(HHDetailInfoCell.self, forCellReuseIdentifier: "HHDetailInfoCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHNextOrdelegateCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHImageViewCell")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceLeader(notice:)), name:  NSNotification.Name(rawValue: notification_choiceLeader), object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceLoaction(notice:)), name:  NSNotification.Name(rawValue: notification_choiceLocation), object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceCountry(notice:)), name:  NSNotification.Name(rawValue: notification_country_number), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HHDetailPictureController.keyboardWillShow(notifice:)), name: .UIKeyboardWillShow, object: nil)
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
                for key in self.postKeyArray {
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
        let rightBar = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(HHDetailPictureController.barItemAction))
        navigationItem.rightBarButtonItem = rightBar
        
    }
    // 给HHDetailInfoCell赋值
    fileprivate func setCellVuale(tableViewCell:HHDetailInfoCell?,index: IndexPath?){
    
        tableViewCell?.detailInfoText.tag = (index?.row)!
        tableViewCell?.detailInfoText.text = self.showParameterDict[self.showKeyArray[(index?.row)!]]
    }
    
    // 处理点击cell
    fileprivate func handleTouchCellForCompanySupplier(indexTag: Int){
        choiceTag = indexTag
        if indexTag == 3 {
            let datwPickerView =  HHPickerView()
            datwPickerView.initWithArray(DataArray: [HHCommon.shareCommon.fromNowTo1970YearsArray()])
            datwPickerView.pickerViewDelegate = self
        }
        
    }
    
    fileprivate func handleTouchCellForDriversupply(indexTag: Int){
        choiceTag = indexTag
        switch indexTag {
        case 3:
            let datwPickerView =  HHPickerView()
            datwPickerView.initWithArray(DataArray: [HHCommon.shareCommon.fromNowTo1970YearsArray()])
            datwPickerView.pickerViewDelegate = self
            break
        case 4:
            let datwPickerView =  HHPickerView()
            datwPickerView.initWithArray(DataArray: [HHCommon.shareCommon.fromNowTo1970YearsArray()])
            datwPickerView.pickerViewDelegate = self
            break
        case 5:
            let arrayM = [["汉族","壮族"," 满族","回族","苗族","维吾尔族","土家族","彝族","蒙古族","藏族","布依族","侗族"," 瑶族","朝鲜族","白族","哈尼族"," 哈萨克族","黎族","傣族","畲族","傈僳族","仡佬族","东乡族"," 高山族","拉祜族","水族","佤族","纳西族","羌族","土族","仫佬族","锡伯族","柯尔克孜族","达斡尔族","景颇族","毛南族","撒拉族","布朗族","塔吉克族","阿昌族"," 普米族","鄂温克族"," 怒族","京族","基诺族","德昂族"," 保安族","俄罗斯族","裕固族","乌兹别克族","门巴族"," 鄂伦春族","独龙族","塔塔尔族"," 赫哲族","珞巴族","其他"]]
            let datwPickerView =  HHPickerView()
            datwPickerView.initWithArray(DataArray:arrayM)
            datwPickerView.pickerViewDelegate = self
            
            break
        case 6:
            let arrayM = [["北京市","天津市","重庆市","上海市","河北省","山西省","辽宁省","吉林省","黑龙江省","江苏省","浙江省","安徽省","福建省","江西省","山东省","河南省","湖北省","湖南省","广东省","海南省","四川省","贵州省","云南省","陕西省","甘肃省","青海省","台湾省","内蒙古自治区","广西壮族自治区","西藏自治区","宁夏回族自治区","新疆维吾尔自治区","香港","澳门","其他"]]
            let datwPickerView =  HHPickerView()
            datwPickerView.initWithArray(DataArray:arrayM)
            datwPickerView.pickerViewDelegate = self
            break
        case 7:HHPrint("跳转到选择区域")
        navigationController?.pushViewController(HHChoiceLoactionFirstController(), animated: true)
            break
        case 8:HHPrint("选择队长")
        navigationController?.pushViewController(HHChoiceLeaderController(), animated: true)
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
        HHProgressHUD.shareTool.showHUDAddedTo(title: "图片处理中", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().postImageInfo(parameter: nil, dataParameter: ["driving_license": image]) { (response, errorString) in
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            
        }
    }
    
    // 上传编辑的信息
    fileprivate func postInfo(){
        // 检测信息是否完整
        for key in self.postKeyArray {
            let valueString: String? = postParameterDict[key] ?? ""
            if valueString?.characters.count == 0 {
                HHProgressHUD.shareTool.showHUDAddedTo(title: "信息未填写完整，请填写完整", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
                return
            }
        }
//        // 判断,"urgency_phone","urgency_code"字段
//        if isCompanySupplier {
//            if !is_empty_string(countryNumber) && !is_empty_string(telehoneNumber) {
//                postParameterDict.updateValue(countryNumber!, forKey: "urgency_code")
//                postParameterDict.updateValue(telehoneNumber!, forKey: "urgency_phone")
//            }else{
//                HHProgressHUD.shareTool.showHUDAddedTo(title: "信息未填写完整，请填写完整", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
//                return
//            }
//        }
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
    @objc private func barItemAction(){
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
        
        let model = notice.object as! String
        self.tableView.reloadData()
    }
    @objc private func keyboardWillShow(notifice:NSNotification){
        if !isEdited! {
            view.endEditing(false)
        }
    }
    // 懒加载
    fileprivate var postParameterDict = [String: String]()
    fileprivate var showParameterDict = [String: String]()
    fileprivate lazy var isCompanySupplier: Bool = {
        if !HHAccountViewModel.shareAcount.isCompanySupplier{
            return true
        }else{
            return false
        }
    }()
    fileprivate var titleArray: [String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return ["身份证","个人生活照","资质证明（公司或组织）","","",""]
        }else{
            return ["驾照图","个人生活照","可提供保险","保险有效期至","保险照",""]
        }
        
    }()
    
    fileprivate var showKeyArray:[String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return ["license","driving_license","company_certificate"]
        }else{
            return ["license","driving_license","car_insurance","car_insurance_date","car_safe_certificate","car_insurance_id"]
        }
    }()
    fileprivate var postKeyArray:[String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return ["license","driving_license","company_certificate"]
        }else{
            return ["license","driving_license","car_insurance_id","car_insurance_date","car_safe_certificate","car_insurance_id"]
        }
        
    }()
    fileprivate var imageKeyArray:[String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return ["ID","living","prove"]
        }else{
            return ["driver","living","","","ensure"]
        }
    }()
    
}
/// 日历选择代理
extension HHDetailPictureController: HHPickerViewDelegate{
    func pickerEnsureBtnBack(stringfirst: String?, stringSecond: String?) {
        var str: String?
        if choiceTag!<5 {
            
            str = HHCommon.shareCommon.subString(inputString: stringfirst!, start: 0, end: 3)
        }else{
            str = stringfirst
        }
        self.postParameterDict.updateValue(str!, forKey: postKeyArray[choiceTag!])
        self.showParameterDict.updateValue(str!, forKey: showKeyArray[choiceTag!])
        
        self.tableView.reloadData()
    }
}

// 点击detailInfoCell的代理
extension HHDetailPictureController: HHDetailInfoCellDelegate{
    func selectedDetailInfoCell(cellTag: Int) -> Bool {
        if !isEdited! {
            return false
        }
        if isCompanySupplier {
            handleTouchCellForCompanySupplier(indexTag: cellTag)
        } else {
            handleTouchCellForDriversupply(indexTag: cellTag)
        }
        return false
    }
    
    func writeDetailInfoCell(textFields: UITextField) {
        if !isEdited! {
            return
        }
        // 筛选信息
        if textFields.tag == 2 && !HHCommon.shareCommon.validateEmail(email: textFields.text){
            HHProgressHUD.shareTool.showHUDAddedTo(title: "请输入正确的邮箱", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            return
        }
        // 保存信息
        self.postParameterDict.updateValue(textFields.text!, forKey: self.postKeyArray[textFields.tag])
        self.showParameterDict.updateValue(textFields.text!, forKey: self.showKeyArray[textFields.tag])
        
    }
}
// 点击detailInfotwoCell的代理
extension HHDetailPictureController: HHDetailInfoTwoCellDelegate{
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
extension HHDetailPictureController:HHImageViewCellDelegate{
    func choiceimageBtnAction(chioceBtn: UIButton) {
        choiceTag = chioceBtn.tag
        choicePhotoImage()
    }
}
// tableview 的代理和数据源方法
extension HHDetailPictureController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isCompanySupplier {
            return 4
        }else{
            if isEnsure! {
                return 6
            } else {
                return 4
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if isCompanySupplier {
            if indexPath.section == 3 {
                var nextCell: HHNextOrdelegateCell? = tableView.dequeueReusableCell(withIdentifier: "HHNextOrdelegateCell") as? HHNextOrdelegateCell
                if nextCell == nil {
                    nextCell = HHNextOrdelegateCell.init(style: .default, reuseIdentifier: "HHNextOrdelegateCell")
                }
                nextCell?.nextTitle.text = "提交审核"
                nextCell?.selectionStyle = .none
                return nextCell!
            }else{
                var imageCell: HHImageViewCell? = tableView.dequeueReusableCell(withIdentifier: "HHImageViewCell") as? HHImageViewCell
                if imageCell == nil {
                    imageCell = HHImageViewCell.init(style: .default, reuseIdentifier: "HHImageViewCell")
                }
                imageCell?.imageViewCellBtn.setBackgroundImage(UIImage(named:imageKeyArray[indexPath.section]), for: .normal)
                imageCell?.imageViewCellTitle.text = titleArray[indexPath.section]
                imageCell?.selectionStyle = .none
                imageCell?.imageViewCellDelegate = self
                imageCell?.imageViewCellBtn.tag = indexPath.section
                return imageCell!
            }
        }else{
            if isEnsure! {
                if indexPath.section == 2 || indexPath.section == 3{
                    var oneCell: HHDetailInfoCell? = tableView.dequeueReusableCell(withIdentifier: "HHDetailInfoCell") as? HHDetailInfoCell
                    if oneCell == nil {
                        oneCell = HHDetailInfoCell.init(style: .default, reuseIdentifier: "HHDetailInfoCell")
                    }
                    oneCell?.selectionStyle = .none
                    // 给cell赋值样式
                    setCellVuale(tableViewCell:oneCell!,index: indexPath)
                    oneCell?.detailInfoCellDelegate = self
                    return oneCell!
                }else if indexPath.section == 5 {
                    var nextCell: HHNextOrdelegateCell? = tableView.dequeueReusableCell(withIdentifier: "HHNextOrdelegateCell") as? HHNextOrdelegateCell
                    if nextCell == nil {
                        nextCell = HHNextOrdelegateCell.init(style: .default, reuseIdentifier: "HHNextOrdelegateCell")
                    }
                    nextCell?.nextTitle.text = "提交审核"
                    nextCell?.selectionStyle = .none
                    return nextCell!
                }else{
                    var imageCell: HHImageViewCell? = tableView.dequeueReusableCell(withIdentifier: "HHImageViewCell") as? HHImageViewCell
                    if imageCell == nil {
                        imageCell = HHImageViewCell.init(style: .default, reuseIdentifier: "HHImageViewCell")
                    }
                    imageCell?.imageViewCellBtn.setBackgroundImage(UIImage(named:imageKeyArray[indexPath.section]), for: .normal)
                    imageCell?.imageViewCellTitle.text = titleArray[indexPath.section]

                    imageCell?.selectionStyle = .none
                    imageCell?.imageViewCellDelegate = self
                    imageCell?.imageViewCellBtn.tag = indexPath.section
                    return imageCell!
                }
 
            } else {
                if indexPath.section == 2 {
                    var oneCell: HHDetailInfoCell? = tableView.dequeueReusableCell(withIdentifier: "HHDetailInfoCell") as? HHDetailInfoCell
                    if oneCell == nil {
                        oneCell = HHDetailInfoCell.init(style: .default, reuseIdentifier: "HHDetailInfoCell")
                    }
                    oneCell?.selectionStyle = .none
                    // 给cell赋值样式
                    setCellVuale(tableViewCell:oneCell!,index: indexPath)
                    oneCell?.detailInfoCellDelegate = self
                    return oneCell!
                }else if indexPath.section == 3 {
                    var nextCell: HHNextOrdelegateCell? = tableView.dequeueReusableCell(withIdentifier: "HHNextOrdelegateCell") as? HHNextOrdelegateCell
                    if nextCell == nil {
                        nextCell = HHNextOrdelegateCell.init(style: .default, reuseIdentifier: "HHNextOrdelegateCell")
                    }
                    nextCell?.nextTitle.text = "提交审核"
                    nextCell?.selectionStyle = .none
                    return nextCell!
                }else{
                    var imageCell: HHImageViewCell? = tableView.dequeueReusableCell(withIdentifier: "HHImageViewCell") as? HHImageViewCell
                    if imageCell == nil {
                        imageCell = HHImageViewCell.init(style: .default, reuseIdentifier: "HHImageViewCell")
                    }
                    imageCell?.imageViewCellBtn.setBackgroundImage(UIImage(named:imageKeyArray[indexPath.section]), for: .normal)
                    imageCell?.imageViewCellTitle.text = titleArray[indexPath.section]
                    imageCell?.imageViewCellBtn.tag = indexPath.section
                    imageCell?.selectionStyle = .none
                    imageCell?.imageViewCellDelegate = self
                    return imageCell!
                }

            }
            
        }
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return HHCommon.shareCommon.createViewForHeaderView(tableView, "ni", 14, HHGRAYCOLOR())
//    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if isCompanySupplier {
//            if section == 2{
//                return 30
//            } else if section == 1{
//                return 10
//            }else{
//                return 0
//            }
//        }else{
//            if section == 1{
//                return 30
//            } else {
//                return 0
//            }
//        }
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isCompanySupplier {
            if indexPath.section == 3{
                return 60
            } else {
                return 235
            }
        }else{
            if isEnsure! {
                if indexPath.section == 5{
                    return 60
                } else if indexPath.section == 2 || indexPath.section == 3 {
                    return 70
                }else{
                    return 235
                }
            } else {
                if indexPath.section == 3 {
                    return 60
                } else if indexPath.section == 2 {
                    return 70
                }else{
                    return 235
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCompanySupplier {
            if indexPath.section == 2{
                postInfo()
            }
        }else{
            if indexPath.section == 1{
                postInfo()
            }
        }
        
    }
}

