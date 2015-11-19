//
//  MakeBowAndArrow.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeBowAndArrow : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Bow & Arrow", skillDesc: "Make a traditional wooden Bow & Arrow.", skillUser: user, skillSprite: "bow&arrow", baseTimeToComplete: 8, level: 5)
        
    }
    
    /* USE BOW&ARROWMAKING SUBSKILL ON SELF (BOW&ARROW GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Bow & Arrow...", completion: {
                
                //make a table
                self.user.inventory.append(self.makeBowAndArrow())
                //level up bow&arrowmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a Bow & Arrow.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a Bow & Arrow. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE BOW&ARROWMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Bow & Arrow...", completion: {
                
                //make a bow&arrow, put it in npc's inventory
                npc.inventory.append(self.makeBowAndArrow())
                //level up bow&arrowmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a Bow & Arrow for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a table. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeBowAndArrow() -> Item {
        
        self.user.grabFromInventory("Wood")
        self.user.grabFromInventory("Wood")
        let newBowAndArrow = Item(ttl: "Bow & Arrow", desc: "A traditional, wooden Bow & Arrow.", sx: 2, sy: 4, spriteName: "bow&arrow")
        return newBowAndArrow
        
    }
    
    /* CAN WE USE THE BOW&ARROWMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 1 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the bow&arrowmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}