//
//  MakeSpear.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeSpear : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Spear", skillDesc: "Make a wooden spear.", skillUser: user, skillSprite: "spear", baseTimeToComplete: 5, level: 1)
        
    }
    
    /* USE SPEARMAKING SKILL ON SELF (SPEAR GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {

            playSound("tentmaking.mp3")
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Spear...", completion: {

                //make a spear
                self.user.inventory.append(self.makeSpear())
                //level up spearmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a spear.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a spear. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE SPEARMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            playSound("tentmaking.mp3")
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Spear...", completion: {
            
            //make a spear
            npc.inventory.append(self.makeSpear())
            //level up spearmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a spear for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a spear. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeSpear() -> Item {
        
        user.grabFromInventory("Wood")
        let newSpear = Item(ttl: "Spear", desc: "A wooden spear.", sx: 1, sy: 1, spriteName: "spear")
        return newSpear
        
    }
    
    /* CAN WE USE THE SPEARMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the spearmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}