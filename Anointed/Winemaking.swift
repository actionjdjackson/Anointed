//
//  Winemaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Winemaking : Skill {
    
    init( user : GameCharacter ) {
        super.init( skillName: "Winemaking", skillDesc: "Allows you to turn water into wine", skillUser: user, skillSprite : "wineskin", baseTimeToComplete : 0.125 )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use() {
        
        //if you have all the raw materials necessary,
        if user.howManyInInventory("Water") > 0 {
            
            //make a tent
            user.grabFromInventory("Water")
            var newWineskin = Item(ttl: "Wineskin", desc: "A wineskin filled with wine", sx: 1, sy: 1, iconName: "wineskin")
            user.inventory.append(newWineskin)
            //level up tentmaking skill
            level++
            //report to console
            println("Made some miraculous, great-tasting wine!")
            println("Winemaking +1")
            
        } else {
            
            println("Not enough resources to make wine. Sorry.")
            
        }
        
    }
    
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Water") > 0 {
            
            return true
            
        } else {
            
            println("Not enough resources to make wine. Sorry.")
            return false
            
        }
        
    }
    
}