//
//  UIButton+Extension.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/13.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

typealias extensionButtonBlock = ()->()
import UIKit

extension UIButton {
    override open var isHighlighted: Bool {
        get {
            return false
        }
        set{
            
        }
    }
    // 构成便利函数
    convenience init(title: String?, imageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if imageName != nil {
            setImage(UIImage(named: imageName!), for: .normal)
        }
        if fontColor != nil {
            setTitleColor(fontColor, for: .normal)
        }
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
    }
    convenience init(title: String?, backgroudImageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if backgroudImageName != nil {
            setBackgroundImage(UIImage(named:backgroudImageName!), for: .normal)
        }
        if fontColor != nil {
            setTitleColor(fontColor, for: .normal)
        }
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
    }

    convenience init(title: String?, backgroudColor: UIColor?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if backgroudColor != nil {
            self.backgroundColor = backgroundColor
        }
        if fontColor != nil {
            setTitleColor(fontColor, for: .normal)
        }
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
    }
    
    convenience init(action: Selector?,target: AnyObject, title: String?, imageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if imageName != nil {
            setImage(UIImage(named: imageName!), for: .normal)
        }
        if fontColor != nil {
            setTitleColor(fontColor, for: .normal)
        }
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
        if action != nil {
            addTarget(target, action: action!, for: .touchUpInside)
        }
    }
    convenience init(action: Selector?,target: AnyObject, title: String?, backgroudImageName: String?, fontColor: UIColor?, fontSize: CGFloat?) {
        self.init()
        setTitle(title, for: .normal)
        if backgroudImageName != nil {
            setBackgroundImage(UIImage(named: backgroudImageName!), for: .normal)
        }
        if fontColor != nil {
            setTitleColor(fontColor, for: .normal)
        }
        if fontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
        if action != nil {
            addTarget(target, action: action!, for: .touchUpInside)
        }
    }
    
    
    
    
    /// runtime 给button添加属性
    struct ButtonRuntimeKey {
        // 给button的
        static let motorCadeDetailModel = UnsafeRawPointer.init(bitPattern: "motorCadeDetailModel".hashValue)
        static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
    }
    
    var motorCadeModel: HHMotorCadeDetailModel? {
        set {
            objc_setAssociatedObject(self, ButtonRuntimeKey.motorCadeDetailModel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self,ButtonRuntimeKey.motorCadeDetailModel) as? HHMotorCadeDetailModel
        }
    }
    
    
}

