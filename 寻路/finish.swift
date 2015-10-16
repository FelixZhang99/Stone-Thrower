//
//  finish.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/4.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//
import SpriteKit
import Foundation


class Finish:SKShapeNode{
    
    
    func setfinish(){
        
        self.path = CGPathCreateWithRoundedRect(CGRectMake(-15, -15, 30, 30), 15, 15, nil)
        
        self.strokeColor = SKColor.brownColor()
        self.fillColor = SKColor.brownColor()
        self.position = CGPointMake(width/2, 9*height/10-20)
        
        self.alpha = 0
       
    }
    
    func needtouch(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: 9, center: CGPointMake(0, 0))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = BitMaskType.finish
        
        self.physicsBody?.dynamic = false
        

    }
}

