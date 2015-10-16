//
//  save.swift
//  寻路
//
//  Created by Zhangfutian on 15/9/18.
//  Copyright (c) 2015年 Zhangfutian. All rights reserved.
//

import Foundation


let filemanager = NSFileManager.defaultManager()

let Documenturl = filemanager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)

let url = Documenturl[0] 

var error:NSError?

let file = url.URLByAppendingPathComponent("save level.plist")

func save(){
    
    var array : NSArray = NSArray(objects: level , restlife , restrock , bestlevel)
    
    if die{
        array = NSArray(objects: 1,3,3 , bestlevel)
    }
    
      
    array.writeToURL(file, atomically: true)

    
    
}

func load(){
    
    let exist = filemanager.fileExistsAtPath(file.path!)
    
    if !exist{
        let nsarray : NSArray = [1,3,3,bestlevel]
        
        nsarray.writeToURL(file, atomically: true)
        
    }
    
    let array: NSArray = NSArray(contentsOfURL: file)!
    
    let number = (array.firstObject) as! NSNumber
    
    let number2 = (array[1]) as! NSNumber
    
    let number3 = (array[2]) as! NSNumber
    
    let number4 = (array[3]) as! NSNumber
    
    level = number.integerValue
    
    restlife = number2.integerValue
    
    restrock = number3.integerValue
    
    bestlevel = number4.integerValue
    
}

