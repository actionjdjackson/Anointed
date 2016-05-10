//
//  MakeCampfire.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/17/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeCampfire : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Campfire", skillDesc: "Make a cozy campfire.", skillUser: user, skillSprite: "campfire", baseTimeToComplete: 0.5, level: 1)
        
    }
    
    /* USE CAMPFIREMAKING SUBSKILL ON SELF (CAMPFIRE APPEARS ON SCREEN) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Campfire...", completion: {
                
                //make a campfire
                self.user.grabFromInventory("Wood")
                UNIVERSE.theScene.nodeAtPoint(CGPoint(x: 64, y: 64)).addChild(SKSpriteNode(imageNamed: "campfire"))
                //play campfire sound
                playSound("Campfire.mp3")
                //level up campfiremaking skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a campfire.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a campfire. Sorry.")  // no can do
            
        }
        
    }
    
    /* CAN WE USE THE CAMPFIREMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Wood") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the campfiremaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}