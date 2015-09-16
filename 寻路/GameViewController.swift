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

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
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
    
        
        if again==true{
            again=false
            
            restlife = 3
            
            die = false
            
            level = 0
            
        }
        
        level++
        
        self.viewDidLoad()

        
    }
    
    var rest = UILabel()
    
    var levellabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        width=self.view.bounds.width
        height=self.view.bounds.height
        
        
        setlife()
        
       
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
        
        button.alpha = 0
        button.center = self.view.center
        button.enabled = false
        button.setTitle("next", forState: .Normal)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
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

    override func supportedInterfaceOrientations() -> Int {
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
