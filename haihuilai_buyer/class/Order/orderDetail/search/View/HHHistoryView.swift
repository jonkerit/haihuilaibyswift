//
//  HHHistoryView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/11.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
@objc protocol HHHistoryViewDelegate: class{
    @objc optional func historyViewDoUpdateSearch(historyModel: HHHistoryModel?)
}
import UIKit

class HHHistoryView: UIView {

    weak var historyViewDelegate:HHHistoryViewDelegate?
    // 数据数组
    private var dataArray: [HHHistoryModel]?{
        didSet{
            if backView.subviews.count != 0 {
                for objct:UIView in backView.subviews {
                    objct.removeFromSuperview()
                }
            }
            if dataArray == nil || dataArray?.count == 0{
                /// mark： 添加无记录页面
                let label = UILabel.init(title: "暂无搜索记录", fontColor: HHWORDGAYCOLOR(), fontSize: 14, alignment: .left)
                label.frame = CGRect(x: 15 ,y:10 ,width: 100,height: 16)
                self.backView.addSubview(label)
                return
            }
            var i = 0
            for objc in dataArray! {
                let btn = UIButton.init(action: #selector(HHHistoryView.btnaction(btn:)), target: self, title: objc.content, backgroudImageName: "gray", fontColor: HHWORDGAYCOLOR(), fontSize: 12)
                btn.setTitleColor(UIColor.white, for: .selected)
                btn.setBackgroundImage(UIImage(named:"main_dark"), for: .selected)
                btn.tag = i
                var width = HHCommon.shareCommon.obtainStringLength(objc.content, 12, CGSize(width:SCREEN_WIDTH/2 ,height:30)).width
                if width<50 {
                    width = width + 40
                }else{
                    width = width + 20
                }
                btn.layer.cornerRadius = 2
                btn.layer.masksToBounds = true
                btn.frame = CGRect(x: Int(15+CGFloat(i%2)*(SCREEN_WIDTH/2)) ,y:15+Int(i/2)*40 ,width: Int(width) ,height:30)
                backView.addSubview(btn)
                i += 1
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        setUI()
        getHistoryResultList()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        addSubview(titleBtn)
        addSubview(imageBtn)
        addSubview(line)
        addSubview(backView)
        
        titleBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make!.top.equalTo()(self)?.setOffset(15)
        }
        imageBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)?.setOffset(-15)
            make!.centerY.equalTo()(self.titleBtn)
        }
        line.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.setOffset(15)
            make!.top.equalTo()(self.titleBtn.mas_bottom)?.setOffset(15)
            make!.size.mas_equalTo()(CGSize(width:SCREEN_WIDTH-30,height:2))
        }
        backView.mas_makeConstraints { (make) in
            make!.top.equalTo()(self.line.mas_bottom)
            make!.left.equalTo()(self)
            make!.right.equalTo()(self)
            make!.bottom.equalTo()(self)
        }

    }
    private func getHistoryResultList(){
        HHProgressHUD().showHUDAddedTo(title: nil, isImage: true, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getHistoryResultList(parameter: nil) { (response, errorSting) in
            HHProgressHUD().hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
                self.dataArray = response as! [HHHistoryModel]?
            }else{
                HHProgressHUD().showHUDAddedTo(title: errorSting, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
    
    // objc方法
    @objc private func DeleteHistory() {
        HHPrint("删除历史数据")
        self.endEditing(true)
        let alertController: UIAlertController = UIAlertController.init(title: "提示", message: "是否确定清空历史纪录，清空后将无法恢复", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (alertAction) in
            // 网络请求
            HHProgressHUD().showHUDAddedTo(title: "正在删除中", isImage: true, isDisappear: false, boardView: HHKeyWindow, animated: true)
            HHNetworkClass().delegateHistoryOfSearch(parameter: nil, networkClassData: { (response, errorString) in
                HHProgressHUD().hideHUDForView(boardView: HHKeyWindow, animated: true)
                if response != nil{
                    self.dataArray = nil
                }else{
                    HHProgressHUD().showHUDAddedTo(title: errorString, isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
                }
            })
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    @objc private func btnaction(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if self.historyViewDelegate != nil {
            self.historyViewDelegate?.historyViewDoUpdateSearch!(historyModel: dataArray?[btn.tag])
        }
    }
    // 懒加载
    private lazy var titleBtn: UIButton = {
        let btn = UIButton.init(title: " 历史搜索", imageName: "history", fontColor: HHWORDGAYCOLOR(), fontSize: 12)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    private lazy var imageBtn: UIButton = {
        let btn = UIButton.init(action: #selector(HHHistoryView.DeleteHistory), target: self, title: nil, imageName: "clean_history", fontColor: nil, fontSize: nil)
        return btn
    }()
    private lazy var line: UILabel = {
        let line = UILabel()
        line.backgroundColor = HHGRAYCOLOR()
        return line
    }()
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
}
