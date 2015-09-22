//
//  rock.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/1.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//
import UIKit
import Foundation
import SpriteKit

enum Status:Int{
    case stop=1,move,end
}


class Rock:SKShapeNode{
    
    var status = Status.stop
    
    var inarray = 0
    
    var lineneed = false
    

    
    func setrock(){
       
        
        
        self.path = CGPathCreateWithRoundedRect(CGRectMake(-9, -9, 18, 18), 9, 9, nil)
        
        self.strokeColor = SKColor.grayColor()
        self.fillColor = SKColor.grayColor()
        self.position = CGPointMake(width/2, height/10)
        
        
        self.status = .stop
        
    }
    
    func moverock(begin:CGPoint,end:CGPoint){
        self.physicsBody = SKPhysicsBody(circleOfRadius: 9, center: CGPointMake(0, 0))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = BitMaskType.rock
        
        self.physicsBody?.restitution = 1
        
        self.physicsBody?.dynamic = false
        self.physicsBody?.contactTestBitMask = BitMaskType.block | BitMaskType.edge
        self.physicsBody?.allowsRotation = false

        self.status = .move
        self.physicsBody?.dynamic = true
        
        var x = begin.x - end.x
        var y = begin.y - end.y
        
        x = x*10
        y = y*10
        
       
        var dis=sqrt(x*x+y*y)
        
        if dis>800{
            
            x *= 800/dis
            y *= 800/dis
            
            print(sqrt(x*x+y*y))
        }
        
        self.physicsBody?.velocity = CGVectorMake(x, y)
        
        
    }
    
    
    func disapear(){
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "disapearmore", userInfo: nil, repeats: false)
        self.removefromarray()
    }
    
    func disapearmore(){
        
        if self.alpha>0{
            self.alpha -= 0.02
            
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "disapearmore", userInfo: nil, repeats: false)
            
        }else{
           
            self.removeFromParent()
            
        }
        
    }
    
    func createpoint()->SKShapeNode{
        
        let line = SKShapeNode()
        
        line.path = CGPathCreateWithRoundedRect(CGRectMake(-4, -4, 8, 8), 4, 4, nil)
        
        line.position = self.position
        line.strokeColor = SKColor.blackColor()
        line.fillColor = SKColor.grayColor()
            
        return line
        
    }
    
    func removefromarray(){
        
        
        rockarray.removeAtIndex(inarray)
        
        for rock in rockarray{
            if rock.inarray>self.inarray{
                rock.inarray--
            }
            
            
        }
    }
    
}