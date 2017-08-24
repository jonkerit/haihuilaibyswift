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
    
    
    /// 可控制标题和图片的默认MBProgressHUD
    ///
    /// - Parameters:
    ///   - title: 提示语
    ///   - boardView: 父view
    ///   - animated: 是否有动画
    ///   - isImage: 是否有图片
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
                if is_empty_string(title) {
                    assert(is_empty_string(title), "title和Image不能用时为空")
                    return;
                }
                hud.mode = .text
            }
            hud.label.text = title
            hud.label.textAlignment = .center
        }
        DispatchQueue.global().async{
            sleep(3)
        }
    }
    
    /// 提示可以消失的可控制标题和图片的默认MBProgressHUD
    /// 可控制标题和图片的默认MBProgressHUD
    ///
    /// - Parameters:
    ///   - title: 提示语
    ///   - boardView: 父view
    ///   - animated: 是否有动画
    ///   - isImage: 是否有图片
    ///   - isHidden: 提示是否消失
    func showHUDAddedTo(title: String?, isImage: Bool, isDisappear: Bool, boardView: UIView?, animated:Bool){
        showHUDAddedTo(title: title, isImage: isImage, boardView: boardView, animated: animated)
        if isDisappear {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(1)) {
                self.hideHUDForView(boardView: boardView, animated: animated)
            }
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
