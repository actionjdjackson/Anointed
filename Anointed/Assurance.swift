//
//  Assurance.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Assurance : Skill {
    
    /* SET UP WORD OF WISDOM SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Assurance", skillDesc: "Gives you special, strong, supernatural faith for assurance over your own life & ministry.", skillUser: user, skillSprite : "assurance", baseTimeToComplete: 0.0, passv: true )
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