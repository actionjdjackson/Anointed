
//
//  Tentmaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/8/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Tentmaking : Skill {
    
    /* SETS UP TENTMAKING SKILL */
    init( user : GameCharacter, subsk: [Subskill] ) {
        super.init( skillName: "Tentmaking", skillDesc: "Allows you to make tents out of wood, cloth, and cord.", skillUser: user, skillSprite : "tentmaking", baseTimeToComplete : 10.0, passv: false, subsk: subsk )
        self.userInteractionEnabled = true
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
        var i : Int = 0
        for skill in subskills {
            
            let skillMenu : MenuItem = MenuItem(theText: skill.name!)
            skillMenu.name = skill.name!
            skillMenu.position = CGPoint.zero
            skillMenu.position.y += CGFloat(i * 32)
            skillMenu.zPosition = 100
            self.addChild(skillMenu)
            i++
            
        }
        let cancelMenu : MenuItem = MenuItem(theText: "Cancel")
        cancelMenu.name = "Cancel"
        cancelMenu.position.y += CGFloat(i * 32)
        cancelMenu.zPosition = 100
        self.addChild(cancelMenu)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}