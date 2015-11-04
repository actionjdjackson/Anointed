//
//  WordOfWisdom.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class WordOfWisdom : Skill {
    
    /* SET UP WORD OF WISDOM SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Word of Wisdom", skillDesc: "Allows you to give a special message of supernatural wisdom.", skillUser: user, skillSprite : "wordOfWisdom", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE WORD OF WISDOM SKILL ON SELF */
    override func use() {
        //give word of knowledge
        UNIVERSE.alertText("Speaking a word of wisdom to self...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("Gave word of wisdom to self")
        UNIVERSE.alertText("Word of Wisdom +1")
    }
    
    /* USE WORD OF WISDOM SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //give word of knowledge
        UNIVERSE.alertText("Speaking a word of wisdom to npc...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        UNIVERSE.alertText("Gave word of wisdom to npc")
        UNIVERSE.alertText("Word of Wisdom +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}