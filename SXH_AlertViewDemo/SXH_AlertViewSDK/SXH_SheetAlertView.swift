//
//  SXH_SheetAlertView.swift
//  SXH_AlertViewDemo
//
//  Created by 孙先华 on 2018/12/30.
//  Copyright © 2018年 سچچچچچچ. All rights reserved.
//

import UIKit
import Foundation

//视图显示位置枚举
enum sheetViewPosition :Int {
    case top = 0     //顶部
    case bottom = 1  //底部
    case center = 2 //中部
}


class SXH_SheetAlertView: SXH_BaseView ,UITableViewDelegate,UITableViewDataSource{
    
    
    var position :sheetViewPosition = sheetViewPosition.init(rawValue: 1)!{
        
        didSet{
            self.reloadViews()
        }
    }
    var modelArray :[SXH_CellModel] = Array(){
        
        didSet{
            self.reloadViews()
        }
    }
    var cellHeight :CGFloat = 50.0{
        
        didSet{
            self.reloadViews()
        }
    }
    
    var tableView :UITableView = UITableView.init()
    
    init(title :String,message :String,modelArray :[SXH_CellModel],position :sheetViewPosition?){
        
        if let thePosition = position {
            self.position = thePosition
        }
        self.modelArray = modelArray
        super.init(title: title, message: message)
        
        self.setValuesOfViews(title: title, message: message)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func creatViews() {
        super.creatViews()
        
        self.alertView.addSubview(tableView)
        tableView.frame = self.frame
        tableView.register(Cell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
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
        segLineView.isHidden = (title.count == 0 && message.count == 0)
        
        
        self.reloadViews()
        
    }
    
    
    //MARK:--重新布局刷新数据
    private func reloadViews(){
        
        var tableViewHeight = CGFloat(modelArray.count)*cellHeight
        alertViewHeight = self.segLineView.frame.maxY + tableViewHeight
        
        if alertViewHeight > self.bounds.height {
            tableViewHeight = self.bounds.height - self.segLineView.frame.maxY - 10
        }
        
        self.alertView.frame = CGRect.init(x: 0, y: 0, width: self.alertViewWidth, height: alertViewHeight)
        self.tableView.frame = CGRect.init(x: 0, y: self.segLineView.frame.maxY + 10, width: self.alertViewWidth, height: tableViewHeight)

        let leftEdg = (screenWidth - alertViewWidth)/2.0
        switch self.position {
        case .bottom:
            self.alertView.frame = CGRect.init(x: leftEdg, y: screenHeight-alertViewHeight, width: self.alertViewWidth, height: alertViewHeight)
        case .top:
            self.alertView.frame = CGRect.init(x: leftEdg, y: 0, width: self.alertViewWidth, height: alertViewHeight)
        case .center:
            self.alertView.frame = CGRect.init(x: 0, y: 0, width: self.alertViewWidth, height: alertViewHeight)
            self.alertView.center = self.center
        }
        tableView.reloadData()
    }
    
    
    
    //MARK:出现弹框
    func showAlertViewCallback(value:ClickCallbackValue?){
        
        //出现视图
        self.show()
        //回调
        self.clickCallbackValue = value
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cell
        let model = modelArray[indexPath.row]
        cell.imageView?.image = model.iconImageView
        cell.textLabel?.text = model.titleText
        cell.detailTextLabel?.text = model.detailText
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let block = clickCallbackValue else {
            return
        }
        block(indexPath.row)
        self.hiddenView()

    }
    
    
}


private class Cell :UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reloadCell(cellModel :SXH_CellModel){
        
    }
    
}



//用于展示列表的数据模型，列表展示时都先实例化并传入此模型
struct SXH_CellModel {
    var titleText :String?
    var detailText :String?
    var iconImageView :UIImage?
    
    init(titleText :String?,detailText :String?,iconImageViewString :String?){
        
        self.titleText = titleText
        self.detailText = detailText
        
        if let iconString = iconImageViewString {
            iconImageView = UIImage.init(named: iconString)
        }
        
        
    }
    
}
