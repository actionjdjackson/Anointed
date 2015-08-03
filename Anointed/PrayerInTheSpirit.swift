//
//  PrayerInTheSpirit.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class PrayerInTheSpirit : Skill {
    
    /* SET UP PERSONAL PROPHECY SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Prayer in the Spirit", skillDesc: "Allows you to pray in a personal prayer language.", skillUser: user, skillSprite : "prayerInTheSpirit", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE PRAYER IN THE SPIRIT SKILL ON NPC */
    override func use() {
        //prophesy
        println("Praying in the spirit...")
        //level up
        level++
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
        //report to console
        println("Prayed in the Spirit")
        println("Prayer in the Spirit +1")
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}