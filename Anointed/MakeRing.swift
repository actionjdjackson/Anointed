//
//  MakeRing.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeRing : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Ring", skillDesc: "Make a golden ring.", skillUser: user, skillSprite: "ring", baseTimeToComplete: 4, level: 10)
        
    }
    
    /* USE RINGMAKING SKILL ON SELF (RING GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Ring...", completion: {
                
                //make a ring
                self.user.inventory.append(self.makeRing())
                //level up ringmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a golden ring.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a ring. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE RINGMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Ring...", completion: {
                
                //make a ring
                npc.inventory.append(self.makeRing())
                //level up ringmaking skill
                self.levelUp()
                //report to console
                UNIVERSE.alertText("Made a golden ring for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a ring. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeRing() -> Item {
        
        self.user.grabFromInventory("Gold")
        let newTent = Item(ttl: "Ring", desc: "A golden ring.", sx: 3, sy: 2, spriteName: "ring")
        return newTent
        
    }
    
    /* CAN WE USE THE RINGMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Gold") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the ringmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}