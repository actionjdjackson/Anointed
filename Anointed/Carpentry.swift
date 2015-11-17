//
//  Carpentry.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Carpentry : Skill {
    
    /* SETS UP CARPENTRY SKILL */
    init( user : GameCharacter, subsk: [Subskill] ) {
        super.init( skillName: "Carpentry", skillDesc: "Allows you to make various items out of wood.", skillUser: user, skillSprite : "carpentry", baseTimeToComplete : 10.0, passv: false, subsk: subsk )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}