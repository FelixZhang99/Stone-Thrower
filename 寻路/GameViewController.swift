//
//  GameViewController.swift
//  寻路
//
//  Created by Zhangfutian on 15/8/25.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//

import UIKit
import SpriteKit

var width:CGFloat=0
var height:CGFloat=0
var nextlevel=false
var level=1
var go=false
var stop=false
var bestlevel=1

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    let viewTransitionDelegate = TransitionDelegate()

    var scenearray : [GameScene] = []
    
    var again=false
    
    @IBOutlet var button:UIButton!
    
    @IBAction func dismiss(){
    
        
        self.viewDidLoad()

        
    }
    
    var rest = UILabel()
    
    var levellabel = UILabel()
    
    var gobutton = UIButton()
    
    var pausebut = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
        
        width=self.view.bounds.width
        height=self.view.bounds.height
        
        go=false
        
        setlife()
        
        buttonhid=false
        
        go=false
       
        nextlevel=false
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
            scene.alpha = 0
            
           
            scene.alpha = 1
            
            
            
        }
        
        gobutton.frame = CGRectMake(width - 60, height - 60, 40, 40)
        gobutton.setImage(UIImage(named: "buttom.tif"), forState: .Normal)
        gobutton.addTarget(self, action: Selector("gopeople"), forControlEvents: UIControlEvents.TouchUpInside)
        gobutton.alpha = 1
        self.view.addSubview(gobutton)
        
        button.alpha = 0
        button.center = self.view.center
        button.enabled = false
        button.setTitle("next", forState: .Normal)
        
        pausebut.frame = CGRectMake(width - 60, 40 , 45, 30)
        pausebut.setImage(UIImage(named: "stop.tif"), forState: .Normal)
        pausebut.addTarget(self, action: Selector("suspend"), forControlEvents: UIControlEvents.TouchUpInside)
        pausebut.alpha = 1
        self.view.addSubview(pausebut)
        
        save()
        
    }
    
    func gopeople(){
        go=true
        
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.gobutton.alpha = 0
                }) { (finished:Bool) -> Void in
                    self.gobutton.removeFromSuperview()
            }
        
        
    }
    
    
    
    var continuegame:UIButton!
    var restart:UIButton!
    var help:UIButton!
    
    
    
    func suspend(){
        
        stop = true
        
        gobutton.enabled = false
        
        pausebut.enabled = false
        
        continuegame = mybutton("继续游戏", y: height/2-45)
        
        restart = mybutton("重新开始", y: height/2)
        
        help = mybutton("帮助", y: height/2+45)
        
        continuegame.addTarget(self, action: Selector("cg"), forControlEvents: UIControlEvents.TouchUpInside)
        
        restart.addTarget(self, action: Selector("replay"), forControlEvents: UIControlEvents.TouchUpInside)
        
        help.addTarget(self, action: Selector("gohelp"), forControlEvents: UIControlEvents.TouchUpInside)
        
       
    }
    
    
    func mybutton(txt:String,y:CGFloat)-> UIButton{
        var button : UIButton = UIButton(type: UIButtonType.System)
        
        button.frame = CGRectMake(width, y, 120, 40)
        
        button.setTitle(txt, forState: .Normal)
        
        button.backgroundColor = UIColor.brownColor()
        
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(20, weight: 4)
        
        button.layer.cornerRadius = 10
        
        self.view.addSubview(button)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            button.transform = CGAffineTransformMakeTranslation( -(width/2)-60 , 0)
        })
        return button
    }
    
    func cg(){
        
        continuegame.removeFromSuperview()
        
        restart.removeFromSuperview()
        
        help.removeFromSuperview()
        
        stop=false
     
        gobutton.enabled = true
        
        pausebut.enabled = true
    }
    
    func replay(){
        level = 1
        
        restlife = 3
        
        restrock = 0
        
        self.viewDidLoad()
        
        cg()
        
        stop = false
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if nextlevel{
           
                       
            rest.text = "*\(restlife)"
            
            if die==true{
                
                button.setTitle("again", forState: .Normal)
                
                again=true
            }
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.button.alpha=1
                self.button.enabled = true
                }, completion: nil)
            
            if self.again==true{
                self.again=false
                
                restlife = 3
                
                die = false
                
                level = 0
                
                
            }
            restrock += 3
            level++
            
            if level>bestlevel{
                bestlevel = level
            }
            
            save()
            
            
            
        }
        if buttonhid{
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.gobutton.alpha = 0
                }) { (finished:Bool) -> Void in
                    self.gobutton.removeFromSuperview()
            }
        }
        
    }
    
    func setlife(){
        let life = UIImageView(image: UIImage(named: "life.tif"))
        
        life.frame = CGRectMake(4, 4, 15, 12)
        
        self.view.addSubview(life)
        
        rest.frame = CGRectMake(22, 4, 30, 12)
        
        rest.text = "*\(restlife)"
        
        rest.font = UIFont.systemFontOfSize(17, weight: 2.5)
        
        self.view.addSubview(rest)
        
        levellabel.text = "Level:\(level)"
        
        levellabel.frame = CGRectMake(width/2-50, 4 , 100, 12)
        
        levellabel.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(levellabel)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    




}
