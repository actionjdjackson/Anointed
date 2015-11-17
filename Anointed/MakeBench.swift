//
//  MakeBench.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/16/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeBench : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Bench", skillDesc: "Make a three-person bench.", skillUser: user, skillSprite: "bench", baseTimeToComplete: 10, level: 5)
        
    }
    
    /* USE BENCHMAKING SUBSKILL ON SELF (BENCH GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Bench...", completion: {
                
                //make a bench
                self.user.inventory.append(self.makeBench())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a three-person bench.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a bench. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE BENCHMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Bench...", completion: {
                
                //make a bench
                npc.inventory.append(self.makeBench())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a bench for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a bench. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeBench() -> Item {
        
        self.user.grabFromInventory("Wood")
        self.user.grabFromInventory("Wood")
        let newBench = Item(ttl: "Bench", desc: "A three-person bench.", sx: 2, sy: 1, spriteName: "bench")
        return newBench
        
    }
    
    /* CAN WE USE THE BENCHMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 1 { //if we've got enough stuff
            
            return true //then we can use the benchmaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}