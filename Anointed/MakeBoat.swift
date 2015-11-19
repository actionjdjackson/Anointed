//
//  MakeBoat.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/16/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeBoat : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Boat", skillDesc: "Make a small fishing boat.", skillUser: user, skillSprite: "boat", baseTimeToComplete: 48, level: 20)
        
    }
    
    /* USE BOATMAKING SUBSKILL ON SELF (BOAT GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Boat...", completion: {
                
                //make a table
                self.user.inventory.append(self.makeBoat())
                //level up boatmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a small fishing boat.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a boat. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE BOATMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Boat...", completion: {
                
                //make a boat, put it in npc's inventory
                npc.inventory.append(self.makeBoat())
                //level up boatmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a small fishing boat for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a table. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeBoat() -> Item {
        
        self.user.grabFromInventory("Wood")
        self.user.grabFromInventory("Wood")
        self.user.grabFromInventory("Wood")
        self.user.grabFromInventory("Wood")
        self.user.grabFromInventory("Wood")
        let newTable = Item(ttl: "Boat", desc: "A small fishing boat.", sx: 8, sy: 8, spriteName: "boat")
        return newTable
        
    }
    
    /* CAN WE USE THE BOATMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 4 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the boatmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}