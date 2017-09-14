//
//  HHIndexView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/14.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

@objc protocol HHIndexViewDelelgate:class{
    
    /// 触摸HHIndexView的代理
    ///
    /// - Parameters:
    ///   - tableViewIndex: HHIndexView
    ///   - index: 选择的区域
    ///   - title: 选择的区域的标题
    @objc optional func tableViewIndex(_ tableViewIndex: HHIndexView, didSelectSection index:NSInteger, withTitle title:NSString)
}

import UIKit

class HHIndexView: UIView {
    
    weak var indexViewDelelgate: HHIndexViewDelelgate?
    
    init(frame:CGRect, dataArray:[AnyObject]) {
        super.init(frame: frame)
        arrayM = dataArray
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        var i = 0
        for objet in arrayM {
            let label = UILabel.init(title: objet as! String, fontColor: HHMAINCOLOR(), fontSize: 14, alignment: .center)
            label.tag = i
            label.frame = CGRect(x: 0,y: CGFloat(16*i),width: 20,height: 16)
            self.addSubview(label)
            i += 1
        }
        self.addSubview(labelView)
        labelView.mas_makeConstraints { (make) in
            make!.centerY.equalTo()(self)
            make!.centerX.equalTo()(self)?.setOffset(-SCREEN_WIDTH/2)
            make!.size.mas_equalTo()(CGSize(width:50, height: 50))
        }
    }

    fileprivate func sendEventToDelegate(touchEvent:UIEvent){
        let touch:UITouch = (touchEvent.allTouches?.first)!
        let touchPoint = touch.location(in: self)
        let tag = Int(touchPoint.y / 16)
        
        if tag<0 || tag>arrayM.count-1 {
            return
        }
        labelView.text = arrayM[tag] as? String
        if self.indexViewDelelgate != nil {
            self.indexViewDelelgate?.tableViewIndex!(self, didSelectSection: tag, withTitle: labelView.text! as NSString)
        }
        
    }
    
    private lazy var arrayM = [AnyObject]()
    fileprivate lazy var labelView: UILabel = {
        let label = UILabel.init(title: "A", fontColor: UIColor.white, fontSize: 40, alignment: .center)
        label.backgroundColor = HHMAINCOLOR()
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }()
}

// touch的代理方法
extension HHIndexView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.labelView.isHidden = false
        sendEventToDelegate(touchEvent: event!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        self.labelView.isHidden = false
        sendEventToDelegate(touchEvent: event!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event!)
        UIView.animate(withDuration: 0.5, animations: { 
            self.labelView.alpha = 0
        }) { (_) in
            self.labelView.isHidden = true
            self.labelView.alpha = 1.0

        }
    }
    
    
}
