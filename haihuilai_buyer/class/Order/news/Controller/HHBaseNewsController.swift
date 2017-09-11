//
//  HHBaseNewsController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/8.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHBaseNewsController: HHBaseViewController, UIScrollViewDelegate {
    // 被选择的BTN
    var choiceBtn: UIButton?{
        didSet{
            choiceBtn?.isSelected = true
        }
    }
    // 存放按钮的数组
    var buttonArray = [UIButton]()
    // 存放小红点的数组
    var imageViewArray = [UIImageView]()
    // 列表KEY的数组
    var newsListKeyArray: [String]?{
        didSet{
            var i = 0
            for stype in newsListKeyArray! {
                let newsTab:HHNewsTableView = HHNewsTableView.init(type: stype, frame:CGRect(x: SCREEN_WIDTH * CGFloat(i), y: 0, width: SCREEN_WIDTH, height:SCREEN_HEIGHT - 50))
                scrollView.addSubview(newsTab)
                i += 1
            }
        }
    }

    // 标签名称的数组
    var buttonNameArray = ["订单","提醒","结算","车队"]{
        didSet{
            buttonArray.removeAll()
            scrollView.contentSize = CGSize(width: SCREEN_WIDTH * CGFloat(buttonNameArray.count),height:SCREEN_HEIGHT - 50)
            var i:Int = 0
            for name in buttonNameArray {
                let btn = UIButton.init(action: #selector(HHBaseNewsController.btnAction(btn:)), target: self, title: name, backgroudImageName: "white", fontColor: HHWORDGAYCOLOR(), fontSize: 14)
                btn.setTitleColor(HHMAINCOLOR(), for: .selected)
                btn.tag = i
                buttonArray.append(btn)
                i += 1
            }
        }
    }
    // 是否有小红点的数组
    var isHaveRedArray = [true,true,true,true]{
        didSet{
            imageViewArray.removeAll()
            for isread in isHaveRedArray {
                var imageName: String?
                if isread {
                    imageName = "reddot"
                } else {
                    imageName = "white"
                }
                let imageView = UIImageView.init(imageName: imageName!)
                imageViewArray.append(imageView)
            }

        }
    }
    // 记录scrollview的位置
    private var locaedNum: Int = 0 {
        didSet{
            choiceBtn = buttonArray[locaedNum]
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HHGRAYCOLOR()
        buttonNameArray = ["订单","提醒","结算","车队"]
        isHaveRedArray = [true,true,true,true]
        newsListKeyArray = ["booking","remind","account","motorcade"]
        // 设置baritem
        setbarItem()
        // 设置UI
        setUI()
        // 设置被选页面
        choiceBtn = buttonArray[0]
    }
    private func setbarItem(){
        navigationItem.title = "消息中心"
        let rightbarItem = UIBarButtonItem.init(title: "全部已读", style: .plain, target: self, action: #selector(HHBaseNewsController.reSet))
        navigationItem.rightBarButtonItem = rightbarItem
    }
    private func setUI(){
        var i = 0
        var n = 0
        
        for btn in buttonArray {
            view.addSubview(btn)
            btn.mas_makeConstraints({ (make) in
                make!.top.equalTo()(self.view)
                make!.left.equalTo()(self.view)?.setOffset(CGFloat(i)*SCREEN_WIDTH / CGFloat((self.buttonArray.count)))
                make!.size.mas_equalTo()(CGSize(width: SCREEN_WIDTH / CGFloat((self.buttonNameArray.count)),height: 40))
            })
            i += 1
        }
        for imageView in imageViewArray {
            view.addSubview(imageView)
            let width = SCREEN_WIDTH / CGFloat((self.buttonArray.count))
            imageView.mas_makeConstraints({ (make) in
                make!.top.equalTo()(self.view)?.setOffset(10)
                make!.left.equalTo()(self.view)?.setOffset((CGFloat(n)+0.5)*width + 15)
                make!.size.mas_equalTo()(CGSize(width: 5,height: 5))
            })
            n += 1
        }
        view.addSubview(lineLabel)
        view.addSubview(scrollView)
        lineLabel.mas_makeConstraints { (make) in
            make!.top.equalTo()(self.view)?.setOffset(38)
            make!.left.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width: SCREEN_WIDTH / CGFloat((self.buttonNameArray.count)),height: 2))
        }
        scrollView.mas_makeConstraints { (make) in
            make!.top.equalTo()(self.view)?.setOffset(50)
            make!.left.equalTo()(self.view)
            make!.size.mas_equalTo()(CGSize(width: SCREEN_WIDTH ,height:SCREEN_HEIGHT - 50))
        }
        
    
    }
    
    /// @objet 方法
    @objc private func reSet(){
        
    }
    @objc private func btnAction(btn: UIButton){
        choiceBtn?.isSelected = false
        locaedNum = btn.tag
        scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH * CGFloat(btn.tag),y: 0)
    }
    /// 懒加载
    private lazy var lineLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = HHMAINCOLOR()
        return label
    }()
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.yellow
        scrollView.delegate = self
        return scrollView
    }()
    
    
    /// scrollViewDidScrollDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let num:CGFloat = scrollView.contentOffset.x/SCREEN_WIDTH
        let i:Int = Int(scrollView.contentOffset.x/SCREEN_WIDTH+0.5)
        choiceBtn?.isSelected = false
        lineLabel.mas_updateConstraints {(make) in
            make!.left.equalTo()(self.view)?.setOffset(num*SCREEN_WIDTH/CGFloat(self.buttonArray.count))
        }
        locaedNum = i
    }

}

