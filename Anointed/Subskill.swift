//
//  Subskill.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/9/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Subskill : Skill {
    
    var levelRequired : Int = 1
    
    init( skillName : String, skillDesc : String, skillUser : GameCharacter, skillSprite : String, baseTimeToComplete : Double, level : Int) {
     
        super.init(skillName: skillName, skillDesc: skillDesc, skillUser: skillUser, skillSprite: skillSprite, baseTimeToComplete: baseTimeToComplete, passv: false, subsk: [])
        levelRequired = level
        
    }
    
    func levelUp() {
        
        //level up
        self.level++
        //set new hours to complete value
        self.hoursToComplete = round((self.baseHoursToComplete - log(Double(self.level))) * self.baseHoursToComplete / 10.0)
        //update tooltip info
        self.toolTipSN.itemInfoA = "Level " + String( self.level )
        self.toolTipSN.itemInfoB = "Time to Complete: "
        self.toolTipSN.itemInfoB += String(self.hoursToComplete) + "hrs"
        UNIVERSE.alertText( self.name! + " +1")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}