//
//  Celibate.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Celibate : Skill {
    
    /* SET UP CELIBATE SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Celibate", skillDesc: "Gives the player the ability to abstain from sexual activity and remain unmarried.", skillUser: user, skillSprite : "celibate", baseTimeToComplete : 1, passv: true, subsk: [] )
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