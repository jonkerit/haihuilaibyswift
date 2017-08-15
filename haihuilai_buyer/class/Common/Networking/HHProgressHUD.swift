//
//  HHProgressHUD.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/14.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit
import MBProgressHUD
class HHProgressHUD: NSObject {
    static let shareTool = HHProgressHUD()
    
    
    /// 只带图的默认MBProgressHUD
    ///
    /// - Parameters:
    ///   - boardView: 父view
    ///   - animated: 是否有动画
    func showHUDAddedTo(boardView: UIView?, animated:Bool){
        var keyView: UIView?
        if boardView == nil {
            keyView = HHKeyWindow
        } else {
            keyView = boardView
        }
        MBProgressHUD.showAdded(to: keyView!, animated: animated)
        DispatchQueue.global().async{
            sleep(3)
        }
    }
    
    
    /// 只带标题的默认MBProgressHUD
    ///
    /// - Parameters:
    ///   - title: 提示语
    ///   - boardView: 父view
    ///   - animated: 是否有动画
    func showHUDAddedTo(title: String?, isImage: Bool, boardView: UIView?, animated:Bool){
        var keyView: UIView?
        if boardView == nil {
            keyView = HHKeyWindow
        } else {
            keyView = boardView
        }
        let hud = MBProgressHUD.showAdded(to: keyView!, animated: animated)
        if is_empty_string(title) {
            hud.mode = .indeterminate
        } else {
            
            if !isImage {
                hud.mode = .text
            }
            hud.label.text = title
            hud.label.textAlignment = .center
        }
        DispatchQueue.global().async{
            sleep(3)
        }
    }
    
    /// 隐藏hideHUDForView
    ///
    /// - Parameters:
    ///   - boardView: 父view
    ///   - animated: 是否有动画
    func hideHUDForView(boardView: UIView?, animated:Bool){
        var keyView: UIView?
        if boardView == nil {
            keyView = HHKeyWindow
        } else {
            keyView = boardView
        }
        MBProgressHUD.hide(for: keyView!, animated: animated)
    }
}
