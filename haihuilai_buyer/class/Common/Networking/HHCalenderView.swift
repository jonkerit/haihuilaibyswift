//
//  HHCalenderView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/10/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

// 定义日期控件的间距
let datePad = 5
class HHCalenderView: UIView {
    
    var inputDate: Date?{
        didSet{
            if inputDate != nil {
                if self.subviews.count > 0 {
                    for objet in self.subviews {
                        objet.removeFromSuperview()
                    }
                }
                setUI()
                let ndf = DateFormatter()
                ndf.dateFormat = "yyyy年MM月"
                headlabel.text = ndf.string(from: self.inputDate!)

            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 添加手势
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(setupFrontMonth))
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(setupNextMonth))
        leftSwipeGestureRecognizer.direction = .left
        rightSwipeGestureRecognizer.direction = .right
        addGestureRecognizer(leftSwipeGestureRecognizer)
        addGestureRecognizer(rightSwipeGestureRecognizer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        setHeadUI()
        setBodyUI()
    }
    
    private func setHeadUI(){
        addSubview(headView)
        headView.backgroundColor = UIColor.green
        headlabel.backgroundColor = UIColor.red
        headView.addSubview(self.leftBtn)
        headView.addSubview(self.rightBtn)
        headView.addSubview(self.headlabel)
        // 布局暂时不用原生态的
        headView.mas_makeConstraints { (make) in
            make!.right.equalTo()(self)
            make!.top.equalTo()(self)
            make!.size.mas_equalTo()(CGSize(width:self.bounds.size.width,height:96))
        }
        self.headlabel.mas_makeConstraints { (make) in
            make!.centerX.equalTo()(self.headView)
            make!.top.equalTo()(self.headView.mas_top)?.setOffset(20)
            make!.width.equalTo()(110)
        }
        self.leftBtn.mas_makeConstraints { (make) in
            make!.right.equalTo()(self.headlabel.mas_left)?.setOffset(-40)
            make!.centerY.equalTo()(self.headlabel)
            make!.width.mas_equalTo()(30)
        }
        self.rightBtn.mas_makeConstraints { (make) in
            make!.left.equalTo()(self.headlabel.mas_right)?.setOffset(40)
            make!.centerY.equalTo()(self.headlabel)
            make!.width.mas_equalTo()(30)
        }
        
        // 布局星期
        var i = 0
        for objt in weekArray {
            i += 1
            let pod = CGFloat(datePad * i) + btnSize * CGFloat(i - 1)
            let label = UILabel()
            label.text = objt
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.init(colorLiteralRed: (79/255.0), green: (79/255.0), blue: (79/255.0), alpha: (1))
            label.textAlignment = .center
            headView.addSubview(label)
            label.mas_makeConstraints({ (make) in
                make?.top.equalTo()(self.leftBtn.mas_bottom)?.setOffset(32)
                make!.width.equalTo()(self.btnSize)
                make!.left.equalTo()(self.headView.mas_left)?.setOffset(pod)
            })

        }

    }

    // 创建一个日历的控件数组（最多6行共计42个button）
    private func setBodyUI(){
        setDays()
        addSubview(bodyView)
        bodyView.mas_makeConstraints { (make) in
            make!.right.equalTo()(self)
            make!.top.equalTo()(self.headView.mas_bottom)
            make!.left.equalTo()(self)
            make!.bottom.equalTo()(self)
        }
    }
    
    // days的控件的排布
    private func setDays(){
        
        // 上月、本月、下月的天数
        let daysInFrontMonth = totaldaysInMonth(date: nextOrFrontMonth(inputdate: inputDate!, spaceTime: -1))
        let daysInThisMonth = totaldaysInMonth(date: inputDate!)
        let firstWeekdayThisMonth = getWeekDay(dateTime: inputDate!)
        
        // 计算本月页面其他月日期的位置
        for i in stride(from: 0, to: daysArray.count, by: 1){
            
            // button的位置布局
            bodyView.addSubview(daysArray[i])
            let b: Int = i/7
            let a: Int = i%7
            let x = CGFloat(datePad * (a+1)) + btnSize * CGFloat(a)
            let y = CGFloat((b + 1) * datePad) + CGFloat(b) * btnSize
            
            daysArray[i].mas_makeConstraints({ (make) in
                make!.left.equalTo()(self.bodyView.mas_left)?.setOffset(x)
                make?.top.equalTo()(self.bodyView.mas_top)?.setOffset(y)
                make!.size.equalTo()(CGSize(width:self.btnSize,height:self.btnSize))
            })
            
            // 给button设置日期title
            if i < firstWeekdayThisMonth - 1 {
                // 上一个月的日期
                let frontday = daysInFrontMonth - firstWeekdayThisMonth + i + 2
                daysArray[i].setTitle(String(frontday), for: .normal)
                daysArray[i].setTitleColor(UIColor.init(colorLiteralRed: (155/255.0), green: (155/255.0), blue: (155/255.0), alpha: (1)), for: .normal)
                daysArray[i].isUserInteractionEnabled = false
            }else if i > (daysInThisMonth + firstWeekdayThisMonth - 2){
                // 下一个月的日期
                let frontday = i - daysInThisMonth - firstWeekdayThisMonth + 2
                daysArray[i].setTitle(String(frontday), for: .normal)
                daysArray[i].setTitleColor(UIColor.init(colorLiteralRed: (155/255.0), green: (155/255.0), blue: (155/255.0), alpha: (1)), for: .normal)
                daysArray[i].isUserInteractionEnabled = false
            }else{
                // 本月的日期
                let frontday = i - firstWeekdayThisMonth + 2
                daysArray[i].tag = frontday
                daysArray[i].setTitle(String(frontday), for: .normal)
                daysArray[i].setTitleColor(UIColor.init(colorLiteralRed: (79/255.0), green: (79/255.0), blue: (79/255.0), alpha: (1)), for: .normal)
                daysArray[i].isUserInteractionEnabled = true
            }
            
        }
    }
    
    // 返回年或者月的天数
    private func totaldaysInMonth(date: Date) -> Int{
       return (Calendar.current.range(of: .day, in: .month, for: date)?.count)!
    }
    // 返回一个月的第一天是周几
    func getWeekDay(dateTime:Date)->Int{
        let interval = Int(dateTime.timeIntervalSince1970) + TimeZone.current.secondsFromGMT()
        let days = Int(interval/86400) // 24*60*60
        let weekday = (days%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    
    // 求距离现在的X的时间（月）
    private func nextOrFrontMonth(inputdate: Date, spaceTime: Int) -> Date{
        var dateComponents = DateComponents()
        dateComponents.month = spaceTime
        let newDate = Calendar.current.date(byAdding: dateComponents, to: inputdate)
        return newDate!
    }
    
    
    //  #selector 方法
    @objc private func dateAction(btn: UIButton){
        btn.isSelected = !btn.isSelected
    }
    @objc private func leftBtnAction(btn: UIButton){
        inputDate = nextOrFrontMonth(inputdate: inputDate!, spaceTime: -1)
    }
    @objc private func rightBtnAction(btn: UIButton){
        inputDate = nextOrFrontMonth(inputdate: inputDate!, spaceTime: 1)
    }
    @objc private func setupNextMonth(){
        inputDate = nextOrFrontMonth(inputdate: inputDate!, spaceTime: 1)

    }
    @objc private func setupFrontMonth(){
        inputDate = nextOrFrontMonth(inputdate: inputDate!, spaceTime: -1)
    }
    // 懒加载
    // 日期的button的数组
    private lazy var daysArray: [UIButton] = {
        var array = [UIButton]()
        for i in stride(from: 0, to: 42 ,by: 1) {
            let btn = UIButton()
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.addTarget(self, action: #selector(dateAction(btn:)), for: .touchUpInside)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = self.btnSize/2
            btn.setBackgroundImage(UIImage(named:"orange-off"), for: .selected)

            array.append(btn)
        }
        return array
    }()
    // 日期的button的尺寸（长宽一样）
    private lazy var btnSize: CGFloat = {
        let width = (self.bounds.size.width - CGFloat((self.weekArray.count + 1) * datePad)) / CGFloat(self.weekArray.count)
        return width
    }()
    // 日历的头部
    private lazy var headView = UIView()
    // 日历的主干
    private lazy var bodyView = UIView()
    // 日历的星期的数组
    private lazy var weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    // 年月的label
    private lazy var headlabel:UILabel = {
        let label = UILabel()
        let ndf = DateFormatter()
        ndf.dateFormat = "yyyy年MM月"

        label.text = ndf.string(from: self.inputDate!)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.init(colorLiteralRed: (29/255.0), green: (29/255.0), blue: (29/255.0), alpha: (1))
        label.textAlignment = .center
        return label
    }()
    // 左边的图标
    private lazy var leftBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"last"), for: .normal)
        btn.addTarget(self, action: #selector(leftBtnAction(btn:)), for: .touchUpInside)
        return btn
    }()
    // 右边的图标
    private lazy var rightBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"next"), for: .normal)
        btn.addTarget(self, action: #selector(rightBtnAction(btn:)), for: .touchUpInside)
        return btn
    }()
}




