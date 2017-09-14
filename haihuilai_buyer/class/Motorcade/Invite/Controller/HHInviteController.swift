//
//  HHInviteController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/13.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
import MessageUI
class HHInviteController: HHBaseViewController {
    // 短信的内容
    fileprivate var messagecontent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarItem()
        getMessageContent()
        getContactStore()
        view.addSubview(tableView)
        view.addSubview(indexView)
    }
    private func setBarItem(){
        let barItem = UIBarButtonItem.init(title: "邀请", style: .plain, target: self, action:#selector(HHInviteController.inviteAction))
        navigationItem.rightBarButtonItem = barItem
    }
    
    private func getContactStore(){
        //  读取通讯录
        HHAddressBook().readAllPeoples { (response, error) in
            DispatchQueue.global().sync {
                // 排序
                HHCommon.shareCommon.sequenceAndGroups(inputArray: response, contactOrderResult: {[weak self] (contentResult, titleResult) in
                    if (contentResult?.count)! > 0 && (titleResult?.count)! > 0{
                        self?.contentArray = contentResult!
                        self?.titleArray = titleResult!
                        self?.tableView.reloadData()
                    }
                })
            }
        }
    }
    //  获取短信内容
    private func getMessageContent(){
        HHProgressHUD().showHUDAddedTo(title: nil, isImage: true, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getMessageContent(parameter: nil) { (response, errorString) in
            HHProgressHUD().hideHUDForView(boardView: HHKeyWindow, animated: true)
            if SUCCESSFUL(response){
                self.messagecontent = response?["data"] as! String?
            }else{
                HHProgressHUD().showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)

            }
        }
    }
    //  @objct方法
    @objc private func inviteAction(){
        if MFMessageComposeViewController.canSendText() {
            HHPrint("模拟器不支持发送短信")
            return
        }
        if telephoneNumberArray.count == 0 {
            HHProgressHUD().showHUDAddedTo(title: "请选择要邀请的人", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            return
        }
        let vc = MFMessageComposeViewController()
        vc.body = self.messagecontent
        vc.recipients = telephoneNumberArray;
        vc.navigationBar.tintColor = UIColor.white;
        vc.messageComposeDelegate = self;
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    // 懒加载
    lazy fileprivate var tableView:UITableView = {
        let rect = CGRect(x:0,y:0,width:self.view.frame.size.width - 25,height:self.view.frame.size.height - 64)
        let tableView = UITableView.init(frame:rect)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = HHGRAYCOLOR()
        tableView.register(HHInviteCell.self, forCellReuseIdentifier: "HHInviteCell")
        return tableView
    }()
    lazy fileprivate var indexView:HHIndexView = {
        let index = HHIndexView.init(frame:CGRect(x:Int(SCREEN_WIDTH - 25),y:Int(SCREEN_HEIGHT/3),width:25,height:16*self.titleArray.count + 20),dataArray: self.titleArray as [AnyObject])
        index.indexViewDelelgate = self
        return index
    }()
    // 内容（model）的数组
    lazy fileprivate var contentArray = [[HHInviteModel]]()
    // 标题的数组
    lazy fileprivate var titleArray = [String]()
    // 选择的号码的数组
    lazy fileprivate var telephoneNumberArray = [String]()
    
}

extension HHInviteController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = contentArray[section]
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var inviteCell = tableView.dequeueReusableCell(withIdentifier: "HHInviteCell") as? HHInviteCell
        if inviteCell == nil {
            inviteCell = HHInviteCell.init(style: .default, reuseIdentifier: "HHInviteCell")
        }
        let model = contentArray[indexPath.section][indexPath.row]
        inviteCell?.inviteCellTitle.text = model.inviteName
        inviteCell?.inviteCellDetail.text = model.inviteNumber
        return inviteCell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HHCommon.shareCommon.createViewForHeaderView(tableView, titleArray[section], 16, HHMAINCOLOR())
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell:HHInviteCell = tableView.cellForRow(at: indexPath) as! HHInviteCell
        cell.inviteCellImage.isSelected = !cell.inviteCellImage.isSelected
        if cell.inviteCellImage.isSelected && !is_empty_string(cell.inviteCellDetail.text){
            telephoneNumberArray.append(cell.inviteCellDetail.text!)
        }else if !is_empty_string(cell.inviteCellDetail.text) {
            telephoneNumberArray.remove(at: telephoneNumberArray.index(of: cell.inviteCellDetail.text!)!)
        }
        
    }
}

extension HHInviteController:MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if result.rawValue == 2 {
            HHProgressHUD().showHUDAddedTo(title: "邀请失败", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)

        }else if result.rawValue == 1{
            HHProgressHUD().showHUDAddedTo(title: "邀请成功", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)

        }
    }
}
extension HHInviteController:HHIndexViewDelelgate{
    func tableViewIndex(_ tableViewIndex: HHIndexView, didSelectSection index: NSInteger, withTitle title: NSString) {
        let sonCount = contentArray[index].count
        if sonCount<1 {
            return
        }
        tableView.scrollToRow(at: NSIndexPath.init(row: 0, section: index) as IndexPath, at: .middle, animated: true)
    }
}
