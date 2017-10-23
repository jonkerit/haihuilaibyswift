//
//  HHIndividualController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
import MJRefresh

class HHIndividualController: HHBaseViewController {
    // 背景的view
    fileprivate var backViews: UIView?
    // 信息的字典
    fileprivate var infoDict: [String: AnyObject]?
    // 提示字符串的高度
    fileprivate var stringHeight: CGFloat?
    // 提示字符串的内容
    fileprivate var warmString: String?{
        didSet{
            warmLabel.text = warmString
            let height = HHCommon.shareCommon.obtainStringLength(warmString, 14, CGSize(width: SCREEN_WIDTH - 30,height:CGFloat(Int.max))).height
            if height == 0 {
                stringHeight = 0
            } else {
                stringHeight = HHCommon.shareCommon.obtainStringLength(warmString, 14, CGSize(width: SCREEN_WIDTH - 30,height:CGFloat(Int.max))).height + 26
            }
        }
        
    }
    // 审核状态记录
    fileprivate var status: String = "inactive"{
        didSet{
            switch status {
            case "pending_review":
                warmString = "账号正在排队审核中，因近期注册人数较多，审核时间较慢，如填写了下方的资料信息，可提高审核速度。"
                break
            case "reviewed":
                 warmString = nil
                break
            case "refused":
                 warmString = "审核不通过"
                break
            case "inactive":
                 warmString = "未激活"
                break
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = HHGRAYCOLOR()
        warmString = "账号正在排队审核中，因近期注册人数较多，审核时间较慢，如填写了下方的资料信息，可提高审核速度。"
        setUI()
        setRightBar()
        updata()
    }
    private func setRightBar(){
        navigationItem.title = "个人中心"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "GRZX-cl")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(HHIndividualController.setting))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshNewsButton()
    }
   
    private func setUI(){
        let backView = UIView()
        backViews = backView
        let teamView = UIView()
        teamView.backgroundColor = UIColor.white
        
        view.addSubview(scrollowView)
        scrollowView.addSubview(backView)
        scrollowView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self.view)
        }
        backView.mas_makeConstraints { (make) in
            make!.edges.equalTo()(self.scrollowView)
            make!.width.equalTo()(SCREEN_WIDTH)
        }
        
        backView.addSubview(warmLabel)
        backView.addSubview(NameView)
        backView.addSubview(teamView)
        backView.addSubview(infoView)
        infoView.mas_makeConstraints { (make) in
            make?.top.equalTo()(teamView.mas_bottom)?.setOffset(10)
            make!.left.equalTo()(backView)?.setOffset(10)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH - 20,height:280))
        }
        warmLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(backView)?.setOffset(15)
            make?.right.equalTo()(backView)?.setOffset(-15)
            make?.top.equalTo()(backView)?.setOffset(13)
        }
        NameView.mas_makeConstraints { (make) in
            make?.top.equalTo()(backView)?.setOffset(self.stringHeight!)
            make!.left.equalTo()(backView)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
        teamView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.NameView.mas_bottom)?.setOffset(10)
            make!.left.equalTo()(backView)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH,height:60))
        }
        NameView.addSubview(nameLabel)
        NameView.addSubview(phoneNumberLabel)
        let imageView1 = UIImageView.init(image: UIImage(named: "DL-jt"))
        NameView.addSubview(imageView1)
        nameLabel.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.NameView)?.setOffset(15)
            make!.centerY.equalTo()(self.NameView)
        }
        imageView1.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.NameView)?.setOffset(-15)
            make!.centerY.equalTo()(self.NameView)
        }
        phoneNumberLabel.mas_makeConstraints { (make) in
            make!.right.equalTo()(imageView1.mas_left)?.setOffset(-10)
            make!.centerY.equalTo()(self.NameView)
        }
        
        let label = UILabel.init(title: "车队", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        teamView.addSubview(label)
        teamView.addSubview(teamNameLabel)
        teamView.addSubview(teamNunberLabel)
        teamNameLabel.mas_makeConstraints { (make) in
            make!.right.equalTo()(teamView)?.setOffset(-25)
            make!.centerY.equalTo()(teamView)
        }
        label.mas_makeConstraints { (make) in
            make!.left.equalTo()(teamView)?.setOffset(15)
            make!.centerY.equalTo()(teamView)?.setOffset(-10)
        }
        teamNunberLabel.mas_makeConstraints { (make) in
            make!.left.equalTo()(teamView)?.setOffset(15)
            make!.centerY.equalTo()(teamView)?.setOffset(10)
        }
        if HHAccountViewModel.shareAcount.isCompanySupplier {
            backView.addSubview(incomeView)
            incomeView.mas_makeConstraints { (make) in
                make?.top.equalTo()(self.infoView.mas_bottom)?.setOffset(10)
                make!.left.equalTo()(backView)?.setOffset(10)
                make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH - 20,height:60))
                make!.bottom.equalTo()(backView)?.setOffset(-10)
            }
        }else{
            infoView.mas_updateConstraints({ (make) in
                make!.bottom.equalTo()(backView)?.setOffset(-10)
            })
        }
    }
    /// @objc方法
    @objc private func openNewCenter(){
        print("进消息中心")
        self.navigationController?.pushViewController(HHBaseNewsController(), animated: true)

    }
    
    @objc private func setting(){
        print("设置")
        navigationController?.pushViewController(HHSettingController(), animated: true)
    }
    @objc private func goToIncome(){
        self.navigationController?.pushViewController(HHIncomeController(), animated: true)
    }
    ///  数据处理
    @objc private func updata(){
        HHProgressHUD.shareTool.showHUDAddedTo(title: nil, isImage: true, boardView: HHKeyWindow, animated: true)
        let group = DispatchGroup()
        group.enter()
        HHNetworkClass().getReviewStatus(parameter: nil, networkClassData: { (response, errorString) in
            self.dealReviewStatusResult(result: response)
            group.leave()
        })
        group.enter()

        HHNetworkClass().getIndividualInfo(parameter: nil, networkClassData: { (response, errorString) in
            print("getIndividualInfo")
            self.dealIndividualInfoResult(result: response)
            group.leave()
        })
        group.enter()

        HHNetworkClass().getInfoViewList(parameter: nil, networkClassData: { (response, errorString) in
            print("getInfoViewList")
            self.dealInfoViewListResult(result: response)
            group.leave()

        })
        
        group.notify(queue: DispatchQueue.main) { 
            HHProgressHUD.shareTool.hideHUDForView(boardView: HHKeyWindow, animated: true)
            self.scrollowView.mj_header.endRefreshing()
            print("出来了哦")

        }
    }
    
    private func dealReviewStatusResult(result: [String: AnyObject]?){
        if SUCCESSFUL(result) {
            status = result?["data"]?["review_status"] as! String
            NameView.mas_updateConstraints({ (make) in
                make?.top.equalTo()(self.backViews)?.setOffset(self.stringHeight!)
            })
            // 存储审核状态
            UserDefaults.standard.set(status, forKey: CHECK_STATUS_KEY)
        } else {
            // 取出审核状态
            status = (UserDefaults.standard.object(forKey: CHECK_STATUS_KEY) as! String? ?? "")!
        }
        
        // 获取信息中心是否有未读消息
        if status != "reviewed" {
            HHNetworkClass().getNotificationsAll_read(parameter: nil, networkClassData: { (response, errorString) in
                print("写消息按钮")
                if SUCCESSFUL(response){
                    var imageName: String?
                    if (response?["data"]?.boolValue)!{
                        imageName = "top_notice_new"
                    }else{
                        imageName = "top_notice"
                    }
                    HHAccountViewModel.shareAcount.noticeImageName = imageName!
                    self.refreshNewsButton()
                }
            })
        }
    }
    private func dealIndividualInfoResult(result: [String: AnyObject]?){
        if SUCCESSFUL(result) {
            infoDict = result?["data"] as! [String : AnyObject]?
            UserDefaults.standard.set(result?["data"], forKey: INDIVIDUAL_KEY)
        }else{
            infoDict = UserDefaults.standard.object(forKey: INDIVIDUAL_KEY) as! [String : AnyObject]?
        }
        setIndividualVaule(infoDict: infoDict)
    }
    private func dealInfoViewListResult(result: [String: AnyObject]?){
        if SUCCESSFUL(result) {
            infoView.dataDict = result?["data"] as! [String : AnyObject]?
            infoView.tableView.reloadData()
        }
    }
    
    /// 给标签赋值
    private func setIndividualVaule(infoDict: [String: AnyObject]?){
        nameLabel.text = infoDict?["name"] as! String?
        phoneNumberLabel.text = infoDict?["mobile"] as! String?
        teamNunberLabel.text = "车队ID " + (infoDict?["team_id"] as! String)
        teamNameLabel.text = infoDict?["team_name"] as! String?
    }
    
    
    /// 给标签赋值
    private func refreshNewsButton(){
        let barItem = UIBarButtonItem.init(image: UIImage(named: HHAccountViewModel.shareAcount.noticeImageName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(HHIndividualController.openNewCenter))
        navigationItem.leftBarButtonItem = barItem
    }

    
    
    private lazy var warmLabel: UILabel = {
        let label = UILabel.init(title: "话", fontColor: RGBCOLOR(237, 78, 78), fontSize: 14, alignment: .left)
        label.text = self.warmString
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.init(title: "大哥", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        return label
    }()
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel.init(title: "18812345678", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return label
    }()
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel.init(title: "你好", fontColor: HHWORDGAYCOLOR(), fontSize: 16, alignment: .right)
        return label
    }()
    private lazy var teamNunberLabel: UILabel = {
        let label = UILabel.init(title: "车队ID 2333", fontColor: HHWORDGAYCOLOR(), fontSize: 12, alignment: .left)
        return label
    }()
    private lazy var infoView: HHInfoView = {
        let infoView = HHInfoView.init(frame: CGRect.zero)
        infoView.layer.cornerRadius = 4
        infoView.layer.masksToBounds = true
        infoView.individualDelegate = self
        return infoView
    }()
    private lazy var incomeView: UIView = {
        let view = UIView()
        let incomeBtn = UIButton()
        incomeBtn.addTarget(self, action: #selector(goToIncome), for: .touchUpInside)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        let label = UILabel.init(title: "我的收入", fontColor: HHWORDCOLOR(), fontSize: 16, alignment: .left)
        view.addSubview(label)
        view.addSubview(self.imageViews)
        view.addSubview(incomeBtn)
        label.mas_makeConstraints({ (make) in
            make!.left.equalTo()(view)?.setOffset(15)
            make!.centerY.equalTo()(view)
        })
        self.imageViews.mas_makeConstraints({ (make) in
            make!.right.equalTo()(view)?.setOffset(-15)
            make!.centerY.equalTo()(view)
        })
        incomeBtn.mas_makeConstraints({ (make) in
            make?.edges.equalTo()(view)
        })
        return view
    }()
    private lazy var imageViews: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "DL-jt"))
        return imageView
    }()
    private lazy var NameView:UIView = {
        let NameView = UIView()
        NameView.backgroundColor = UIColor.white
        return NameView
    }()
    private lazy var scrollowView:UIScrollView = {
        let scrollowView = UIScrollView()
        scrollowView.showsVerticalScrollIndicator = false
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(HHIndividualController.updata))
        scrollowView.mj_header = header
        return scrollowView
    }()
   
}

extension HHIndividualController: HHIndividualDelegate{
    func openInfoView(openId: IndexPath?) {
        print(openId?.row)
    }

}
