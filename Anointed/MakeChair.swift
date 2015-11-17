//
//  MakeChair.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/16/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeChair : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Chair", skillDesc: "Make a small one-person chair.", skillUser: user, skillSprite: "chair", baseTimeToComplete: 8, level: 1)
        
    }
    
    /* USE CHAIRMAKING SUBSKILL ON SELF (TENT GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Chair...", completion: {
                
                //make a tent
                self.user.inventory.append(self.makeChair())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a basic one-person chair.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a chair. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE CHAIRMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Chair...", completion: {
                
                //make a chair
                npc.inventory.append(self.makeChair())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a chair for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a chair. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeChair() -> Item {
        
        self.user.grabFromInventory("Wood")
        let newChair = Item(ttl: "Chair", desc: "A small, one-person chair.", sx: 1, sy: 1, spriteName: "chair")
        return newChair
        
    }
    
    /* CAN WE USE THE CHAIRMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 0 { //if we've got enough stuff
            
            return true //then we can use the chairmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}