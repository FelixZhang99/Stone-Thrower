//
//  barrier.swift
//  寻路
//
//  Created by Zhangfutian on 15/8/25.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//
import UIKit
import Foundation
import SpriteKit





class blocker:SKShapeNode {
    var ballsize:CGFloat=0
        
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    var isshow = false

    
    func setbarrier(){
        
        var randomsize = CGFloat(random()%30 - 15)
        
        ballsize = width/6 + randomsize
        
        x = (CGFloat(arc4random()) % (width-ballsize-10)) + (ballsize/2+5)
        y = (CGFloat(arc4random()) % (height-ballsize-30)) + (ballsize/2+5)
        
        
        self.path = CGPathCreateWithRoundedRect(CGRectMake(-ballsize/2, -ballsize/2, ballsize, ballsize), ballsize/2, ballsize/2, nil)
        self.position = CGPointMake(x, y)
        self.strokeColor = SKColor.blackColor()
        self.fillColor = SKColor.grayColor()
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballsize/2, center: CGPointMake(0, 0))
        
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = BitMaskType.block
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 1
       
        self.alpha = 0
        
        
    }
    
    func show(){
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "showmore", userInfo: nil, repeats: false)
    }
    
    func showmore(){
        
        if self.alpha<0.5{
            self.alpha += 0.02
            
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "showmore", userInfo: nil, repeats: false)
        
        }
        
    }
    
}

class strick:blocker{
    
    override func setbarrier() {
        
        x = (CGFloat(arc4random()) % (width-ballsize-10)) + (ballsize/2+5)
        y = (CGFloat(arc4random()) % (height-ballsize-30)) + (ballsize/2+5)
        self.path = CGPathCreateWithRect(CGRectMake(-50, -5, 100, 10), nil)
        self.position = CGPointMake(x, y)
        self.strokeColor = SKColor.blackColor()
        self.fillColor = SKColor.grayColor()
        
        
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 10))
        
       
        
        
        
    }
    
}








class BitMaskType{
    class var rock:UInt32{
        return 1<<0
    }
    
    class var block:UInt32{
        return 1<<1
    }
    
    class var edge:UInt32 {
        return 1<<2
    }
    
    class var finish:UInt32{
        return 1<<3
    }
    
    class var people:UInt32 {
        return 1<<4
    }
}


