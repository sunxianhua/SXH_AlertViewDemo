//
//  ViewController.swift
//  SXH_AlertViewDemo
//
//  Created by 孙先华 on 2018/12/27.
//  Copyright © 2018年 سچچچچچچ. All rights reserved.

import UIKit

class ViewController: UIViewController {

    var theView = UIView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        
        self.view.addSubview(theView)
        theView.backgroundColor = UIColor.red
        theView.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        
        let sonView = UIView.init(frame: CGRect.init(x: 20, y: 20, width: 20, height: 20))
        theView.addSubview(sonView)
        sonView.backgroundColor = UIColor.black
        sonView.autoresizingMask = .flexibleHeight
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var dataArray :[SXH_CellModel] = Array()
        for item in ["第一","第二","第三","第四","第二","第三","第四","第二","第三","第四","第二","第三","第四","第二","第三","第四","第二","第三","第四","第二","第三","第四"] {
            let model = SXH_CellModel.init(titleText: item, detailText: "", iconImageViewString: nil)
            dataArray.append(model)
        }
        
        let alertView = SXH_SheetAlertView.init(title: "", message: "", modelArray: dataArray, position: .top)
        alertView.showAlertViewCallback { (index) in
            debugPrint("\(index)")
        }
        
    }


}

