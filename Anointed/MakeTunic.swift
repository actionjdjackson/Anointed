//
//  MakeTunic.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/17/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeTunic : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Tunic", skillDesc: "Make a small, cloth tunic.", skillUser: user, skillSprite: "tunic", baseTimeToComplete: 2, level: 1)
        
    }
    
    /* USE TUNICMAKING SKILL ON SELF (TUNIC GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Tunic...", completion: {
                
                //make a tent
                self.user.inventory.append(self.makeTunic())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a basic cloth tunic.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tunic. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE TUNICMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.makeTunic())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a basic cloth tunic for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tunic. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeTunic() -> Item {
        
        user.grabFromInventory("Cloth")
        user.grabFromInventory("Cloth")
        let newTunic = Item(ttl: "Tunic", desc: "A basic cloth tunic.", sx: 1, sy: 1, spriteName: "tunic")
        return newTunic
        
    }
    
    /* CAN WE USE THE TUNICMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cloth") > 1 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the tunicmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}