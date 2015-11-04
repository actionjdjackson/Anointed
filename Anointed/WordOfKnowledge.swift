//
//  WordOfKnowledge.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class WordOfKnowledge : Skill {
    
    /* SET UP WORD OF KNOWLEDGE SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Word of Knowledge", skillDesc: "Allows you to give a special message of supernatural knowledge.", skillUser: user, skillSprite : "wordOfKnowledge", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE WORD OF KNOWLEDGE SKILL ON SELF */
    override func use() {
        //give word of knowledge
        UNIVERSE.alertText("Speaking a word of knowledge to self...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("Gave word of knowledge to self")
        UNIVERSE.alertText("Word of Knowledge +1")
    }
    
    /* USE WORD OF KNOWLEDGE SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //give word of knowledge
        UNIVERSE.alertText("Speaking a word of knowledge to npc...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("Gave word of knowledge to npc")
        UNIVERSE.alertText("Word of Knowledge +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}