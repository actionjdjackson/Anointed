//
//  Tailoring.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Tailoring : Skill {
    
    /* SETS UP TAILORING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Tailoring", skillDesc: "Allows you to make clothing of various different kinds.", skillUser: user, skillSprite : "tailoring", baseTimeToComplete : 10.0, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}