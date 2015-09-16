//
//  ViewController.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/11.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//
import UIKit
import Foundation


class BackViewController:UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sb") as! UIViewController
    
        self.presentViewController(gameViewController, animated: false, completion: nil)
        
    }
    
    
    
}