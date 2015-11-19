//
//  MakeMosaic.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/18/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeMosaic : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Mosaic", skillDesc: "Create a multicolored mosaic.", skillUser: user, skillSprite: "mosaic", baseTimeToComplete: 2, level: 1)
        
    }
    
    /* USE MOSAICMAKING SKILL ON SELF (MOSAIC GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Mosaic...", completion: {
                
                //make a tent
                self.user.inventory.append(self.MakeMosaic())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a mosaic.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a mosaic. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE MOSAICMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.MakeMosaic())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a mosaic for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a mosaic. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func MakeMosaic() -> Item {
        
        user.grabFromInventory("Tiles")
        user.grabFromInventory("Mortar")
        let newMosaic = Item(ttl: "Mosaic", desc: "A multicolored mosaic.", sx: 1, sy: 1, spriteName: "mosaic")
        return newMosaic
        
    }
    
    /* CAN WE USE THE MOSAICMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Tiles") > 0 && user.howManyInInventory("Mortar") > 0 { //if we've got enough stuff
            
            return true //then we can use the mosaicmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}