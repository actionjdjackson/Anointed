//
//  MakeShortSword.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeShortSword : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Short Sword", skillDesc: "Make a small one-person short-sword.", skillUser: user, skillSprite: "shortSword", baseTimeToComplete: 12, level: 15)
        
    }
    
    /* USE CHAIRMAKING SUBSKILL ON SELF (TENT GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Short Sword...", completion: {
                
                //make a short-sword
                self.user.inventory.append(self.makeShortSword())
                //level up weaponmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a basic one-person short-sword.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a short-sword. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE CHAIRMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Short Sword...", completion: {
                
                //make a short-sword
                npc.inventory.append(self.makeShortSword())
                //level up weaponmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a short-sword for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a short-sword. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeShortSword() -> Item {
        
        self.user.grabFromInventory("Iron")
        self.user.grabFromInventory("Iron")
        self.user.grabFromInventory("Iron")
        self.user.grabFromInventory("Iron")
        self.user.grabFromInventory("Iron")
        let newShortSword = Item(ttl: "Short Sword", desc: "A steel short-sword.", sx: 1, sy: 3, spriteName: "shortSword")
        return newShortSword
        
    }
    
    /* CAN WE USE THE CHAIRMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 4 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the short-swordmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}