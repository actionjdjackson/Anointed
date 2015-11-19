//
//  MakeBracelet.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeBracelet : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Bracelet", skillDesc: "Make a small, golden bracelet.", skillUser: user, skillSprite: "bracelet", baseTimeToComplete: 6, level: 1)
        
    }
    
    /* USE BRACELETMAKING SKILL ON SELF (BRACELET GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Bracelet...", completion: {
                
                //make a bracelet
                self.user.inventory.append(self.makeBracelet())
                //level up braceletmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a golden bracelet.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a bracelet. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE BRACELETMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Bracelet...", completion: {
                
                //make a bracelet
                npc.inventory.append(self.makeBracelet())
                //level up braceletmaking skill
                self.levelUp()
                //report to console
                UNIVERSE.alertText("Made a golden bracelet for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a bracelet. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeBracelet() -> Item {
        
        self.user.grabFromInventory("Gold")
        let newTent = Item(ttl: "Bracelet", desc: "A golden bracelet.", sx: 3, sy: 2, spriteName: "bracelet")
        return newTent
        
    }
    
    /* CAN WE USE THE BRACELETMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Gold") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the braceletmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}