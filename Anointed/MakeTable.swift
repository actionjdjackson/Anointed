//
//  MakeTable.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/16/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeTable : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Table", skillDesc: "Make a ground-level table.", skillUser: user, skillSprite: "table", baseTimeToComplete: 8, level: 10)
        
    }
    
    /* USE TABLEMAKING SUBSKILL ON SELF (TABLE GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Table...", completion: {
                
                //make a table
                self.user.inventory.append(self.makeTable())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a ground-level table.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a table. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE TABLEMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Table...", completion: {
                
                //make a table
                npc.inventory.append(self.makeTable())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a table for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a table. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeTable() -> Item {
        
        self.user.grabFromInventory("Wood")
        self.user.grabFromInventory("Wood")
        let newTable = Item(ttl: "Table", desc: "A ground-level table.", sx: 3, sy: 2, spriteName: "table")
        return newTable
        
    }
    
    /* CAN WE USE THE TABLEMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 1 { //if we've got enough stuff
            
            return true //then we can use the tablemaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}