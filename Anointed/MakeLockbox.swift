//
//  MakeLockbox.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeLockbox : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Lockbox", skillDesc: "Make a wood and iron lockbox.", skillUser: user, skillSprite: "lockbox", baseTimeToComplete: 12, level: 1)
        
    }
    
    /* USE LOCKBOXMAKING SKILL ON SELF (LOCKBOX GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Lockbox...", completion: {
                
                //make a lockbox
                self.user.inventory.append(self.makeLockbox())
                //level up lockboxmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a lockbox.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a lockbox. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE LOCKBOXMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a lockbox
            npc.inventory.append(self.makeLockbox())
            //level up lockboxmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a lockbox for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a lockbox. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeLockbox() -> Item {
        
        user.grabFromInventory("Wood")
        user.grabFromInventory("Iron")
        let newLockbox = Item(ttl: "Lockbox", desc: "A wood and iron lockbox.", sx: 1, sy: 1, spriteName: "lockbox")
        return newLockbox
        
    }
    
    /* CAN WE USE THE LOCKBOXMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 0 && user.howManyInInventory("Iron") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the lockboxmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}