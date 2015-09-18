//
//  GameScene.swift
//  寻路
//
//  Created by Zhangfutian on 15/8/25.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//
import UIKit
import SpriteKit

var die=false
var restlife=3
var rockarray:[Rock] = []
var restrock = 3
var buttonhid = false

enum Throw:Int{
    case rock=1
    case people=2
}

class GameScene: SKScene,SKPhysicsContactDelegate, SKSceneDelegate {
    
    var blockernumber:Int=0
    var barrierarray:[blocker]=[]
    
    var people = People()
    var finish = Finish()
    var rockcount = 0
    var peopleable=false
    var presentrock :[Rock] = []
    var pointarray:[SKShapeNode] = []
    var rocklabel = SKLabelNode()
    var gobuttom = SKSpriteNode()
    
    
    var throw = Throw.rock
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        setbackground()
        
        setblocker()
        
        settop()
        setleft()
        setbottom()
        setright()
        
        var rock = Rock()
        
        rock.setrock()
        
        rockarray.append(rock)
        
        rock.inarray = 0
        
        throw = Throw.rock
        
        self.addChild(rock)
        
        self.finish.setfinish()
        
        self.addChild(finish)
        
        
        buttonhid=false
        
               
        
        
    }
    
    func setbackground(){
        
       
        
        rockarray = []
        
        self.backgroundColor = SKColor.whiteColor()
        
        self.size.width = width
        self.size.height = height
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        rocklabel = SKLabelNode(fontNamed:"Chalkduster")
        
        rocklabel.text = "rock*\(restrock)"
        
        rocklabel.fontColor = SKColor.blackColor()
        
        rocklabel.position = CGPointMake(60, 20)
        
        self.addChild(rocklabel)
        
        
        
        
    }
    
    func settop(){
        
        var sumlength:CGFloat = 0
        var isblock=true
        while sumlength < width{
            var randomlength = CGFloat(arc4random()) % (width / 5) + 10
            
            if isblock{
                let topedge = SKShapeNode()
                
                topedge.path = CGPathCreateWithRect(CGRectMake(-randomlength/2, -5, randomlength, 10), nil)
                topedge.position = CGPointMake(sumlength + randomlength/2, height-25)
                topedge.strokeColor = SKColor.grayColor()
                topedge.fillColor = SKColor.grayColor()
                
                topedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(randomlength, 10), center: CGPointMake(0, 0))
                println(topedge.physicsBody)
                topedge.physicsBody?.restitution=1
                topedge.physicsBody?.usesPreciseCollisionDetection = true
                topedge.physicsBody?.dynamic = false
                topedge.physicsBody?.categoryBitMask = BitMaskType.edge
                
                self.addChild(topedge)
                
                isblock=false
            
            }else{
                isblock=true
            }
            sumlength += randomlength
            
        }
            
    }
        
    func setleft(){
        
        var sumlength:CGFloat = 0
        var isblock=true
        while sumlength < height-20{
            var randomlength = CGFloat(arc4random()) % (width / 5) + 10
            
            if randomlength+sumlength>height-20{
                randomlength = height - 20 - sumlength
            }
            
            
            if isblock{
                let leftedge = SKShapeNode()
                
                leftedge.path = CGPathCreateWithRect(CGRectMake(-5, -randomlength/2, 10, randomlength), nil)
                leftedge.position = CGPointMake(5, sumlength + randomlength/2)
                leftedge.strokeColor = SKColor.grayColor()
                leftedge.fillColor = SKColor.grayColor()
                leftedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(10, randomlength), center: CGPointMake(0, 0))
                leftedge.physicsBody?.usesPreciseCollisionDetection = true
                leftedge.physicsBody?.dynamic = false
                leftedge.physicsBody?.categoryBitMask = BitMaskType.edge
                leftedge.physicsBody?.restitution=1
                self.addChild(leftedge)
                
                isblock=false
                
            }else{
                isblock=true
            }
            sumlength += randomlength
            
            
            
        }
        
    }
    
    func setbottom(){
        
        var sumlength:CGFloat = 0
        var isblock=true
        while sumlength < width{
            var randomlength = CGFloat(arc4random()) % (width / 5) + 10
            
            if isblock{
                let buttomedge = SKShapeNode()
                
                buttomedge.path = CGPathCreateWithRect(CGRectMake(-randomlength/2, -5, randomlength, 10), nil)
                buttomedge.position = CGPointMake(sumlength + randomlength/2, 5)
                buttomedge.strokeColor = SKColor.grayColor()
                buttomedge.fillColor = SKColor.grayColor()
                buttomedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(randomlength, 10), center: CGPointMake(0 , 0))
                buttomedge.physicsBody?.usesPreciseCollisionDetection = true
                buttomedge.physicsBody?.dynamic = false
                buttomedge.physicsBody?.categoryBitMask = BitMaskType.edge
                buttomedge.physicsBody?.restitution=1
                self.addChild(buttomedge)
                
                isblock=false
                
            }else{
                isblock=true
            }
            sumlength += randomlength
            
        }
        
    }
    
    func setright(){
        
        var sumlength:CGFloat = 0
        var isblock=true
        while sumlength < height-20{
            var randomlength = CGFloat(arc4random()) % (width / 5) + 10
            
            if randomlength+sumlength>height-20{
                randomlength = height - 20 - sumlength
            }
            
            if isblock{
                let rightedge = SKShapeNode()
                
                rightedge.path = CGPathCreateWithRect(CGRectMake(-5, -randomlength/2, 10, randomlength), nil)
                rightedge.position = CGPointMake(width-5, sumlength + randomlength/2)
                rightedge.strokeColor = SKColor.grayColor()
                rightedge.fillColor = SKColor.grayColor()
                rightedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(10, randomlength) , center: CGPointMake(0, 0))
                rightedge.physicsBody?.usesPreciseCollisionDetection = true
                rightedge.physicsBody?.dynamic = false
                rightedge.physicsBody?.categoryBitMask = BitMaskType.edge
                rightedge.physicsBody?.restitution=1
                self.addChild(rightedge)
                
                isblock=false
                
            }else{
                isblock=true
            }
            sumlength += randomlength
            
        }
        
    }
    
    func setblocker(){
        
        if level<3{
            blockernumber = 3
            
        }else if level<6{
            blockernumber = 4
        }else{
            blockernumber = 5
        }
        
        
        
        
        var blockerexist=true
        var i = 0
        
        while i < blockernumber{
            i++
            
            var block = blocker()
            
            block.setbarrier()
            
            blockerexist = true
            
            for other in barrierarray{
                var dirX=Double(block.x - other.x)
                var dirY=Double(block.y - other.y)
                
                var dir=sqrt(dirX*dirX+dirY*dirY)
                if dir<Double(block.ballsize/2+other.ballsize/2){
                    blockerexist=false
                }
            }
            
            var dirXfromrock = Double(block.x - width/2)
            var dirYfromrock = Double(block.y - height/10)
            var dirfromrock = sqrt(dirXfromrock * dirXfromrock + dirYfromrock * dirYfromrock)
            
            if dirfromrock < Double(block.ballsize) + 20 {
                blockerexist=false
            }
            
            var dirXfromfin = Double(block.x - width/2)
            var dirYfromfin = Double(block.y - 9*height/10)
            var dirfromfin = sqrt(dirXfromfin * dirXfromfin + dirYfromfin * dirYfromfin)
            
            if dirfromfin < Double(block.ballsize){
                blockerexist=false
            }
            
            if blockerexist{
                barrierarray.append(block)
                self.addChild(block)
                
            }else{
                blockernumber++
            }
            
            
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.block|BitMaskType.rock){
            println("crash")
            
            
            let a = contact.bodyA.node
            let b = contact.bodyB.node
            showblock(a!.position)
            
            //disline(b!.position)
        }
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.edge|BitMaskType.rock){
            
            let b = contact.bodyB.node
            
            //disline(b!.position)
            println("crashwall")
        }
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.people|BitMaskType.block)||(contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.people|BitMaskType.edge){
            
            peopleable=false
            
            if restlife>0{
                
                restlife -= 1
            }else{
                die=true
            }
            
            
            restart()
            
            println("badcrash")
        }
        
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.people|BitMaskType.block){
            showpeople()
        }
    }
    
    var showbarrier:blocker!
    
    func showblock(pos:CGPoint){
        
        for barrier in barrierarray{
            
            if barrier.position == pos{
                
                    showbarrier = barrier
            }
        }
        
        if !showbarrier.isshow{
            
            showbarrier.show()
            
        }
        
        showbarrier.isshow = true
        
    }
    
    func disline(pos:CGPoint){
        
        for rock in rockarray{
            if rock.position == pos{
                rock.lineneed=false
                
                
            }
        }
    }
    
    func showpeople(){
        
        for barrier in barrierarray{
            
            barrier.show()
            
        }
        
    }
    
    var beginlocation:CGPoint = CGPointMake(0, 0)
    var lastlocation:CGPoint = CGPointMake(0, 0)
    var endlocation:CGPoint = CGPointMake(0, 0)
    var disrock=false
    var distouch=false
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
        for touch in (touches as! Set<UITouch>){
        
            beginlocation = touch.locationInNode(self)
            
        }

        lastlocation = beginlocation
        
        if !nextlevel && !stop{
        
            if throw == Throw.rock{
                if !disrock{
                    rockarray.last!.position = CGPointMake(width/2, height/10)
                    rockarray.last!.physicsBody?.velocity = CGVectorMake(0, 0)
                    //moveline()
                }else{
                    distouch=true
                }
            }else{
                
                people.peoplecrash()
                
                
            }
        }
        
        if restrock==1{
            buttonhid=true
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var presentlocation:CGPoint = CGPoint(x: 0,y: 0)
        
        
        
        for touch in (touches as! Set<UITouch>){
                presentlocation = touch.locationInNode(self)
            }

        if throw == Throw.rock && !stop{
            
            if !distouch{
            var dirX = CGFloat(beginlocation.x-presentlocation.x)
            var dirY = CGFloat(beginlocation.y-presentlocation.y)
            
            dirX /= 4
            dirY /= 4
            
                var dis = sqrt(dirX*dirX+dirY*dirY)
                
                if dis>20{
                    dirX *= 20/dis
                    dirY *= 20/dis
                }
                
                
            rockarray.last?.position = CGPointMake(width/2 - dirX, height/10 - dirY)
               
               
                if pointarray.isEmpty{
                
                    for i in 1...15 {
                    
                     
                    var x = width/2 - dirX + CGFloat(i)*dirX*1.8
                     var y = height/10 - dirY + CGFloat(i)*dirY*1.8
                    
                        let line = SKShapeNode()
                        
                        line.path = CGPathCreateWithRoundedRect(CGRectMake(-4, -4, 8, 8), 4, 4, nil)
                        
                        line.alpha = 1 - CGFloat(i)*0.06
                        
                        line.position = CGPointMake( x , y )
                        
                        line.strokeColor = SKColor.blackColor()
                        
                        line.fillColor = SKColor.whiteColor()
                        
                        self.addChild(line)
                        
                        pointarray.append(line)
                        
                        
                        }
                  }else if pointarray.count == 15{
                    
                    for i in 1...15{
                        
                        var x = width/2 - dirX + CGFloat(i)*dirX*1.8
                        var y = height/10 - dirY + CGFloat(i)*dirY*1.8
                        
                        
                        pointarray[i-1].runAction(SKAction.moveTo(CGPointMake(x, y), duration: 0))
                        
                    }

                }
            }
            
            
            
            
            
        }
        
        
        if !nextlevel && !stop{
        if peopleable{
            
            var x = CGFloat(presentlocation.x-lastlocation.x)
            var y = CGFloat(presentlocation.y-lastlocation.y)
            
            println([x,y])
            
                        
            people.runAction(SKAction.moveByX(x, y: y, duration: 0))
            
            var dirX=Double(people.position.x - finish.position.x)
            var dirY=Double(people.position.y - finish.position.y)
            
            var dir=sqrt(dirX*dirX+dirY*dirY)
            
            if dir<29{
                restart()
            }
            
            }
        }
        lastlocation = presentlocation
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
      

        for touch in (touches as! Set<UITouch>){
            
            endlocation = touch.locationInNode(self)
            
        }
        
        if throw == Throw.rock && !stop{
            if !distouch{
                if !peopleable{
                var dirX=Double(beginlocation.x - endlocation.x)
                var dirY=Double(beginlocation.y - endlocation.y)
                
                var dir=sqrt(dirX*dirX+dirY*dirY)
                
                if dir>30{
                rockcount++
                rockarray.last!.moverock(beginlocation,end: endlocation)
            
                presentrock = [rockarray.last!]
                
                rockarray.last!.lineneed = true
                
                    
                    
        
                    if restrock>1{
        
                        disrock=true
       
                        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("newrock"), userInfo: nil, repeats: false)
            
                    }else{
     
                        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("newpeople"), userInfo: nil, repeats: false)
                        
                    
                        
   
                    }
                    
                    
                    
                        restrock--
                        
                        rocklabel.text = "rock*\(restrock)"
       
                    }
                    
                }
            }else{
                distouch=false
            }
          

        }
        
        for line in pointarray{
            line.removeFromParent()
            line.removeAllActions()
        }
        pointarray=[]
        
        
    }
    
    
    
    func newrock(){
        var rock1 = Rock()
        rock1.setrock()
        rockarray.append(rock1)
        disrock=false
        self.addChild(rock1)
        rock1.inarray = rockarray.count-1
        
        throw = Throw.rock
        
    }
    
    func newpeople(){
        
        people.setpeople()
        peopleable=true
        self.addChild(people)
        
        throw = Throw.people
        
        buttonhid = true
        
    }
    
    func restart(){
        nextlevel=true
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        for rock in rockarray{
            
            if (rock.position.x < 8) || (rock.position.x > width - 8) || (rock.position.y < 8) || (rock.position.y > height - 28) || (rock.physicsBody?.velocity == CGVectorMake(0, 0)){
                
                rock.disapear()
                
            }
            
        }
        if !nextlevel{
        if peopleable==true{
       
            if (people.position.x < 8) || (people.position.x > width - 8) || (people.position.y < 8) || (people.position.y > height - 28) {
            
                if restlife>0{
                    
                    restlife -= 1
                }else{
                    die=true
                }
                
                nextlevel=true
               
            }
        }
        }
        
        people.physicsBody?.velocity = CGVectorMake(0, 0)
        
        if go{
            
            println(rockarray.count)

            rockarray.last?.removeFromParent()
                        
            
            newpeople()
            go=false
        }
        
        
    }
    
    
    
    
}





