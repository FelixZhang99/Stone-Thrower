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





class blocker:SKSpriteNode {
    var ballsize:CGFloat=0
        
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    var isshow = false

    
    
    func setbarrier(bs:CGFloat,x:CGFloat,y:CGFloat){
        
        let i = arc4random()%4 + 1
        
        let texture = SKTexture(imageNamed: "wood\(i).png")
        
        self.x = x
        self.y = y
        
        
        ballsize = bs
        
                
        self.texture = texture
        self.size = CGSizeMake(ballsize, ballsize)
        
        self.position = CGPointMake(x, y)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballsize/2)
        
        
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
        
        if self.alpha<1{
            self.alpha += 0.05
            
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "showmore", userInfo: nil, repeats: false)
        
        }
        
    }
    
}

class stick:blocker{
    
    override func setbarrier(bs:CGFloat,x:CGFloat,y:CGFloat) {
        
        let i = arc4random()%2 + 1
        
        let texture = SKTexture(imageNamed: "stick\(i).png")
        
        self.x = x
        self.y = y
        
        //x = (CGFloat(arc4random()) % (width-110)) + (55)
        //y = (CGFloat(arc4random()) % (height-120)) + (55)
        
        
        self.texture = texture
        self.size = CGSizeMake(100, 10)
        self.position = CGPointMake(x, y)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
     
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = BitMaskType.stick
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 1
        self.physicsBody?.angularVelocity = CGFloat(arc4random()%10)
        
        self.alpha = 0
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "stopmove", userInfo: nil, repeats: false)
        
    }
    
    func stopmove(){
        
        
        x = self.position.x
        y = self.position.y
        
        self.physicsBody?.dynamic = false
        
        self.physicsBody?.categoryBitMask = BitMaskType.stick
        
        
        
        
    }
    
    
}








class BitMaskType{
    class var rock:UInt32{
        return 1<<0
    }
    
    class var block:UInt32{
        return 1<<1
    }
    
    class var stick:UInt32{
        return 1<<2
    }
    
    class var edge:UInt32 {
        return 1<<3
    }
    
    class var finish:UInt32{
        return 1<<4
    }
    
    class var people:UInt32 {
        return 1<<5
    }
}


