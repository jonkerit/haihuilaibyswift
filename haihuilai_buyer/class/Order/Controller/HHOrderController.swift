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
        dealBlock()
        setTableView()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private func dealBlock(){
        headView.orderHeadViewBlocks = {[weak self](_ btnTag: Int?) -> Void in
            if btnTag == 3 {
                return
            }
            if btnTag == 4 {
                return
            }
            self?.selectedBtn?.setTitleColor(UIColor.white, for: .normal)
            if btnTag == 0 {
                self?.headView.servingBtn.setTitleColor(HHMAINDEEPCOLOR(), for: .normal)
            }
            if btnTag == 1 {
                self?.headView.unBeginBtn.setTitleColor(HHMAINDEEPCOLOR(), for: .normal)
            }
            if btnTag == 2 {
                self?.headView.finishedBtn.setTitleColor(HHMAINDEEPCOLOR(), for: .normal)
            }
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
//        var i: Int = 0
//        for type in self.typeArray{
//            let tableView = HHOrderTableView.init(type: type, frame: CGRect(x: SCREEN_WIDTH * CGFloat(i), y: 0, width: SCREEN_WIDTH, height:self.view.frame.size.height-100))
//            tableViewArray?.append(tableView)
//            i += 1
//            scrollViewList.addSubview(tableView)
//        }
        let tableView = HHOrderTableView.init(type: typeArray[locaedNum], frame: CGRect(x: SCREEN_WIDTH * CGFloat(locaedNum), y: 0, width: SCREEN_WIDTH, height:self.view.frame.size.height-100))
        scrollViewList.addSubview(tableView)
        tableViewArray?[locaedNum] = tableView
        
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
        switch i {
        case 0:
            headView.servingBtn.setTitleColor(HHMAINDEEPCOLOR(), for: .normal)
            break
        case 1:
            headView.unBeginBtn.setTitleColor(HHMAINDEEPCOLOR(), for: .normal)
            break
        case 2:
            headView.finishedBtn.setTitleColor(HHMAINDEEPCOLOR(), for: .normal)
            break
        default:
            break
        }
        headView.movingBtn.mas_updateConstraints {(make) in
            make!.left.equalTo()(self.headView)?.setOffset((SCREEN_WIDTH/3-70)/2 + num)
        }
        locaedNum = i
    }


}
