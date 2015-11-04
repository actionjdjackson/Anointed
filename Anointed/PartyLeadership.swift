//
//  PartyLeadership.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class PartyLeadership : Skill {
    
    /* SET UP CHEERFUL GIVING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Party Leadership", skillDesc: "Allows you to lead a party of believers on quests or missionary journeys", skillUser: user, skillSprite : "partyLeadership", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE PARTY LEADERSHIP SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //give
        UNIVERSE.alertText("Leading/Organizing...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("NPC is now a part of your party.")
        UNIVERSE.alertText("Party Leadership +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}