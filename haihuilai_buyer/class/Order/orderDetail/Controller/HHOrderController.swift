//
//  HHOrderController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/22.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHOrderController: HHBaseScrollViewController {
    
    // 被选的button
    var selectedBtn: UIButton?{
        didSet{
            selectedBtn?.setTitleColor(HHMAINDEEPCOLOR(), for: .normal)
        }
    }
    // 记录scrollview的位置
    var locaedNum: Int = 0 {
        didSet{
            switch locaedNum {
            case 0:
                selectedBtn = headView.servingBtn
                break
            case 1:
                selectedBtn = headView.unBeginBtn
                break
            case 2:
                selectedBtn = headView.finishedBtn
                break
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 默认选择的按钮
        locaedNum = 0
        setUI()
        //  处理block
        dealBlock()
        //  添加tableView
        setTableView()
        // 更新消息按钮的状态
        updataNoticeStatus()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        refreshNewsButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private func updataNoticeStatus(){
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
    // 设置消息按钮的状态
    private func refreshNewsButton(){
        headView.newsBtn.setImage(UIImage(named: HHAccountViewModel.shareAcount.noticeImageName), for: .normal)
    }
    //  处理block
    private func dealBlock(){
        headView.orderHeadViewBlocks = {[weak self](_ btnTag: Int?) -> Void in
            // 消息按钮
            if btnTag == 3 {
                print("消息按钮")
                self?.navigationController?.pushViewController(HHBaseNewsController(), animated: true)
                return
            }
            // 搜索按钮
            if btnTag == 4 {
                print("搜索按钮")
                self?.present(HHSearchController(), animated: true, completion: nil)
                return
            }
            // 标签按钮的选择逻辑
            self?.selectedBtn?.setTitleColor(UIColor.white, for: .normal)
            self?.scrollViewList.contentOffset = CGPoint(x:SCREEN_WIDTH * CGFloat(btnTag!), y:0)
            self?.locaedNum = btnTag!
        }
    }
    
    private func setUI(){
        view.addSubview(headView)
        view.addSubview(scrollViewList)
        
        headView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT-100, 0))
        }
        scrollViewList.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)?.setInsets(UIEdgeInsetsMake(100, 0, 0, 0))
        }
    }
    func setTableView() {
        var i: Int = 0
        for type in self.typeArray{
            let tableView = HHOrderTableView.init(type: type, frame: CGRect(x: SCREEN_WIDTH * CGFloat(i), y: 0, width: SCREEN_WIDTH, height:self.view.frame.size.height-100))
            tableView.orderTableViewDelegate = self
            tableViewArray?.append(tableView)
            i += 1
            scrollViewList.addSubview(tableView)
        }
//        let tableView = HHOrderTableView.init(type: typeArray[locaedNum], frame: CGRect(x: SCREEN_WIDTH * CGFloat(locaedNum), y: 0, width: SCREEN_WIDTH, height:self.view.frame.size.height-100))
//        scrollViewList.addSubview(tableView)
//        tableViewArray?[locaedNum] = tableView
        
    }

    /// @objc #selector方法
    
    
    /// 懒加载
    private lazy var tableViewArray: [AnyObject]? = {
        let tableView = Array.init(repeating: UIView(), count: self.typeArray.count)
        return tableView
    }()
    
    fileprivate lazy var headView: HHOrderHeadView = {
        let view = HHOrderHeadView.init(frame:CGRect.zero)
        return view
    }()
    fileprivate lazy var scrollViewList: UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * CGFloat(self.typeArray.count), height:(self.view.frame.size.height-100))

        return scrollView
    }()
    fileprivate lazy var typeArray = { () ->Array<String> in
        let array = Array.init(arrayLiteral: "supplier_unstart","supplier_travelling","supplier_history")
        return array
    }()
    
}

extension HHOrderController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let num:CGFloat = (scrollView.contentOffset.x/SCREEN_WIDTH) * (SCREEN_WIDTH/3)
        let i:Int = Int(scrollView.contentOffset.x/SCREEN_WIDTH+0.5)
        selectedBtn?.setTitleColor(UIColor.white, for: .normal)
        headView.movingBtn.mas_updateConstraints {(make) in
            make!.left.equalTo()(self.headView)?.setOffset((SCREEN_WIDTH/3-70)/2 + num)
        }
        locaedNum = i
    }
}
extension HHOrderController:HHOrderTableViewDelegate{
    func openOrderTableView(bookingId: String?) {
        print((bookingId)!)
    }
    

}
