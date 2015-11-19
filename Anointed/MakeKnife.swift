//
//  MakeKnife.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/19/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MakeKnife : Subskill {
    
    init( user: GameCharacter ) {
        
        super.init(skillName: "Make Knife", skillDesc: "Make a basic knife.", skillUser: user, skillSprite: "knife", baseTimeToComplete: 12, level: 10)
        
    }
    
    /* USE KNIFEMAKING SUBSKILL ON SELF (KNIFE GOES INTO INVENTORY) */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Knife...", completion: {
                
                //make a tent
                self.user.inventory.append(self.makeKnife())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a basic knife.")
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a knife. Sorry.")  // no can do
            
        }
        
    }
    
    /* USE KNIFEMAKING SUBSKILL ON NPC (GOES INTO NPC'S INVENTORY) */
    override func useOnNPC(npc: NonPlayingCharacter) {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            UNIVERSE.theScene.makeProgressBarFor(self.hoursToComplete, caption: "Making Knife...", completion: {
                
                //make a knife
                npc.inventory.append(self.makeKnife())
                //level up carpentry skill
                self.levelUp()
                //report to screen
                UNIVERSE.alertText("Made a knife for " + npc.name!)
                
            })
            
        } else {    //if we don't have enough raw materials,
            
            UNIVERSE.alertText("Not enough resources to make a knife. Sorry.")  //UNIVERSE.alertText no can do
            
        }
        
    }
    
    func makeKnife() -> Item {
        
        self.user.grabFromInventory("Iron")
        let newKnife = Item(ttl: "Knife", desc: "A small, one-person knife.", sx: 1, sy: 1, spriteName: "knife")
        return newKnife
        
    }
    
    /* CAN WE USE THE KNIFEMAKING SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        if user.howManyInInventory("Iron") > 0 && self.level >= levelRequired { //if we've got enough stuff
            
            return true //then we can use the knifemaking skill
            
        } else {    //otherwise,
            
            return false    //we can't
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}