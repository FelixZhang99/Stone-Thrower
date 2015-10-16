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
    var sticknumber:Int=0
    var stickarray:[stick]=[]
    
    var people = People()
    var finish = Finish()
    var rockcount = 0
    var peopleable=false
    var presentrock :[Rock] = []
    var pointarray:[SKShapeNode] = []
    var rocklabel = SKLabelNode()
    var gobuttom = SKSpriteNode()
    let music = MusicManager()
    var grassarr:[SKSpriteNode] = []
    var `throw` = Throw.rock
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        setbackground()
        
        setblocker()
        
        settop()
        setleft()
        setbottom()
        setright()
        
        let rock = Rock()
        
        rock.setrock()
        
        rockarray.append(rock)
        
        rock.inarray = 0
        
        `throw` = Throw.rock
        
        self.addChild(rock)
        
        self.finish.setfinish()
        
        self.addChild(finish)
        
        let texture = SKTexture(imageNamed: "flag.png")
        
        let flag = SKSpriteNode(texture: texture)
        
        flag.position = CGPointMake(width/2 + 5, 9*height/10 - 15)
        
        flag.size = CGSizeMake(33, 45)
        
        self.addChild(flag)
        
        buttonhid=false
        
        self.addChild(music)
        
               
    }
    
    func setbackground(){
        
        grassarr = []
        
        for var k=0;k<8;k++ {
            
            let i = arc4random()%2 + 1
            
            let pos = grasspos()
            
            let bgtexture = SKTexture(imageNamed: "grass\(i).png")
        
            let bg = SKSpriteNode(texture: bgtexture)
  
            bg.zPosition = -5
            
            bg.position = CGPointMake(pos.x, pos.y)
        
            bg.size = CGSizeMake(60 , 40)
        
            grassarr.append(bg)
            
            self.addChild(bg)
        }
        
        rockarray = []
        
        self.backgroundColor = SKColor(red: 153/255, green: 204/255, blue: 51/255, alpha: 0.5)
        
        self.size.width = width
        self.size.height = height
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        rocklabel = SKLabelNode(fontNamed:"Chalkduster")
        
        rocklabel.text = "rock*\(restrock)"
        
        rocklabel.fontColor = SKColor.blackColor()
        
        rocklabel.position = CGPointMake(80, 20)
        
        self.addChild(rocklabel)
        
    }
    
    func grasspos()->(x:CGFloat , y:CGFloat){
        
        var x:CGFloat = 0
        
        var y:CGFloat = 0
        
        var enable = true
        
        repeat{
        x = CGFloat(arc4random()) % (width - 100) + 50
        
        y = CGFloat(arc4random()) % (height - 100) + 50
        
            enable = true
        
            for grass in grassarr{
          
            let dirX=Double(x - grass.position.x)
            let dirY=Double(y - grass.position.y)
            
            let dir=sqrt(dirX*dirX+dirY*dirY)
            if dir<60{
                enable = false
            }
            
            let dirXfromrock = Double(x - width/2)
            let dirYfromrock = Double(y - height/8)
            let dirfromrock = sqrt(dirXfromrock * dirXfromrock + dirYfromrock * dirYfromrock)
            
            if dirfromrock < 60 {
                enable = false
            }
            
            let dirXfromfin = Double(x - width/2)
            let dirYfromfin = Double(y - 9*height/10)
            let dirfromfin = sqrt(dirXfromfin * dirXfromfin + dirYfromfin * dirYfromfin)
            
            if dirfromfin < 60{
                enable = false
            }
        }
        }while !enable
        
        return (x,y)
    }
    
    //setedge
    
    func settop(){
        
        var sumlength:CGFloat = 0
        
        var isblock = true
        let num = arc4random()%2
        if num==0{
            isblock=true
        }else{
            isblock=false
        }
        while sumlength < width{
            
            
            if isblock{
                
                var randomlength = (CGFloat(arc4random()) % abs(width / 60)) + 2
                
                if randomlength*18+sumlength > width - 10{
                    randomlength = (width - 10 - sumlength)/18
                    sumlength -= (randomlength*18 + sumlength - width + 10)
                }

                
                let main = SKNode()
                main.position = CGPointMake(sumlength + 15, height-25)
                var mainwidth:CGFloat = 0.0
                
                for var k=0 ; k < Int(randomlength) ; k++ {
                
                    let topedge = SKSpriteNode()
                    let i = arc4random()%3 + 1
                    let texture = SKTexture(imageNamed: "fence\(i).png")
        
                    topedge.texture = texture
                    topedge.size = CGSizeMake(20, 10)
                
                    topedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(20, 8), center: CGPointMake(0, 0))
                    
                    topedge.physicsBody?.restitution=1
                    topedge.physicsBody?.usesPreciseCollisionDetection = true
                    topedge.physicsBody?.dynamic = false
                    topedge.physicsBody?.categoryBitMask = BitMaskType.edge
                
                    topedge.position.x = mainwidth - 1
                    main.addChild(topedge)
                    mainwidth += topedge.size.width - 2
                    
                }
                self.addChild(main)
                isblock=false
                
                sumlength += randomlength * 18
            
            }else{
                isblock=true
                
                var randomlength = (CGFloat(arc4random()) % abs(width / 50))*9 + 9
                
                if randomlength+sumlength>width{
                    randomlength = width - sumlength
                }
                
                
                sumlength += randomlength
            }
            
            
        }
            
    }
        
    func setleft(){
        
        var sumlength:CGFloat = 0
        var isblock=true
        
        let num = arc4random()%2
        if num==0{
            isblock=true
        }else{
            isblock=false
        }
        while sumlength < height-20{
            
            
            
            if isblock{
                
                var randomlength = (CGFloat(arc4random()) % abs(width / 60)) + 2
            
           
                if randomlength*18+sumlength > height-20{
                    randomlength = (height - 20 - sumlength)/18
                    sumlength -= (randomlength*18 + sumlength + 20 - height)
                }

                let main = SKNode()
                main.position = CGPointMake(5, sumlength + 15)

                var mainheight:CGFloat = 0.0
                
                for var k=0; k<Int(randomlength) ; k++ {
                
                    let leftedge = SKSpriteNode()
                    let i = arc4random()%3 + 1
                    let texture = SKTexture(imageNamed: "fence1\(i).png")
                
                    leftedge.texture = texture
                    leftedge.size = CGSizeMake(10, 20)
                    
                    leftedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(8, 20), center: CGPointMake(0, 0))
                    leftedge.physicsBody?.usesPreciseCollisionDetection = true
                    leftedge.physicsBody?.dynamic = false
                    leftedge.physicsBody?.categoryBitMask = BitMaskType.edge
                    leftedge.physicsBody?.restitution=1
                    
                    leftedge.position.y = mainheight - 1
                    main.addChild(leftedge)
                    mainheight += leftedge.size.height - 2
                    
                }
                isblock=false
                self.addChild(main)
                sumlength += randomlength*18
                
            }else{
                isblock=true
                
                var randomlength = (CGFloat(arc4random()) % abs(width / 60))*9 + 9
                
                if randomlength+sumlength>height-20{
                    randomlength = height - 20 - sumlength
                }
                
                sumlength += randomlength
            }
            
            
            
            
        }
        
    }
    
    func setbottom(){
        
        var sumlength:CGFloat = 0
        var isblock=true
        
        let num = arc4random()%2
        if num==0{
            isblock=true
        }else{
            isblock=false
        }
        while sumlength < width{
            
            if isblock{
                
                var randomlength = (CGFloat(arc4random()) % abs(width / 60)) + 2
                
                if randomlength*18+sumlength > width - 10{
                    randomlength = (width - 10 - sumlength)/18
                    sumlength -= (randomlength*18 + sumlength - width + 10)
                }
                
                let main = SKNode()
                main.position = CGPointMake(sumlength + 15, 5)
                var mainwidth:CGFloat = 0.0
                
                for var k=0 ; k < Int(randomlength) ; k++ {
                
                    let buttomedge = SKSpriteNode()
                    let i = arc4random()%3 + 1
                    let texture = SKTexture(imageNamed: "fence\(i).png")
                    
                    buttomedge.texture = texture
                    buttomedge.size = CGSizeMake(20, 10)
                   
                    buttomedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(20, 8), center: CGPointMake(0 , 0))
                    buttomedge.physicsBody?.usesPreciseCollisionDetection = true
                    buttomedge.physicsBody?.dynamic = false
                    buttomedge.physicsBody?.categoryBitMask = BitMaskType.edge
                    buttomedge.physicsBody?.restitution=1
                    
                    buttomedge.position.x = mainwidth - 1
                    main.addChild(buttomedge)
                    mainwidth += buttomedge.size.width - 2
                }
                    
                    
                isblock=false
                self.addChild(main)
                sumlength += randomlength * 18
                
            }else{
                isblock=true
                var randomlength = (CGFloat(arc4random()) % abs(width / 50))*9 + 9
                
                if randomlength+sumlength>width{
                    randomlength = width - sumlength
                }
                
                sumlength += randomlength
             
            }
            
            
        }
        
    }
    
    func setright(){
        
        var sumlength:CGFloat = 0
        var isblock=true
        let num = arc4random()%2
        if num==0{
            isblock=true
        }else{
            isblock=false
        }
        while sumlength < height-20{
            
            if isblock{
                
                var randomlength = (CGFloat(arc4random()) % abs(width / 60)) + 2
                
                
                if randomlength*18+sumlength > height-20{
                    randomlength = (height - 20 - sumlength)/18
                    sumlength -= (randomlength*18 + sumlength + 20 - height)
                }
                
                let main = SKNode()
                main.position = CGPointMake(width - 5, sumlength + 15)
                
                var mainheight:CGFloat = 0.0

                for var k=0; k<Int(randomlength) ; k++ {
                    
                    let rightedge = SKSpriteNode()
                    let i = arc4random()%3 + 1
                    let texture = SKTexture(imageNamed: "fence1\(i).png")
               
                    rightedge.texture = texture
                    rightedge.size = CGSizeMake(10, 20)
                    
                    rightedge.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(8, 20) , center: CGPointMake(0, 0))
                    rightedge.physicsBody?.usesPreciseCollisionDetection = true
                    rightedge.physicsBody?.dynamic = false
                    rightedge.physicsBody?.categoryBitMask = BitMaskType.edge
                  
                    rightedge.physicsBody?.restitution=1
                    
                    rightedge.position.y = mainheight - 1
                    main.addChild(rightedge)
                    mainheight += rightedge.size.height - 2
                }
                isblock=false
                self.addChild(main)
                sumlength += randomlength * 18
            }else{
                isblock=true
                
                var randomlength = (CGFloat(arc4random()) % abs(width / 50))*10 + 10
                
                if randomlength+sumlength>height-20{
                    randomlength = height - 20 - sumlength
                }
                sumlength += randomlength
                
            }
            
            
        }
        
    }
    
    //setblocker
    
    func setblocker(){
        
        if level<5{
            blockernumber = 3
            sticknumber=1
        }else if level<10{
            blockernumber = 4
            
            sticknumber=1
        }else if level<20{
            blockernumber = 4
            sticknumber=2
        }else{
            blockernumber = 5
            sticknumber = 2
        }
        
        let alertblock = SKLabelNode()
        
        alertblock.text = "本关有\(blockernumber)个球形和\(sticknumber)个条形障碍物"
        
        alertblock.position = CGPointMake(width/2, height-50)
        
        alertblock.fontSize = 14
        
        alertblock.fontColor = UIColor.blackColor()
        
        self.addChild(alertblock)
        
        var blockerexist=true
        var i = 0
        
        while i < blockernumber{
            i++
            
            let block = blocker()
            
            let randomsize = CGFloat(random()%24 - 12)
            
            let ballsize = width/5 + randomsize
            
            let x = (CGFloat(arc4random()) % (width-ballsize-10)) + (ballsize/2+5)
            let y = (CGFloat(arc4random()) % (height-ballsize-30)) + (ballsize/2+5)
            
            
            
            blockerexist = true
            
            for other in barrierarray{
                let dirX=Double(x - other.x)
                let dirY=Double(y - other.y)
                
                let dir=sqrt(dirX*dirX+dirY*dirY)
                if dir<Double(ballsize/2+other.ballsize/2){
                    blockerexist=false
                }
            }
            
            let dirXfromrock = Double(x - width/2)
            let dirYfromrock = Double(y - height/8)
            let dirfromrock = sqrt(dirXfromrock * dirXfromrock + dirYfromrock * dirYfromrock)
            
            if dirfromrock < Double(ballsize) + 20 {
                blockerexist=false
            }
            
            let dirXfromfin = Double(x - width/2)
            let dirYfromfin = Double(y - 9*height/10)
            let dirfromfin = sqrt(dirXfromfin * dirXfromfin + dirYfromfin * dirYfromfin)
            
            if dirfromfin < Double(ballsize){
                blockerexist=false
            }
            
            if blockerexist{
                barrierarray.append(block)
                
                block.setbarrier(ballsize , x:x , y:y )
                
                self.addChild(block)
                
            }else{
                blockernumber++
            }
            
            
        }
        
        i=0
        
        while i < sticknumber{
            i++
            
            blockerexist=true
            
            let wood = stick()
            
            
            let x = (CGFloat(arc4random()) % (width-110)) + (55)
            let y = (CGFloat(arc4random()) % (height-300)) + (145)
            
            
            let dirXfromrock = Double(x - width/2)
            let dirYfromrock = Double(y - height/8)
            let dirfromrock = sqrt(dirXfromrock * dirXfromrock + dirYfromrock * dirYfromrock)
            
            if dirfromrock < 50 {
                blockerexist=false
            }
            
            let dirXfromfin = Double(x - width/2)
            let dirYfromfin = Double(y - 9*height/10)
            let dirfromfin = sqrt(dirXfromfin * dirXfromfin + dirYfromfin * dirYfromfin)
            
            if dirfromfin < 50{
                blockerexist=false
            }
            
            
            if blockerexist{
                wood.setbarrier(0,x:x , y: y)
                
                self.addChild(wood)
                stickarray.append(wood)
                
            }else{
                sticknumber++
            }
            
        }
   
        
    }
    
    //showb&s
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.block|BitMaskType.rock){
            print("crash")
            
            
            let a = contact.bodyA.node as! blocker
            //let b = contact.bodyB.node as! Rock
            
            
            //music.playhit(b)
            
            a.show()
       
        }
        
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.stick|BitMaskType.rock){
            
            print("crash")
            let a = contact.bodyA.node as! stick
            //let b = contact.bodyB.node as! Rock
            
            
            //music.playhit(b)
            
            a.show()
        }
        
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.edge|BitMaskType.rock){
            
            print("crashwall")
            
            let b = contact.bodyB.node as! Rock
            
            
            //music.playhit(b)
            
        }
        
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.people|BitMaskType.block)||(contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.people|BitMaskType.edge)||(contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask)==(BitMaskType.people|BitMaskType.stick){
            
            peopleable=false
            
            
            showpeople()
            
            restart()
            
            music.playfailed()
            
            restlife--
            
            print("badcrash")
        }
        
    }
    
   
    
    
    func showpeople(){
        
        for barrier in barrierarray{
            
            barrier.show()
            
        }
        for sti in stickarray{
            sti.show()
        }
        
    }
    
    //touch
    
    var beginlocation:CGPoint = CGPointMake(0, 0)
    var lastlocation:CGPoint = CGPointMake(0, 0)
    var endlocation:CGPoint = CGPointMake(0, 0)
    var disrock=false
    var distouch=false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
        for touch in (touches ){
        
            beginlocation = touch.locationInNode(self)
            
        }

        lastlocation = beginlocation
        
        if !nextlevel && !stop{
        
            if `throw` == Throw.rock{
                if !disrock{
                    rockarray.last!.position = CGPointMake(width/2, height/8)
                    rockarray.last!.physicsBody?.velocity = CGVectorMake(0, 0)
                    //moveline()
                }else{
                    distouch=true
                }
            }else{
                
                people.peoplecrash()
                
                
            }
        }
        
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var presentlocation:CGPoint = CGPoint(x: 0,y: 0)
        
        
        
        for touch in (touches ){
                presentlocation = touch.locationInNode(self)
            }

        if `throw` == Throw.rock && !stop{
            
            if !distouch{
            var dirX = CGFloat(beginlocation.x-presentlocation.x)
            var dirY = CGFloat(beginlocation.y-presentlocation.y)
            
            dirX /= 4
            dirY /= 4
            
                let dis = sqrt(dirX*dirX+dirY*dirY)
                
                if dis>20{
                    dirX *= 20/dis
                    dirY *= 20/dis
                }
                
                
            rockarray.last?.position = CGPointMake(width/2 - dirX, height/8 - dirY)
               
               
                if pointarray.isEmpty{
                
                    for i in 1...15 {
                    
                     
                    let x = width/2 - dirX + CGFloat(i)*dirX*1.8
                     let y = height/8 - dirY + CGFloat(i)*dirY*1.8
                    
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
                        
                        let x = width/2 - dirX + CGFloat(i)*dirX*1.8
                        let y = height/8 - dirY + CGFloat(i)*dirY*1.8
                        
                        
                        pointarray[i-1].runAction(SKAction.moveTo(CGPointMake(x, y), duration: 0))
                        
                    }

                }
            }
            
            
            
            
            
        }
        
        
        if !nextlevel && !stop{
        if peopleable{
            
            let x = CGFloat(presentlocation.x-lastlocation.x)
            let y = CGFloat(presentlocation.y-lastlocation.y)
            
            print([x,y])
            
                        
            people.runAction(SKAction.moveByX(x, y: y, duration: 0))
            
            if people.position.y<40{
                people.position.y = 40
            }
            
            let dirX=Double(people.position.x - finish.position.x)
            let dirY=Double(people.position.y - finish.position.y)
            
            let dir=sqrt(dirX*dirX+dirY*dirY)
            
            if dir<29{
                restart()
                
                music.playnextlvl()
                
                
                
            }
            
            }
        }
        lastlocation = presentlocation
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
      

        for touch in (touches ){
            
            endlocation = touch.locationInNode(self)
            
        }
        
        if `throw` == Throw.rock && !stop{
            if !distouch{
                if !peopleable{
                let dirX=Double(beginlocation.x - endlocation.x)
                let dirY=Double(beginlocation.y - endlocation.y)
                
                let dir=sqrt(dirX*dirX+dirY*dirY)
                
                if dir>20{
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
        
        if restrock==0{
            buttonhid=true
        }
        
    }
    
    
    
    func newrock(){
        let rock1 = Rock()
        rock1.setrock()
        rockarray.append(rock1)
        disrock=false
        self.addChild(rock1)
        rock1.inarray = rockarray.count-1
        
        `throw` = Throw.rock
        
    }
    
    func newpeople(){
        
        people.setpeople()
        peopleable=true
        self.addChild(people)
        
        `throw` = Throw.people
        
        buttonhid = true
        
    }
    
    func restart(){
        nextlevel=true
        save()
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
            
                
                restart()
                
                showpeople()
                
                restlife--
                
                music.playfailed()
                
                
                
                }
            }
        }
        
        people.physicsBody?.velocity = CGVectorMake(0, 0)
        
        if go{
            
            print(rockarray.count)

            rockarray.last?.removeFromParent()
                        
            
            newpeople()
            go=false
        }
        
        
    }
    
    
    
    
}

func nextdata(){
    if again==true{
        
        again=false
        
        restlife = 3
        
        die = false
        
        level = 0
        
        restrock = 0
    }
    
    level++
    restrock += 3
    
    if level>bestlevel{
        bestlevel = level
    }
  
    
}



