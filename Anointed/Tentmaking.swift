
//
//  Tentmaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/8/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Tentmaking : Skill {
    
    /* SETS UP TENTMAKING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Tentmaking", skillDesc: "Allows you to make tents, using one unit of cloth, one unit of cord, and one unit of wood.", skillUser: user, skillSprite : "tentmaking", baseTimeToComplete : 10.0, passv: false )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE TENTMAKING SKILL ON SELF (TENT GOES INTO INVENTORY) */
    override func use() {
    
        //if you have all the raw materials necessary,
        if user.howManyInInventory("Cloth") > 0 && user.howManyInInventory("Cord") > 0 && user.howManyInInventory("Wood") > 0 {
            
            //make a tent
            user.grabFromInventory("Cloth")
            user.grabFromInventory("Cord")
            user.grabFromInventory("Wood")
            let newTent = Item(ttl: "Tent", desc: "A basic cloth tent.", sx: 1, sy: 1, spriteName: "tent")
            user.inventory.append(newTent)
            //level up tentmaking skill
            level++
            //set new hours to complete value
            hoursToComplete = round((self.baseHoursToComplete - log(Double(self.level))) * self.baseHoursToComplete / 10.0)
            //update tooltip info
            self.toolTipSN.itemInfoA = "Level " + String( level )
            self.toolTipSN.itemInfoB = "Time to Complete: "
            self.toolTipSN.itemInfoB += String(hoursToComplete) + "hrs"
            //report to console
            UNIVERSE.alertText("Made a basic cloth tent.")
            UNIVERSE.alertText("Tentmaking +1")
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tent. Sorry.")  //UNIVERSE.alertText no can do
            
        }
    
    }
    
    /* USE TENTMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if user.howManyInInventory("Cloth") > 0 && user.howManyInInventory("Cord") > 0 && user.howManyInInventory("Wood") > 0 {
            
            //make a tent
            user.grabFromInventory("Cloth")
            user.grabFromInventory("Cord")
            user.grabFromInventory("Wood")
            let newTent = Item(ttl: "Tent", desc: "A basic cloth tent.", sx: 1, sy: 1, spriteName: "tent")
            npc.inventory.append(newTent)
            //level up tentmaking skill
            level++
            //set new hours to complete value
            hoursToComplete = round((self.baseHoursToComplete - log(Double(self.level))) * self.baseHoursToComplete / 10.0)
            //update tooltip info
            self.toolTipSN.itemInfoA = "Level " + String( level )
            self.toolTipSN.itemInfoB = "Time to Complete: "
            self.toolTipSN.itemInfoB += String(hoursToComplete) + "hrs"
            //report to console
            UNIVERSE.alertText("Made a basic cloth tent.")
            UNIVERSE.alertText("Tentmaking +1")
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tent. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    /* CAN WE USE THE TENTMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cloth") > 0 && user.howManyInInventory("Cord") > 0 && user.howManyInInventory("Wood") > 0 { //if we've got enough stuff
         
            return true //then we can use the tentmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }

}