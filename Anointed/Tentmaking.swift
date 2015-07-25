
//
//  Tentmaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/8/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Tentmaking : Skill {
    
    init( user : GameCharacter ) {
        super.init( skillName: "Tentmaking", skillDesc: "Allows you to make tents, using one unit of cloth, one unit of cord, and one unit of wood.", skillUser: user, skillSprite : "tent", baseTimeToComplete : 10.0 )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use() {
    
        //if you have all the raw materials necessary,
        if user.howManyInInventory("Cloth") > 0 && user.howManyInInventory("Cord") > 0 && user.howManyInInventory("Wood") > 0 {
            
            //make a tent
            user.grabFromInventory("Cloth")
            user.grabFromInventory("Cord")
            user.grabFromInventory("Wood")
            var newTent = Item(ttl: "Tent", desc: "A basic cloth tent.", sx: 1, sy: 1, iconName: "tent")
            user.inventory.append(newTent)
            //level up tentmaking skill
            level++
            //report to console
            println("Made a basic cloth tent.")
            println("Tentmaking +1")
            
        } else {
            
            println("Not enough resources to make a tent. Sorry.")
            
        }
    
    }
    
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cloth") > 0 && user.howManyInInventory("Cord") > 0 && user.howManyInInventory("Wood") > 0 {
         
            return true
            
        } else {
            
            return false
            
        }
        
    }

}