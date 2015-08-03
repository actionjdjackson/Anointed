//
//  Servanthood.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Servanthood : Skill {
    
    /* SET UP SERVICE SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Servanthood", skillDesc: "Allows you to have the option of serving someone during a conversation.", skillUser: user, skillSprite : "servanthood", baseTimeToComplete : 1, passv: true )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyPassiveTraits() {
        
        //fill in stuff here
        
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}