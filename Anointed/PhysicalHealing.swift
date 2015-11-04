//
//  PhysicalHealing.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/29/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class PhysicalHealing: Skill {
    
    /* SETS UP PHYSICAL HEALING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Physical Healing", skillDesc: "Allows you to physically heal a target, or yourself.", skillUser: user, skillSprite : "physicalHealing", baseTimeToComplete : 1, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* FOR NORMAL USE (ON SELF, USUALLY) */
    override func use() {
        
        user.physicalHealth = 100   //heal self
        level++ //level up skill
        self.toolTipSN.itemInfoA = "Level " + String( level )   //update tooltip info
        self.toolTipSN.itemInfoB = "Time to Complete: " //update tooltip info
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"   //update ttip
        UNIVERSE.alertText("Healed self")
        UNIVERSE.alertText("Physical Healing +1")
        
    }
    
    /* FOR USE ON AN NPC */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //heal the target
        npc.physicalHealth = 100
        //level up the skill
        level++
        self.toolTipSN.itemInfoA = "Level " + String( level )   //update tooltip info
        self.toolTipSN.itemInfoB = "Time to Complete: "   //update tooltip info
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"   //update ttip
        //report to console
        UNIVERSE.alertText("Healed an NPC")
        UNIVERSE.alertText("Physical Healing +1")
        
    }
    
    /* FOR USE ON AN ANIMAL */
    override func useOnAnimal(animal: Animal) {
        
        //heal the target
        animal.physicalHealth = 100
        //level up the skill
        level++
        self.toolTipSN.itemInfoA = "Level " + String( level )   //update tooltip info
        self.toolTipSN.itemInfoB = "Time to Complete: "   //update tooltip info
        self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"   //update ttip
        //report to console
        UNIVERSE.alertText("Healed an animal")
        UNIVERSE.alertText("Physical Healing +1")
        
    }
    
    /* CAN WE USE THE SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true //no reason to not be able to use this skill for now
        
    }
    
}