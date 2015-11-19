//
//  MakePoultice.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakePoultice : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Poultice", skillDesc: "Make a medicinal poultice.", skillUser: user, skillSprite: "poultice", baseTimeToComplete: 0.5, level: 5)
        
    }
    
    /* USE POULTICEMAKING SKILL ON SELF (POULTICE GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Poultice...", completion: {
                
                //make a tent
                self.user.inventory.append(self.MakePoultice())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a poultice.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a poultice. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE POULTICEMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.MakePoultice())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a poultice for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a poultice. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func MakePoultice() -> Item {
        
        user.grabFromInventory("Spices")
        user.grabFromInventory("Cloth")
        let newPoultice = Item(ttl: "Poultice", desc: "A medicinal poultice, for healing wounds.", sx: 1, sy: 1, spriteName: "poultice")
        return newPoultice
        
    }
    
    /* CAN WE USE THE POULTICEMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Spices") > 0 && user.howManyInInventory("Cloth") > 0 { //if we've got enough stuff
            
            return true //then we can use the poulticemaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}