//
//  Hospitality.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Hospitality : Skill {
    
    /* SET UP HOSPITALITY SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Hospitality", skillDesc: "Allows you to invite people into your home and serve them food, entertain, and have meaningful conversation, possibly leading to a presentation of the Gospel.", skillUser: user, skillSprite : "hospitality", baseTimeToComplete : 6, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE HOSPITALITY SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //give food
        UNIVERSE.alertText("Inviting them over for dinner...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("Was hospitable")
        UNIVERSE.alertText("Hospitality +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}