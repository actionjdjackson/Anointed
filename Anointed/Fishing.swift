//
//  Fishing.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Fishing : Skill {
    
    /* SETS UP FISHING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Fishing", skillDesc: "Allows you to go into shallow water and fish using a net.", skillUser: user, skillSprite : "fishing", baseTimeToComplete : 10.0, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}