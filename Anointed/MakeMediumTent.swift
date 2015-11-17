//
//  MakeMediumTent.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/10/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeMediumTent : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Medium Tent", skillDesc: "Make a medium, family-sized tent.", skillUser: user, skillSprite: "tent", baseTimeToComplete: 15, level: 5)
        
    }
    
    /* USE TENTMAKING SKILL ON SELF (TENT GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Medium Tent...", completion: {
                
                //make a tent
                self.user.inventory.append(self.makeMediumTent())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a medium sized cloth tent.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tent. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE TENTMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Medium Tent...", completion: {
                
                //make a tent
                npc.inventory.append(self.makeMediumTent())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a medium cloth tent for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tent. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeMediumTent() -> Item {
        
        self.user.grabFromInventory("Cloth")
        self.user.grabFromInventory("Cloth")
        self.user.grabFromInventory("Cord")
        self.user.grabFromInventory("Wood")
        let newTent = Item(ttl: "Medium Tent", desc: "A medium-sized cloth tent.", sx: 2, sy: 2, spriteName: "tent")
        return newTent
        
    }
    
    /* CAN WE USE THE TENTMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cloth") > 1 && user.howManyInInventory("Cord") > 0 && user.howManyInInventory("Wood") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the tentmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}