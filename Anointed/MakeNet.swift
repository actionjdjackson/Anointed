//
//  MakeNet.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/16/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeNet : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Fishing Net", skillDesc: "Make a fishing net.", skillUser: user, skillSprite: "net", baseTimeToComplete: 5, level: 1)
        
    }
    
    /* USE NETMAKING SUBSKILL ON SELF (TABLE GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Net...", completion: {
                
                //make a net
                self.user.inventory.append(self.makeNet())
                //level up netmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a fishing net.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a net. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE NETMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Net...", completion: {
                
                //make a net
                npc.inventory.append(self.makeNet())
                //level up netmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a fishing net for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a net. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeNet() -> Item {
        
        self.user.grabFromInventory("Cord")
        self.user.grabFromInventory("Cord")
        self.user.grabFromInventory("Cord")
        let newTable = Item(ttl: "Net", desc: "A fishing net.", sx: 1, sy: 1, spriteName: "net")
        return newTable
        
    }
    
    /* CAN WE USE THE BOATMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cord") > 2 { //if we've got enough stuff
            
            return true //then we can use the netmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}