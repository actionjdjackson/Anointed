//
//  Winemaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Winemaking : Skill {
    
    /* SET UP WINEMAKING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Winemaking", skillDesc: "Allows you to turn water into wine", skillUser: user, skillSprite : "winemaking", baseTimeToComplete : 1, passv: false, subsk: [] )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE WINEMAKING SKILL NORMALLY (ON SELF, WINESKIN GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make into wine
            playSound("Winemaking.mp3")
            user.grabFromInventory("Water")
            let newWineskin = Item(ttl: "Wineskin", desc: "A wineskin filled with wine", sx: 1, sy: 1, spriteName: "wineskin")
            user.inventory.append(newWineskin)
            //level up
            level++
            //update tooltip info
            self.toolTipSN.itemInfoA = "Level " + String( level )
            self.toolTipSN.itemInfoB = "Time to Complete: "
            self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
            //report to console
            UNIVERSE.alertText("Made some miraculous, great-tasting wine!")
            UNIVERSE.alertText("Winemaking +1")
            
        } else {    //if we don't
            
            UNIVERSE.alertText("Not enough resources to make wine. Sorry.")    //it's a no-go
            
        }
        
    }
    
    /* USE WINEMAKING SKILL ON NPC (WINESKIN GOES IN NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        //if you have all the raw materials necessary,
        if user.howManyInInventory("Water") > 0 {
            
            //make a wineskin
            playSound("Winemaking.mp3")
            user.grabFromInventory("Water")
            let newWineskin = Item(ttl: "Wineskin", desc: "A wineskin filled with wine", sx: 1, sy: 1, spriteName: "wineskin")
            npc.inventory.append(newWineskin)
            //level up
            level++
            //update tooltip info
            self.toolTipSN.itemInfoA = "Level " + String( level )
            self.toolTipSN.itemInfoB = "Time to Complete: "
            self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
            //report to console
            UNIVERSE.alertText("Made some miraculous, great-tasting wine!")
            UNIVERSE.alertText("Winemaking +1")
            
        } else {    //if we don't
            
            UNIVERSE.alertText("Not enough resources to make wine. Sorry.")    //it's a no-go
            
        }
    }
    
    override func useOnAnimal(animal: Animal) {
        //if you have all the raw materials necessary,
        if user.howManyInInventory("Water") > 0 {
            
            //make a wineskin
            playSound("Winemaking.mp3")
            user.grabFromInventory("Water")
            //level up
            level++
            //update tooltip info
            self.toolTipSN.itemInfoA = "Level " + String( level )
            self.toolTipSN.itemInfoB = "Time to Complete: "
            self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
            //report to console
            UNIVERSE.alertText("Fed wine to " + animal.name! + ".")
            UNIVERSE.alertText("Winemaking +1")
            
        } else {    //if we don't
            
            UNIVERSE.alertText("Not enough resources to make wine. Sorry.")    //it's a no-go
            
        }
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Water") > 0 {   //if we have some water
            
            return true //we can use the skill
            
        } else {    //if we don't,
            
            UNIVERSE.alertText("Not enough resources to make wine. Sorry.")
            return false    //we can't use the skill
            
        }
        
    }
    
}