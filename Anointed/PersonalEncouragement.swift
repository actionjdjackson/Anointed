//
//  PersonalEncouragement.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class PersonalEncouragement : Skill {
    
    /* SET UP PERSONAL ENCOURAGEMENT SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Personal Encouragement", skillDesc: "Allows you to encourage another believer in their faith and life.", skillUser: user, skillSprite : "personalEncouragement", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE PERSONAL PROPHECY SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //encourage
        UNIVERSE.alertText("Encouraging...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("Encouraged npc")
        UNIVERSE.alertText("Personal Encouragement +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}