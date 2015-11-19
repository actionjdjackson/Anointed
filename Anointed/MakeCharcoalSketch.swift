//
//  MakeCharcoalSketch.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/18/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeCharcoalSketch : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Charcoal Sketch", skillDesc: "Draw a charcoal sketch.", skillUser: user, skillSprite: "charcoalSketch", baseTimeToComplete: 2, level: 1)
        
    }
    
    /* USE CHARCOALSKETCHMAKING SKILL ON SELF (CHARCOAL SKETCH GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Charcoal Sketch...", completion: {
                
                //make a tent
                self.user.inventory.append(self.MakeCharcoalSketch())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Drew a charcoal sketch.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a charcoal sketch. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE CHARCOALSKETCHMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.makeCharcoalSketch())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Drew a charcoal sketch for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a charcoal sketch. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeCharcoalSketch() -> Item {
        
        user.grabFromInventory("Parchment")
        let newCharcoalSketch = Item(ttl: "Charcoal Sketch", desc: "A charcoal sketch.", sx: 1, sy: 1, spriteName: "charcoalSketch")
        return newCharcoalSketch
        
    }
    
    /* CAN WE USE THE CHARCOALSKETCHMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Parchment") > 0 && user.howManyInInventory("CharcoalPencil") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the charcoalsketchmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}