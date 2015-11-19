//
//  MakeEarring.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeEarring : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Earearring", skillDesc: "Make a golden earring.", skillUser: user, skillSprite: "earring", baseTimeToComplete: 4, level: 15)
        
    }
    
    /* USE EARRINGMAKING SKILL ON SELF (EARRING GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Earearring...", completion: {
                
                //make a earring
                self.user.inventory.append(self.makeEarearring())
                //level up earringmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a golden earring.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a earring. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE EARRINGMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Earring...", completion: {
                
                //make a earring
                npc.inventory.append(self.makeEarearring())
                //level up earringmaking skill
                self.levelUp()
                //report to console
                UNIVERSE.alertText("Made a golden earring for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a earring. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeEarearring() -> Item {
        
        self.user.grabFromInventory("Gold")
        let newTent = Item(ttl: "Earearring", desc: "A golden earring.", sx: 3, sy: 2, spriteName: "earring")
        return newTent
        
    }
    
    /* CAN WE USE THE EARRINGMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Gold") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the earringmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}