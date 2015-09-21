//
//  OneOnOneTeaching.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class OneOnOneTeaching : Skill {
    
    /* SET UP ONE-ON-ONE TEACHING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "One-On-One Teaching", skillDesc: "Allows you to teach another character from the scriptures.", skillUser: user, skillSprite : "oneOnOneTeaching", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE ONE-ON-ONE TEACHING SKILL ON NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //teach
        print("Teaching...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        print("Taught npc")
        print("One-On-One Teaching +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}