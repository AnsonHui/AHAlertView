//
//  ViewController.swift
//  AHAlertView
//
//  Created by 黄辉 on 07/06/2017.
//  Copyright © 2017 Fantasy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AHAlertView.normalTextColor = UIColor.black
        AHAlertView.highlightTextColor = UIColor.red
        AHAlertView.seperatorLineColor = UIColor.lightGray
        
        let button1 = UIButton(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        button1.backgroundColor = UIColor.red
        button1.setTitleColor(UIColor.black, for: UIControlState.normal)
        button1.setTitle("测试两个选项", for: UIControlState.normal)
        button1.addTarget(self, action: #selector(self.testAlert0), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button1)
        
        let button = UIButton(frame: CGRect(x: 50, y: 130, width: 200, height: 50))
        button.backgroundColor = UIColor.red
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.setTitle("测试多个选项", for: UIControlState())
        button.addTarget(self, action: #selector(self.testAlert1), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    func testAlert0() {
        let alertView = AHAlertView(title: "测试两个选项", message: "message", block: { (alertView, buttonIndex) in
            
            print("点击\(buttonIndex)")
            
        }, cancelButtonTitle: "cancel", otherButtonTitles: "0")
        alertView.show()
    }
    
    func testAlert1() {
        
        let alertView = AHAlertView(title: "测试多个选项", message: "message", block: { (alertView, buttonIndex) in
            
            print("点击\(buttonIndex)")
            
        }, cancelButtonTitle: "cancel", otherButtonTitles: "0", "1", "2", "3")
        alertView.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
