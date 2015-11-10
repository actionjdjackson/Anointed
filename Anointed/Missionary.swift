//
//  Missionary.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Missionary : Skill {
    
    /* SET UP MISSIONARY SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Missionary", skillDesc: "Allows you to have the ability to travel abroad spreading the Gospel.", skillUser: user, skillSprite : "missionary", baseTimeToComplete : 0.0, passv: true, subsk: [] )
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