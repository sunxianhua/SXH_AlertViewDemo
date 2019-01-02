//
//  SXH_BaseView.swift
//  SXH_AlertViewDemo
//
//  Created by 孙先华 on 2018/12/30.
//  Copyright © 2018年 سچچچچچچ. All rights reserved.
//

import UIKit


class SXH_BaseView: UIView {
    
    //尺寸
    var screenWidth  = UIScreen.main.bounds.size.width
    var screenHeight = UIScreen.main.bounds.size.height
    var alertViewWidth :CGFloat  = UIScreen.main.bounds.size.width
    var alertViewHeight :CGFloat = UIScreen.main.bounds.size.height
    
    //控件
    var titleLabel = UILabel.init()
    var messageLabel = UILabel.init()
    //遮罩
    var costomView = UIView.init()
    //弹框容器
    var alertView = UIView.init()
    //按钮和提示文字的分割线
    var segLineView = UIView.init()
    
    
    /// 定义点击的回调
    typealias ClickCallbackValue=(_ clickIndex:Int)->Void
    /// 声明闭包
    var clickCallbackValue:ClickCallbackValue?
    
    
    //回调方法
    func funcCallback(value:ClickCallbackValue?){
        clickCallbackValue = value //返回值
    }
    
    init(title :String?,message :String?){
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.creatViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func creatViews(){
        
        self.alertViewWidth = self.frame.width
        self.alertViewHeight = self.frame.height
        
        costomView.backgroundColor = UIColor.init(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 0.7)
        costomView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: alertViewHeight)
        
        alertView.backgroundColor = UIColor.white
        alertView.frame = CGRect.init(x: 0, y: 0, width: alertViewWidth, height: alertViewHeight)
        alertView.center = costomView.center
        alertView.layer.cornerRadius = 10.0
        alertView.layer.masksToBounds = true
        
        
        titleLabel.frame = CGRect.init(x: 0, y: 0, width: alertViewWidth-32, height: 0)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        messageLabel.frame = CGRect.init(x: 0, y: titleLabel.frame.maxY + 10.0, width: alertViewWidth-32, height: 0)
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        
        alertView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        
        segLineView.backgroundColor = UIColor.init(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 1)
        segLineView.frame = CGRect.init(x: 0, y: messageLabel.frame.maxY + 10.0, width: alertViewWidth, height: 1.0)
        
        
        self.addSubview(costomView)
        self.addSubview(alertView)
        self.alertView.addSubview(titleLabel)
        self.alertView.addSubview(messageLabel)
        self.alertView.addSubview(segLineView)
    }
    
    
    
    //出现弹框
    func show(){
        UIApplication.shared.keyWindow?.addSubview(self)
        self.costomView.alpha = 0.0
        UIView.animate(withDuration: 0.34, animations: { [unowned self] in
            self.costomView.alpha = 1.0
        })
        
    }
    
    
    //隐藏弹框
    func hiddenView(){
        self.costomView.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

