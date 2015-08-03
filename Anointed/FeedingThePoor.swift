//
//  FeedingThePoor.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class FeedingThePoor : Skill {
    
    /* SET UP FEEDING THE POOR SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Feeding the Poor", skillDesc: "Allows you to obtain and give out food to the poor.", skillUser: user, skillSprite : "feedingThePoor", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE CHEERFUL GIVING SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //give food
        println("Feeding the poor...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        println("Fed NPC")
        println("Feeding the Poor +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}