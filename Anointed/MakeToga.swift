//
//  MakeToga.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/17/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeToga : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Toga", skillDesc: "Make a cloth toga.", skillUser: user, skillSprite: "toga", baseTimeToComplete: 2, level: 1)
        
    }
    
    /* USE TOGAMAKING SKILL ON SELF (TOGA GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Toga...", completion: {
                
                //make a tent
                self.user.inventory.append(self.MakeToga())
                //level up tentmaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a basic cloth toga.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a toga. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE TOGAMAKING SKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            //make a tent
            npc.inventory.append(self.MakeToga())
            //level up tentmaking skill
            self.levelUp()
            //report to screen
            UNIVERSE.alertText("Made a basic cloth toga for " + npc.name!)
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a toga. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func MakeToga() -> Item {
        
        user.grabFromInventory("Cloth")
        user.grabFromInventory("Cloth")
        user.grabFromInventory("Cloth")
        let newToga = Item(ttl: "Toga", desc: "A basic cloth toga.", sx: 1, sy: 2, spriteName: "toga")
        return newToga
        
    }
    
    /* CAN WE USE THE TOGAMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Cloth") > 2 { //if we've got enough stuff
            
            return true //then we can use the togamaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}