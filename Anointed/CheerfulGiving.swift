//
//  CheerfulGiving.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class CheerfulGiving : Skill {
    
    /* SET UP CHEERFUL GIVING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Cheerful Giving", skillDesc: "Allows you to give special gifts to others with cheerfulness.", skillUser: user, skillSprite : "cheerfulGiving", baseTimeToComplete : 0.125, passv: false, subsk: [] )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE CHEERFUL GIVING SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //give
        UNIVERSE.alertText("Giving...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("Gave gift to NPC")
        UNIVERSE.alertText("Cheerful Giving +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}