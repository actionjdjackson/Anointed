//
//  MakeNecklace.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeNecklace : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Necklace", skillDesc: "Make a long, golden necklace.", skillUser: user, skillSprite: "necklace", baseTimeToComplete: 10, level: 5)
        
    }
    
    /* USE NECKLACEMAKING SKILL ON SELF (NECKLACE GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Necklace...", completion: {
                
                //make a necklace
                self.user.inventory.append(self.makeNecklace())
                //level up necklacemaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a golden necklace.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a necklace. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE NECKLACEMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Necklace...", completion: {
                
                //make a necklace
                npc.inventory.append(self.makeNecklace())
                //level up necklacemaking skill
                self.levelUp()
                //report to console
                UNIVERSE.alertText("Made a golden necklace for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a necklace. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeNecklace() -> Item {
        
        self.user.grabFromInventory("Gold")
        self.user.grabFromInventory("Gold")
        let newTent = Item(ttl: "Necklace", desc: "A golden necklace.", sx: 3, sy: 2, spriteName: "necklace")
        return newTent
        
    }
    
    /* CAN WE USE THE NECKLACEMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Gold") > 1 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the necklacemaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}