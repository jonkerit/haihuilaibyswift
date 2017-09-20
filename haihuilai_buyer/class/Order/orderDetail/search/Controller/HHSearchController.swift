//
//  HHSearchController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHSearchController: HHBaseViewController {
    
    fileprivate var menuModels: HHMenuModel?{
        didSet{
            // 弹出不同的键盘
            let string = menuModels?.tag ?? ""
            headerView.headerChoiceBtn.setTitle(menuModels?.content, for: .normal)
            headerView.headerInputView.attributedPlaceholder = NSAttributedString(string: (menuModels?.alert)!, attributes: [
                NSForegroundColorAttributeName : UIColor.gray,
                NSFontAttributeName: UIFont.systemFont(ofSize: 14)
                ])

            switch string {
            case "date":
                dateChoice.setDatePicker(superView: self.view)
                break
            case "booking":
                headerView.headerInputView.keyboardType = .numbersAndPunctuation
                headerView.headerInputView.becomeFirstResponder()
                break
            default:
                headerView.headerInputView.keyboardType = .default
                headerView.headerInputView.becomeFirstResponder()
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    private func setUI(){
        view.addSubview(headerView)
        view.addSubview(historyView)
        view.addSubview(resultView)
        headerView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT-64, 0))
        }
        historyView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(64, 0, 0, 0))
        }
        resultView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(64, 0, 0, 0))
        }
    }
    fileprivate func updateSearchView(content: String?, tags: String?){
        historyView.isHidden = true
        resultView.isHidden = false
        resultView.resultViewQuery = content
        if tags == nil {
            resultView.resultViewTags = "location"
        }else{
            resultView.resultViewTags = tags!
        }
        resultView.searchRequireData()
    }
     /// 懒加载
    fileprivate lazy var headerView: HHHeaderView = {
        let header = HHHeaderView()
        header.headerDelegate = self
        header.headerInputView.delegate = self
        return header
    }()
    fileprivate lazy var menuView: HHMenuView = {
        let menu = HHMenuView()
        menu.menuDelegate = self
        return menu
    }()
    
    fileprivate lazy var historyView: HHHistoryView = {
        let historyView = HHHistoryView()
        historyView.historyViewDelegate = self
        return historyView
    }()
    fileprivate lazy var resultView: HHResultView = {
        let resultView = HHResultView()
        resultView.isHidden = true
        return resultView
    }()
    fileprivate lazy var dateChoice: HHDateChoice = {
        let dateChoice = HHDateChoice()
        dateChoice.dateChoiceDelegate = self
        return dateChoice
    }()
}

extension HHSearchController: HHHeaderViewDelegate{
    func cancelAction() {
        view.endEditing(true)
        self.navigationController!.popViewController(animated: true)
    }
    
    func choiceMenuAction() {
        menuView.frame = view.frame
        view.addSubview(menuView)
    }
}

extension HHSearchController: HHMenuViewDelegate{
    func chioceMenuViewCell(_ menuModel: HHMenuModel?) {
        menuModels = menuModel
        menuView.removeFromSuperview()
    }

}

extension HHSearchController: HHDateChoiceDelegate{
    func dateEnsureBtnBack(stringfirst: String?) {
        headerView.headerInputView.text = stringfirst
        updateSearchView(content: stringfirst, tags: menuModels?.tag)
    }
}

extension HHSearchController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 网络请求
        view.endEditing(true)
        HHPrint("请求表单")
        updateSearchView(content: headerView.headerInputView.text, tags: menuModels?.tag)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // 弹出不同的键盘
        let string = menuModels?.tag ?? ""
        if string == "date" {
            dateChoice.setDatePicker(superView: self.view)
            return false
        }
        return true
    }
}

extension HHSearchController: HHHistoryViewDelegate{
    func historyViewDoUpdateSearch(historyModel: HHHistoryModel?) {
        if !is_empty_string(historyModel?.content) {
//            let model = HHMenuModel()
//            model.content = historyModel?.content
//            model.tag = historyModel?.tag
//            model.alert = ""
//            menuModels = model
            updateSearchView(content: historyModel?.content, tags: historyModel?.tag)
            headerView.headerInputView.text = historyModel?.content
            
        }
    }
}


