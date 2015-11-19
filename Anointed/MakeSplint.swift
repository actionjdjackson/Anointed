//
//  MakeSplint.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeSplint : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Splint", skillDesc: "Make a splint.", skillUser: user, skillSprite: "splint", baseTimeToComplete: 0.5, level: 15)
        
    }
    
    /* USE SPLINTMAKING SKILL ON SELF (SPLINT GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Splint...", completion: {
                
                //make a tent
                self.user.inventory.append(self.makeSplint())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a splint.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a splint. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE SPLINTMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.makeSplint())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a splint for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a splint. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeSplint() -> Item {
        
        user.grabFromInventory("Wood")
        user.grabFromInventory("Cloth")
        let newSplint = Item(ttl: "Splint", desc: "A splint, for setting broken bones or fractures.", sx: 1, sy: 1, spriteName: "splint")
        return newSplint
        
    }
    
    /* CAN WE USE THE SPLINTMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 0 && user.howManyInInventory("Cloth") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the splintmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}