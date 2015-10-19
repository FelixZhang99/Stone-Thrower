//
//  SettingViewController.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/25.
//  Copyright © 2015年 Zhangfutian. All rights reserved.
//
import UIKit
import Foundation
var musicon=true

class SetViewController:UIViewController{
    
    var back=UIButton()
    
    let slabel = UILabel()
    
    let soundoff = UISwitch()
    
    override func viewDidLoad() {
        
        back = UIButton(type: UIButtonType.System)
        
        back.frame = CGRectMake(4*width/5-25, height/12, 50, 20)
        
        back.setTitle("返回", forState: .Normal)
        
        back.titleLabel?.font = UIFont.systemFontOfSize(20)
        
        back.addTarget(self, action: "bg", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(back)
        
        slabel.text = "声音:"
        
        slabel.frame = CGRectMake(width/3-25, height/2-15, 50, 30)
        
        self.view.addSubview(slabel)
        
        soundoff.center = CGPointMake(2*width/3, height/2)
        
        soundoff.on = true
        
        soundoff.addTarget(self, action: Selector("change"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(soundoff)
        
    }
    
    func bg(){
        
        //let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sb")
        
        //self.presentViewController(gameViewController, animated: false, completion: nil)
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func change(){
        
        musicon = soundoff.on
    }
}