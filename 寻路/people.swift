//
//  people.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/4.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//
import SpriteKit
import Foundation


class People:SKShapeNode{
    
    
    func setpeople(){
        
        self.path = CGPathCreateWithRoundedRect(CGRectMake(-16, -16, 32, 32), 16, 16, nil)
        
        self.strokeColor = SKColor.brownColor()
        self.fillColor = SKColor.brownColor()
        self.position = CGPointMake(width/2, height/8)
        
        self.alpha = 1
    }
    
    func peoplecrash(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: 16, center: CGPointMake(0, 0))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = BitMaskType.people
        
        self.physicsBody?.dynamic = true
        
        self.physicsBody?.contactTestBitMask = BitMaskType.block | BitMaskType.edge | BitMaskType.finish | BitMaskType.stick
        
    }
    
}
