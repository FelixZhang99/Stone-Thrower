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
var again=false

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
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

    

    var scenearray : [GameScene] = []
    
    
    
    @IBOutlet var button:UIButton!
    
    @IBAction func dismiss(){
    
    
        
        button.enabled = false
        
        nextdata()
        
        self.viewDidLoad()

        
        
        
        
        
    }
    
    var rest = UILabel()
    
    var levellabel = UILabel()
    
    var bestlabel = UILabel()
    
    var gobutton = UIButton()
    
    var pausebut = UIButton()
    
    var storebut = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
        
        if restlife<1{
            restlife=3
            restrock=3
            level=1
            save()
        }
        
        
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
        button.setTitle("下一关", forState: .Normal)
        button.titleLabel?.textColor = UIColor.blackColor()
        
        pausebut.frame = CGRectMake(width - 60, 40 , 45, 30)
        pausebut.setImage(UIImage(named: "stop.tif"), forState: .Normal)
        pausebut.addTarget(self, action: Selector("suspend"), forControlEvents: UIControlEvents.TouchUpInside)
        pausebut.alpha = 1
        self.view.addSubview(pausebut)
        
        storebut.frame = CGRectMake(24, 45, 30, 30)
        storebut.setImage(UIImage(named: "store.png"), forState: .Normal)
        storebut.addTarget(self, action: Selector("store"), forControlEvents: UIControlEvents.TouchUpInside)
        storebut.alpha = 1
        
        self.view.addSubview(storebut)
        
        save()
        
    }
    
    func gopeople(){
        if restrock>0{
            go=true
        }
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.gobutton.alpha = 0
                }) { (finished:Bool) -> Void in
                    self.gobutton.removeFromSuperview()
            }
        
        
    }
    
    func store(){
        
        
        let storeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("store")
        
        self.presentViewController(storeViewController, animated: false, completion: nil)
        
        
        
    }
    
    
    var continuegame:UIButton!
    var restart:UIButton!
    var setting:UIButton!
    var help:UIButton!
    
    
    
    func suspend(){
        
        stop = true
        
        gobutton.enabled = false
        
        pausebut.enabled = false
        
        continuegame = mybutton("继续游戏", y: height/2-90)
        
        restart = mybutton("重新开始", y: height/2-45)
        
        setting = mybutton("设置", y: height/2)
        
        help = mybutton("帮助", y: height/2+45)
        
        continuegame.addTarget(self, action: Selector("cg"), forControlEvents: UIControlEvents.TouchUpInside)
        
        restart.addTarget(self, action: Selector("replay"), forControlEvents: UIControlEvents.TouchUpInside)
        
        setting.addTarget(self, action: Selector("set"), forControlEvents: UIControlEvents.TouchUpInside)
        
        help.addTarget(self, action: Selector("gohelp"), forControlEvents: UIControlEvents.TouchUpInside)
        
       
    }
    
    
    func mybutton(txt:String,y:CGFloat)-> UIButton{
        let button : UIButton = UIButton(type: UIButtonType.System)
        
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
        
        setting.removeFromSuperview()
        
        help.removeFromSuperview()
        
        stop=false
     
        gobutton.enabled = true
        
        pausebut.enabled = true
    }
    
    func replay(){
        level = 1
        
        restlife = 3
        
        restrock = 3
        
        cg()
        
        stop = false
        
        again=false
        
        die = false
        
        save()
        self.viewDidLoad()
       
    }
    
    func set(){
        
        let setViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("setting")
        
        self.presentViewController(setViewController, animated: false, completion: nil)
        
        
    }
    
    
    func gohelp(){
        
        let helpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("help")
        
        self.presentViewController(helpViewController, animated: false, completion: nil)
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if nextlevel{
           
                       
            rest.text = "*\(restlife)"
            
            if restlife==0{
                
                button.setTitle("重新开始", forState: .Normal)
                
                again=true
            }
            
            if self.button.alpha==0{
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.button.alpha=1
                self.button.enabled = true
                }, completion: nil)
           
               
               
                
                save()
                
            }
            
            
            
            
            
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
        
        bestlabel.text = "Best:\(bestlevel)"
        
        bestlabel.frame = CGRectMake(width-80, 4, 80, 12)
        
        bestlabel.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(bestlabel)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
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
