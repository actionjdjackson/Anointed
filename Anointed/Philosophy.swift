//
//  Philosophy.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Philosophy : Skill {
    
    /* SETS UP PHILOSOPHY SKILL */
    init( user : GameCharacter, subsk : [Subskill] ) {
        super.init( skillName: "Philosophy", skillDesc: "Allows you to reflect on life and think analytically.", skillUser: user, skillSprite : "philosophy", baseTimeToComplete : 10.0, passv: false, subsk: subsk )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}