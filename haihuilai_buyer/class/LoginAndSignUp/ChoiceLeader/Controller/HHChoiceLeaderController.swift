//
//  HHChoiceLeaderController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/20.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceLeaderController: HHBaseViewController {

    fileprivate var dataArray:[HHChoiceLeaderModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    private func setUI(){
        view.addSubview(backgroud)
        view.addSubview(tableView)
        backgroud.addSubview(seach)
        backgroud.addSubview(choiceLeaderCancel)
        backgroud.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT-64, 0))
        }
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(64, 0,0, 0))
        }
        seach.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.backgroud)?.setOffset(25)
            make?.left.equalTo()(self.backgroud)?.setOffset(15)
            make!.height.equalTo()(34)
            make?.right.equalTo()(self.choiceLeaderCancel.mas_left)?.setOffset(-15)
        }
        choiceLeaderCancel.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self.seach)
            make?.right.equalTo()(self.backgroud)?.setOffset(-15)
            make!.height.mas_equalTo()(CGSize(width:35,height:17))

        }
    }
    
    fileprivate func updata(seachString: String){
        HHNetworkClass().getSearchLeaderList(parameter: ["q":seachString as AnyObject]) { (response, errorSrting) in
            if response != nil{
                self.dataArray = response as! [HHChoiceLeaderModel]?
                self.tableView.reloadData()
            }
        }
    }
    // #selector方法
    @objc private func choiceLeaderAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // 懒加载
    lazy fileprivate var backgroud: UIView = {
        let back = UIView()
        back.backgroundColor = HHMAINDEEPCOLOR()
        return back
    }()
    lazy fileprivate var seach: UISearchBar = {
        let seach = UISearchBar.init()
        seach.layer.cornerRadius = 4
        seach.layer.masksToBounds = true
        seach.backgroundImage = UIImage(named:"main_dark")
        seach.placeholder = "请输入队长的名字"
        seach.delegate = self
        return seach
    }()
    lazy fileprivate var choiceLeaderCancel: UIButton = UIButton.init(action: #selector(HHChoiceLeaderController.choiceLeaderAction), target: self as AnyObject, title: "取消", imageName: "", fontColor: UIColor.white, fontSize: 16)
    lazy fileprivate var tableView:UITableView = {
        let rect = CGRect(x:0,y:0,width:SCREEN_WIDTH, height:SCREEN_HEIGHT - 64)
        let tableView = UITableView.init(frame:rect)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = HHGRAYCOLOR()
        tableView.register(HHChoiceLeaderCell.self, forCellReuseIdentifier: "HHChoiceLeaderCell")
        return tableView

    }()
}

// tableView dataDelegate
extension HHChoiceLeaderController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        var cell:HHChoiceLeaderCell?  = tableView.dequeueReusableCell(withIdentifier: "HHChoiceLeaderCell") as?  HHChoiceLeaderCell
        if cell == nil {
            cell = HHChoiceLeaderCell.init(style: .default, reuseIdentifier: "HHChoiceLeaderCell")
        }
        cell?.choiceLeaderModel = dataArray?[indexPath.row]
        if (dataArray?.count)!-1 == indexPath.row {
            cell?.choiceLeaderLine.isHidden = true
        }else{
            cell?.choiceLeaderLine.isHidden = false
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }


}

extension HHChoiceLeaderController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if (searchBar.text?.characters.count)! > 0 {
            updata(seachString: searchBar.text!)
        }
    }
}
