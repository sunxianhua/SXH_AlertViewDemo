//
//  SXH_AlertView.swift
//  SXH_AlertViewDemo
//
//  Created by 孙先华 on 2018/12/30.
//  Copyright © 2018年 سچچچچچچ. All rights reserved.
//

import UIKit
import Foundation

enum alertType :Int {
    case rowType = 0  //竖排
    case conlumn = 1  //横排
}

class SXH_AlertView: SXH_BaseView {
    
        private var buttonTitleArray :[String] = Array()
        var buttonArray :[AlertButton] = Array()
    
    
        /// 初始化方法
        ///
        /// - Parameters:
        ///   - buttonTitleArray: 其它按钮
        ///   - alertType: 按钮排列方式 默认横排
    
        private var alertType :alertType = .conlumn
        init(title :String,message :String,buttonTitleArray :[String],alertType :alertType?){
    
            if let theType = alertType {
                self.alertType = theType
            }
            self.buttonTitleArray = buttonTitleArray
            super.init(title: title, message: message)
            self.setValuesOfViews(title: title, message: message)
            
            
          //  self.setValuesOfViews(title: title, message: message)
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func creatViews() {

        if self.alertType == .rowType {
            self.alertViewWidth = 280
        }else if self.alertType == .conlumn{

            if buttonTitleArray.count <= 3{
                self.alertViewWidth = 280
            }else{
                self.alertViewWidth = screenWidth - 40.0
            }

        }
        super.creatViews()
    }
    
    
    //MARK:---赋值并重绘界面---
    private func setValuesOfViews(title :String,message :String){


        let labelX:CGFloat = 16
        let labelY:CGFloat = 20
        let labelW:CGFloat = alertViewWidth - 2*labelX

        self.titleLabel.text = title
        self.titleLabel.sizeToFit()

        let titleSize = self.titleLabel.frame.size
        self.titleLabel.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: titleSize.height)


        self.messageLabel.text = message
        self.messageLabel.sizeToFit()
        let messageSize = messageLabel.frame.size
        self.messageLabel.frame = CGRect.init(x: labelX, y: self.titleLabel.frame.maxY + 10.0, width: labelW, height: messageSize.height)


        segLineView.frame = CGRect.init(x: 0, y: messageLabel.frame.maxY + 10.0, width: alertViewWidth, height: 1.0)

        for index in 0..<buttonTitleArray.count {

            var button :AlertButton!
            var buttonFrame :CGRect!


            if self.buttonArray.count-1 < index {
                button = self.creatButton(index: index, frame: CGRect.zero)
                self.buttonArray.append(button)
            }else{
                button = self.buttonArray[index]
            }


            if self.alertType == .rowType {

                buttonFrame = CGRect.init(x: 0, y: segLineView.frame.maxY + 10 + CGFloat(index)*50.0, width: alertViewWidth, height: 50.0)
                button.frame = buttonFrame
                button.leftY_lineView.isHidden = true

            }else if self.alertType == .conlumn{

                let buttonWidth = self.alertViewWidth/CGFloat(buttonTitleArray.count)
                buttonFrame = CGRect.init(x: buttonWidth * CGFloat(index), y: segLineView.frame.maxY, width: buttonWidth, height: 50.0)
                button.frame = buttonFrame
                button.bottom_LineView.isHidden = true

                if index+1 == self.buttonTitleArray.count {

                    buttonArray[index].leftY_lineView.isHidden = true
                }

            }
            button.tag = index
        }


        self.alertView.frame = CGRect.init(x: 0, y: 0, width: self.alertViewWidth, height: buttonArray.last!.frame.maxY)
        self.alertView.center = self.costomView.center

    }
    
    
    //创建按钮
    private func creatButton(index :Int,frame :CGRect) ->AlertButton {

        let buttonView = AlertButton.init(title: buttonTitleArray[index], frame: frame)
        buttonView.button.addTarget(self, action: #selector(self.buttonClick(button:)), for: .touchUpInside)
        self.alertView.addSubview(buttonView)
        return buttonView
    }



    //MARK:-按钮点击
    @objc private func buttonClick(button :UIButton){

        guard let block = self.clickCallbackValue else {
            return
        }
        block(button.tag)
        self.hiddenView()
    }


    //直接弹框--仿系统样式
    public class func showAlertView(title :String,message :String,buttonTitleArray :[String],alertType :alertType?,value:ClickCallbackValue?){

        let alertView = SXH_AlertView.init(title: title, message: message, buttonTitleArray: buttonTitleArray, alertType: alertType)
        alertView.showAlertViewCallback(value: value)
    }


    //MARK:出现弹框
    func showAlertViewCallback(value:ClickCallbackValue?){

        //出现视图
        self.show()
        //回调
        self.clickCallbackValue = value
    }

}


//MARK:----按钮---
class AlertButton :UIView {
    
    var button :UIButton = UIButton()
    var leftY_lineView = UIView()
    var bottom_LineView = UIView()
    
    init(title :String,frame: CGRect){
        super.init(frame: frame)
        
        self.creatView(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func creatView(title :String){
        
        self.addSubview(button)
        button.setTitle(title, for: .normal)
        button.frame = self.bounds
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        
        
        leftY_lineView.backgroundColor = UIColor.init(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
        self.addSubview(leftY_lineView)
        leftY_lineView.frame = CGRect.init(x: self.bounds.width-1, y: 0, width: 1.0, height: self.bounds.height)
        bottom_LineView.backgroundColor = UIColor.init(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
        self.addSubview(bottom_LineView)
        bottom_LineView.frame = CGRect.init(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1)
        
    }
    
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        button.frame = self.bounds
        leftY_lineView.frame = CGRect.init(x: self.bounds.width-1, y: 0, width: 1.0, height: self.bounds.height)
        bottom_LineView.frame = CGRect.init(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1)
        
    }
    
    
    
}

