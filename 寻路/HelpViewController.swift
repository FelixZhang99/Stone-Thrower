//
//  HelpViewController.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/23.
//  Copyright © 2015年 Zhangfutian. All rights reserved.
//
import UIKit
import Foundation


class HelpViewController:UIViewController, UIScrollViewDelegate{
    
    
    let pagenumber = 5
    let pagewidth = width
    let pageheight = height-100
    var scrollView :UIScrollView = UIScrollView(frame: CGRectMake(0, 0, width, height-100))
    var pagecontrol:UIPageControl = UIPageControl(frame: CGRectMake(width/2-150, 9*height/10, 300, 40))
    let content = [
        0:"每关给三个石头，在屏幕任何地方向下拖拽以投出石头，石头撞到障碍物会使障碍物显现出来",
        1:"摸清地形之后，通过拖拽目标到终点并避开所有障碍物通关，关卡越往后障碍物越多",
        2:"目标如果撞到障碍物会死一条命，总共有三条命，商店里可以用石头买命",
        3:"拖拽通过手指滑动距离移动目标，也就是说手指可以不放在目标上移动",
        4:"按go按钮可以直接开始移动目标，以保留石头后期使用，玩的开心哦",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(pagewidth * CGFloat(pagenumber) , pageheight)
        
        scrollView.pagingEnabled = true
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.scrollsToTop = false
        
        scrollView.delegate = self
        
        let View1:UIView = UIView(frame: CGRectMake(0, 0, width, height-100))
        scrollView.addSubview(View1)
        
        let View2:UIView = UIView(frame: CGRectMake(width, 0, width, height-100))
        scrollView.addSubview(View2)
        
        let View3:UIView = UIView(frame: CGRectMake(width*2, 0, width, height-100))
        scrollView.addSubview(View3)
        
        let View4:UIView = UIView(frame: CGRectMake(width*3, 0, width, height-100))
        scrollView.addSubview(View4)
        
        let View5:UIView = UIView(frame: CGRectMake(width*4, 0, width, height-100))
        scrollView.addSubview(View5)
        
        var viewarray = [View1,View2,View3,View4,View5]
        
        for i in 0 ... pagenumber-1 {
            
            let contentlabel = UILabel(frame: CGRectMake(width / 10, height/5, 4*width/5, height/5))
            
            contentlabel.font = UIFont.systemFontOfSize(20)
            
            contentlabel.text = content[i]
            
            contentlabel.numberOfLines = 4
            
            viewarray[i].addSubview(contentlabel)
        }
        
        let image1 = UIImageView(image: UIImage(named: "rock1.png"))
        image1.frame = CGRectMake(width/2-10, height/2, 20, 20)
        
        viewarray[0].addSubview(image1)
        
        let image2 = UIImageView(image: UIImage(named: "wood1.png"))
        image2.frame = CGRectMake(width/3-40, height/2, 80, 80)
        
        viewarray[1].addSubview(image2)
        
        let image3 = UIImageView(image: UIImage(named: "stick1.png"))
        image3.frame = CGRectMake(2*width/3-50, height/2+20, 100, 10)
        
        viewarray[1].addSubview(image3)
        
        let image4 = UIImageView(image: UIImage(named: "life.tif"))
        image4.frame = CGRectMake(width/2-20, height/2, 20, 20)
        
        viewarray[2].addSubview(image4)
        
        let ll = UILabel(frame: CGRectMake(width/2+2, height/2, 30, 20))
        ll.text = "*3"
        ll.font = UIFont.systemFontOfSize(20)
        
        viewarray[2].addSubview(ll)
        
        let image6 = UIImageView(image: UIImage(named: "buttom.tif"))
        image6.frame = CGRectMake(width/2-30, height/2, 60, 60)
        
        viewarray[4].addSubview(image6)
        
        let button:UIButton = UIButton(type: UIButtonType.System)
        
        button.frame = CGRectMake(width/2-80 , 2*height/3, 160, 60)
        
        button.setTitle("开始游戏", forState: .Normal)
        
        button.backgroundColor = UIColor.brownColor()
        
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(27, weight: 4)
        
        button.layer.cornerRadius = 10
        
        button.enabled = true
        
        button.addTarget(self, action: "gogame", forControlEvents: UIControlEvents.TouchUpInside)
        
        View5.addSubview(button)
        
        self.view.addSubview(scrollView)
        
        pagecontrol.numberOfPages = 5
        
        pagecontrol.currentPage = 0
        
        pagecontrol.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(pagecontrol)
    }
    
    
    func gogame(){
        //let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sb")
        
        //self.presentViewController(gameViewController, animated: false, completion: nil)
    
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offX:CGFloat = scrollView.contentOffset.x
        
        let index:Int = Int(offX/width)
        print(index)
        pagecontrol.currentPage = index
    }
    
}