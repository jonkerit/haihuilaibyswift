//
//  HHTimer.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/21.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHTimer: NSObject {
    var codeTimer :DispatchSourceTimer?
    
    /// 有总时间的计时器
    ///
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - target: 目标控制器
    ///   - selector: 执行方法
    ///   - totleTime: 计时器的总时间
    func scheduledTimerWithTimeInterval(timeInterval: TimeInterval,target:AnyObject, selector:Selector,totleTime:Int){

        // 定义需要计时的时间
        var timeCount = totleTime
        // 在global线程里创建一个时间源
        codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer?.scheduleRepeating(deadline: .now(), interval: .seconds(1))
        // 设定时间源的触发事件
        codeTimer?.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                target.perform!(selector, with: nil, afterDelay: 0)
            }
            // 每秒计时一次
            timeCount = timeCount - 1
            // 时间到了取消时间源
            if timeCount <= 0 {
                self.codeTimer?.cancel()
                self.codeTimer = nil
            }
        })
        // 启动时间源
        codeTimer?.resume()
    }
    
    /// 重复计时器
    ///
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - target: 目标控制器
    ///   - selector: 执行方法
    ///   - isRepeats: 是否重复
    func scheduledTimerWithTimeInterval(timeInterval: TimeInterval,target:AnyObject, selector:Selector,isRepeats: Bool) -> HHTimer {
        let timer = HHTimer()
        // 在global线程里创建一个时间源
        codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer?.scheduleRepeating(deadline: .now(), interval: .seconds(1))
        // 设定时间源的触发事件
        weak var weakSelf = self
        codeTimer?.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                target.perform!(selector, with: nil, afterDelay: 0)
            }
            // 执行一次
            if !isRepeats {
                weakSelf?.codeTimer?.cancel()
            }

        })
        // 启动时间源
        codeTimer?.resume()
        return timer
    }
    func stop() {
        codeTimer?.cancel()
        codeTimer = nil
    }
    deinit {
        stop()
    }
}
