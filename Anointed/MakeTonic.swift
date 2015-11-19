//
//  MakeTonic.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeTonic : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Tonic", skillDesc: "Make a medicinal tonic.", skillUser: user, skillSprite: "tonic", baseTimeToComplete: 0.5, level: 10)
        
    }
    
    /* USE TONICMAKING SKILL ON SELF (TONIC GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Tonic...", completion: {
                
                //make a tent
                self.user.inventory.append(self.MakeTonic())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a tonic.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tonic. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE TONICMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.MakeTonic())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a tonic for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a tonic. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func MakeTonic() -> Item {
        
        user.grabFromInventory("TonicPowder")
        user.grabFromInventory("Waterskin")
        let newTonic = Item(ttl: "Tonic", desc: "A medicinal tonic.", sx: 1, sy: 1, spriteName: "tonic")
        return newTonic
        
    }
    
    /* CAN WE USE THE TONICMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("TonicPowder") > 0 && user.howManyInInventory("Waterskin") > 0 { //if we've got enough stuff
            
            return true //then we can use the tonicmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}