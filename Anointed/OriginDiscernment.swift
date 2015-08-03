//
//  OriginDiscernment.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class OriginDiscernment : Skill {
    
    /* SET UP ORIGIN DISCERNMENT SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Origin Discernment", skillDesc: "Allows you to discern wether or not a spirit is from God or from Satan.", skillUser: user, skillSprite : "originDiscernment", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE ORIGIN DISCERNMENT SKILL ON PERSONAL SITUATION */
    override func use() {
        //give word of knowledge
        println("Discerning origin of spirit encountered...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        println("Discerned spirit in personal situation")
        println("Origin Discernment +1")
    }
    
    /* USE ORIGIN DISCERNMENT SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //give word of knowledge
        println("Discerning origin of spirit encountered in NPC's situation...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        println("Discerned spirit in NPC's situation")
        println("Origin Discernment +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}