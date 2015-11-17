//
//  Fishing.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Fishing : Skill {
    
    /* SETS UP FISHING SKILL */
    init( user : GameCharacter, subsk: [Subskill] ) {
        super.init( skillName: "Fishing", skillDesc: "Allows you to go into shallow water and fish using a net.", skillUser: user, skillSprite : "fishing", baseTimeToComplete : 10.0, passv: false, subsk: subsk )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use() {
        
        if canUse() {
            
            //fishing stuff here
            
        } else {
            
            //nope, can't go fishing
            
        }
        
    }
    
    override func canUse() -> Bool {
        
        var missingBoatFlag : Bool = true
        for item in UNIVERSE.theGame.player.inventory {
            if item.name!.hasSuffix("Boat") {
                missingBoatFlag = false
                UNIVERSE.alertText("You can't go fishing without a boat!")
                break
            }
        }
        
        return !missingBoatFlag
        
    }
    
}