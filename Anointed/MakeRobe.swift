//
//  MakeRobe.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/17/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeRobe : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Robe", skillDesc: "Make a royal robe.", skillUser: user, skillSprite: "robe", baseTimeToComplete: 2, level: 1)
        
    }
    
    /* USE ROBEMAKING SKILL ON SELF (ROBE GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Robe...", completion: {
                
                //make a tent
                self.user.inventory.append(self.MakeRobe())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a royal cloth robe.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a robe. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE ROBEMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.MakeRobe())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a royal cloth robe for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a robe. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func MakeRobe() -> Item {
        
        user.grabFromInventory("Cloth")
        user.grabFromInventory("Cloth")
        user.grabFromInventory("Cloth")
        user.grabFromInventory("Cloth")
        let newRobe = Item(ttl: "Robe", desc: "A royal cloth robe.", sx: 1, sy: 2, spriteName: "robe")
        return newRobe
        
    }
    
    /* CAN WE USE THE ROBEMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cloth") > 3 { //if we've got enough stuff
            
            return true //then we can use the robemaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}