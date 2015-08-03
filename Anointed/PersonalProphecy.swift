//
//  PersonalProphecy.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class PersonalProphecy : Skill {
    
    /* SET UP PERSONAL PROPHECY SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Personal Prophecy", skillDesc: "Allows you to give a personal prophecy to another game character.", skillUser: user, skillSprite : "personalProphecy", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE PERSONAL PROPHECY SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //prophesy
        println("Prophesying...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        println("Gave personal prophecy to npc")
        println("Personal Prophecy +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}