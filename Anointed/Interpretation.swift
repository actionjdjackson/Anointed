//
//  Interpretation.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Interpretation : Skill {
    
    /* SET UP PERSONAL PROPHECY SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Interpretation", skillDesc: "Allows you to interpret tongues spoken by another character.", skillUser: user, skillSprite : "interpretation", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE INTERPRETATION SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //interpretation
        println("Interpreting...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        println("Interpreted message from NPC")
        println("Interpretation +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}