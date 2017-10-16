//
//  HHDetailInfoController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/18.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHDetailInfoController: HHBaseTableViewController {
    // 被选择的cell的tag值
    fileprivate var choiceTag:Int?
    // 紧急联系人国家码
    fileprivate var countryNumber: String?
    // 紧急联系人电话号码
    fileprivate var telehoneNumber: String?
    // 控制全文是否可编辑
    fileprivate var isEdited:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarItem()
        getInfo()
        tableView.register(HHDetailInfoCell.self, forCellReuseIdentifier: "HHDetailInfoCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHNextOrdelegateCell")
        tableView.register(HHNextOrdelegateCell.self, forCellReuseIdentifier: "HHDetailInfoTwoCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceLeader(notice:)), name:  NSNotification.Name(rawValue: notification_choiceLeader), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceLoaction(notice:)), name:  NSNotification.Name(rawValue: notification_choiceLocation), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerChoiceCountry(notice:)), name:  NSNotification.Name(rawValue: notification_country_number), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HHDetailInfoController.keyboardWillShow(notifice:)), name: .UIKeyboardWillShow, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    // 获取列表信息
    private func getInfo(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: "加载中...", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getPersonInfoFirst(parameter: nil) { (response, errorString) in
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
                if self.isCompanySupplier {
                    self.countryNumber = response?["data"]?["urgency_code"] as! String?
                    self.telehoneNumber = response?["data"]?["urgency_phone"] as! String?
                }
                self.tableView.reloadData()
            }else{
                HHProgressHUD.shareTool.showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    
    }
    //  设置可以编辑按钮
    private func setRightBarItem(){
        let rightBar = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(HHDetailInfoController.barItemAction))
        navigationItem.rightBarButtonItem = rightBar
        
    }
    // 给HHDetailInfoCell赋值
    fileprivate func setCellVuale(tableViewCell:HHDetailInfoCell?,index: IndexPath?){
        var number: Int?
        if isCompanySupplier {
            if index?.section == 1 {
                number = (index?.row)! + 3
            } else {
                number = (index?.row)!
            }
        }else{
            number = (index?.row)!
        }
        let dict: Dictionary = titleArray[number!]
        // 给detailInfoText赋值
        tableViewCell?.detailInfoText.tag = number!
        tableViewCell?.detailInfoBtn.tag = number!

        tableViewCell?.detailInfoText.text = self.showParameterDict[self.showKeyArray[number!]]
        // 给title赋值
        tableViewCell?.detailInfoTitle.text = dict["title"]
        // 给image赋值
        let strs: String = dict["isHidden"]!
        if strs == "1"  {
            tableViewCell?.detailInfoImage.isHidden = true
            tableViewCell?.detailInfoBtn.isHidden = true

        }else{
            tableViewCell?.detailInfoImage.isHidden = false
            tableViewCell?.detailInfoBtn.isHidden = false

        }
    
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
        // 判断,"urgency_phone","urgency_code"字段
        if isCompanySupplier {
            if !is_empty_string(countryNumber) && !is_empty_string(telehoneNumber) {
                postParameterDict.updateValue(countryNumber!, forKey: "urgency_code")
                postParameterDict.updateValue(telehoneNumber!, forKey: "urgency_phone")
            }else{
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
        navigationController?.pushViewController(HHDetailPictureController(), animated: true)
        
    }
 
    // 懒加载
    fileprivate lazy var postParameter = [String: String]()
    fileprivate lazy var isCompanySupplier: Bool = {
        if HHAccountViewModel.shareAcount.isCompanySupplier{
            return true
        }else{
            return false
        }
    }()
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
        countryNumber = model
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
    fileprivate var titleArray: [[String: String]] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return [["title":"真实姓名","isHidden":"1"],["title":"微信号","isHidden":"1"],["title":"邮箱","isHidden":"1"],["title":"开始从业时间","isHidden":"0"],["title":"车队名称","isHidden":"1"],["title":"紧急联系人姓名","isHidden":"1"],["title":"紧急联系人手机号国家编码","isHidden":"0"],["title":"紧急联系人手机号","isHidden":"1"]]
        }else{
            return [["title":"真实姓名","isHidden":"1"],["title":"微信号","isHidden":"1"],["title":"邮箱","isHidden":"1"],["title":"开始从业时间","isHidden":"0"],["title":"驾照领证时间","isHidden":"0"],["title":"民族","isHidden":"0"],["title":"籍贯","isHidden":"0"],["title":"现居地","isHidden":"0"],["title":"队长姓名","isHidden":"0"]]
        }
        
    }()
    
    fileprivate var showKeyArray:[String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return ["fullname","weixin","email","started_working_date","team_name","urgency_name","urgency_phone","urgency_code"]
        }else{
            return ["fullname","weixin","email","started_working_date","license_date","nation","nation_place","location_name","team_leader_name"]
        }
    
    }()
    fileprivate var postKeyArray:[String] = {
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            return ["fullname","weixin","email","started_working_date","team_name","urgency_name"]
        }else{
            return ["fullname","weixin","email","started_working_date","license_date","nation","nation_place","location_id","sub_team_id"]
        }
        
    }()
    
}
/// 日历选择代理
extension HHDetailInfoController: HHPickerViewDelegate{
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
extension HHDetailInfoController: HHDetailInfoCellDelegate{
    func selectedDetailInfoCell(cellTag: Int){
        if !isEdited! {
            return
        }
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            if cellTag == 3{
                // 跳转页面
                view.endEditing(true)
                if isCompanySupplier {
                    handleTouchCellForCompanySupplier(indexTag: cellTag)
                } else {
                    handleTouchCellForDriversupply(indexTag: cellTag)
                }
            }
        } else {
            if cellTag > 2{
                // 跳转页面
                view.endEditing(true)
                if isCompanySupplier {
                    handleTouchCellForCompanySupplier(indexTag: cellTag)
                } else {
                    handleTouchCellForDriversupply(indexTag: cellTag)
                }
            }
        }
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
extension HHDetailInfoController: HHDetailInfoTwoCellDelegate{
    func choiceCountryAction() {
        if !isEdited! {
            return
        }
        view.endEditing(true)
        navigationController?.pushViewController(HHChoiceCuntryController(), animated: true)
    }
    func writeDetailInfoTwoCell(textFields: UITextField) {
        telehoneNumber = textFields.text
    }
    
}
// tableview 的代理和数据源方法
extension HHDetailInfoController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isCompanySupplier {
            return 3
        }else{
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCompanySupplier {
            switch section {
            case 0:
                return 3
            case 1:
                return 4
            case 2:
                return 1
            default:
                break
            }
        }else{
            switch section {
            case 0:
                return 9
            case 1:
                return 1
            default:
                break
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if isCompanySupplier {
            if indexPath.section == 2 {
                var threeCell: HHNextOrdelegateCell? = tableView.dequeueReusableCell(withIdentifier: "HHNextOrdelegateCell") as? HHNextOrdelegateCell
                if threeCell == nil {
                    threeCell = HHNextOrdelegateCell.init(style: .default, reuseIdentifier: "HHNextOrdelegateCell")
                }
                threeCell?.selectionStyle = .none
                return threeCell!
            }else if indexPath.section == 1 && indexPath.row == 3{
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
                twoCell?.detailInfoTwoTelephone.text = telehoneNumber
                twoCell?.detailInfoTwoCellDelegate = self
                return twoCell!

            
            }else{
                var oneCell: HHDetailInfoCell? = tableView.dequeueReusableCell(withIdentifier: "HHDetailInfoCell") as? HHDetailInfoCell
                if oneCell == nil {
                    oneCell = HHDetailInfoCell.init(style: .default, reuseIdentifier: "HHDetailInfoCell")
                }
                oneCell?.selectionStyle = .none
                // 给cell赋值样式
                setCellVuale(tableViewCell:oneCell!,index: indexPath)
                oneCell?.detailInfoCellDelegate = self
                return oneCell!
            }
        }else{
        
            if indexPath.section == 0 {
                var oneCell: HHDetailInfoCell? = tableView.dequeueReusableCell(withIdentifier: "HHDetailInfoCell") as? HHDetailInfoCell
                if oneCell == nil {
                    oneCell = HHDetailInfoCell.init(style: .default, reuseIdentifier: "HHDetailInfoCell")
                }
                oneCell?.selectionStyle = .none
                // 给cell赋值样式
                setCellVuale(tableViewCell:oneCell!,index: indexPath)
                oneCell?.detailInfoCellDelegate = self
                return oneCell!
            }else{
                var twoCell: HHNextOrdelegateCell? = tableView.dequeueReusableCell(withIdentifier: "HHNextOrdelegateCell") as? HHNextOrdelegateCell
                if twoCell == nil {
                    twoCell = HHNextOrdelegateCell.init(style: .default, reuseIdentifier: "HHNextOrdelegateCell")
                }
                twoCell?.selectionStyle = .none
                return twoCell!
            }

        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HHCommon.shareCommon.createViewForHeaderView(tableView, "ni", 14, HHGRAYCOLOR())
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isCompanySupplier {
            if section == 2{
                return 30
            } else if section == 1{
                return 10
            }else{
                return 0
            }
        }else{
            if section == 1{
                return 30
            } else {
                return 0
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isCompanySupplier {
            if indexPath.section == 2{
                return 60
            } else {
                return 70
            }
        }else{
            if indexPath.section == 1{
                return 60
            } else {
                return 70
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

