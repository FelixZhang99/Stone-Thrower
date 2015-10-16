//
//  StoreViewController.swift
//  寻路
//
//  Created by Zhangfutian on 15/10/14.
//  Copyright © 2015年 Zhangfutian. All rights reserved.
//
import UIKit
import Foundation


class StoreViewController:UIViewController{
    
    var back=UIButton()
    
    var buy = UIButton()
    
    var label = UILabel()
    
    let rest = UILabel()
    let rocklabel = UILabel()
    
    
    override func viewDidLoad() {
        
        setlife()
        
        
        
        back = UIButton(type: UIButtonType.System)
        back.frame = CGRectMake(4*width/5-25, height/12, 50, 20)
        back.setTitle("返回", forState: .Normal)
        back.titleLabel?.font = UIFont.systemFontOfSize(20)
        back.addTarget(self, action: "bg", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(back)
        
        let title = UILabel(frame: CGRectMake(width/2-50, height/9, 100, 50))
        title.text = "商店"
        title.font = UIFont.systemFontOfSize(25)
        title.textAlignment = NSTextAlignment.Center
        self.view.addSubview(title)
        
        label = UILabel(frame: CGRectMake(width/4-50, height/3-20, 200, 35))
        label.text = "五块石头换一条命"
        self.view.addSubview(label)
        
        for i in 1...5{
            let n = arc4random()%3 + 1
            let image = UIImageView(image: UIImage(named: "rock\(n).png"))
            image.frame = CGRectMake(width/4 - 55 + CGFloat(i)*10, height/3+20, 20, 20)
            self.view.addSubview(image)
            
        }
        
        let image1 = UIImageView(image: UIImage(named: "to.png"))
        image1.frame = CGRectMake(width/4 + 20, height/3+20, 25, 20)
        self.view.addSubview(image1)
        
        let image2 = UIImageView(image: UIImage(named: "life.tif"))
        image2.frame = CGRectMake(width/4 + 50, height/3+20, 25, 20)
        self.view.addSubview(image2)
        
        buy = UIButton(type: UIButtonType.System)
        buy.setTitle("买", forState: .Normal)
        buy.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 75/255, alpha: 1)
        
        buy.setTitleColor(UIColor.blackColor(), forState: .Normal)
        buy.frame = CGRectMake(3*width/4-30, height/3, 60, 35)
        buy.layer.cornerRadius = 10
        self.view.addSubview(buy)
        
        buy.addTarget(self, action: Selector("change"), forControlEvents: UIControlEvents.TouchUpInside)
     
        if restrock<5{
            buy.enabled = false
        }
    }
    
    func change(){
        
        restrock -= 5
        
        restlife++
        
        if restrock<5{
            buy.enabled = false
        }
        
        rest.text = "*\(restlife)"
        
        rocklabel.text = "rock:\(restrock)"
        
    }
    
    func bg(){
        
        let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sb")
        
        self.presentViewController(gameViewController, animated: false, completion: nil)
        
        
    }
    func setlife(){
        let life = UIImageView(image: UIImage(named: "life.tif"))
        
        life.frame = CGRectMake(4, 4, 15, 12)
        
        self.view.addSubview(life)
        
        rest.frame = CGRectMake(22, 4, 30, 12)
        
        rest.text = "*\(restlife)"
        
        rest.font = UIFont.systemFontOfSize(17, weight: 2.5)
        
        self.view.addSubview(rest)
        
        rocklabel.text = "rock:\(restrock)"
        
        rocklabel.frame = CGRectMake(width-80, 4, 80, 12)
        
        rocklabel.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(rocklabel)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}