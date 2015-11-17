//
//  Cooking.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Cooking : Skill {
    
    /* SETS UP COOKING SKILL */
    init( user : GameCharacter, subsk : [Subskill] ) {
        super.init( skillName: "Cooking", skillDesc: "Allows you to cook food of various different kinds.", skillUser: user, skillSprite : "cooking", baseTimeToComplete : 10.0, passv: false, subsk: subsk )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}