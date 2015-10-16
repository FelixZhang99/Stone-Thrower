//
//  music.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/24.
//  Copyright © 2015年 Zhangfutian. All rights reserved.
//
import AVFoundation
import AudioToolbox

import SpriteKit


class MusicManager:SKNode{
    
    var audioplayer:AVAudioPlayer!
    
    let winAct = SKAction.playSoundFileNamed("nextlevel.mp3", waitForCompletion: false)
    
    let loseAct = SKAction.playSoundFileNamed("failed.wav", waitForCompletion: false)
    
    func playhit(rock: Rock){
        if musicon{
        var i = UInt32()
        
        i = arc4random()%3 + 1
        
        let path = NSBundle.mainBundle().pathForResource("hit\(i)", ofType: "wav")
        
        let baseURL = NSURL(fileURLWithPath: path!)
        
      
        
        do{
            try! audioplayer = AVAudioPlayer(contentsOfURL: baseURL)
        }
        
        let stress = (rock.physicsBody?.velocity.dx)! + (rock.physicsBody?.velocity.dy)!
        
        audioplayer.volume = Float(stress/1000)
        
        audioplayer.play()
        }
        
    }
    
    func playnextlvl(){
        if musicon{
        self.runAction(winAct)
        }
    }
    
    func playfailed(){
        if musicon{
        self.runAction(loseAct)
        }
    }
    
    
    
}
