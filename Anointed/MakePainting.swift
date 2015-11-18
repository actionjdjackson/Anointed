//
//  MakePainting.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/18/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakePainting : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Painting", skillDesc: "Draw a charcoal sketch.", skillUser: user, skillSprite: "painting", baseTimeToComplete: 2, level: 1)
        
    }
    
    /* USE PAINTINGMAKING SKILL ON SELF (PAINTING GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Painting...", completion: {
                
                //make a tent
                self.user.inventory.append(self.MakePainting())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Drew a charcoal sketch.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a painting. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE PAINTINGMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.MakePainting())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a painting for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a painting. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func MakePainting() -> Item {
        
        user.grabFromInventory("Parchment")
        let newPainting = Item(ttl: "Painting", desc: "A beautiful painting.", sx: 1, sy: 1, spriteName: "painting")
        return newPainting
        
    }
    
    /* CAN WE USE THE PAINTINGMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Parchment") > 0 && user.howManyInInventory("PaintSet") > 0 { //if we've got enough stuff
            
            return true //then we can use the charcoalsketchmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}