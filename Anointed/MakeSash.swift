//
//  MakeSash.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/17/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeSash : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Sash", skillDesc: "Make a small, cloth sash.", skillUser: user, skillSprite: "sash", baseTimeToComplete: 2, level: 1)
        
    }
    
    /* USE SASHMAKING SKILL ON SELF (SASH GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Sash...", completion: {
                
                //make a tent
                self.user.inventory.append(self.makeSash())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a basic cloth sash.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a sash. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE SASHMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.makeSash())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a basic cloth sash for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a sash. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeSash() -> Item {
        
        user.grabFromInventory("Cloth")
        let newSash = Item(ttl: "Sash", desc: "A basic cloth sash.", sx: 1, sy: 1, spriteName: "sash")
        return newSash
        
    }
    
    /* CAN WE USE THE SASHMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cloth") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the sashmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}