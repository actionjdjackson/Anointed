//
//  Scribe.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/8/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Scribe : Skill {
    
    /* SETS UP BANKING SKILL */
    init( user : GameCharacter, subsk : [Subskill] ) {
        super.init( skillName: "Scribe", skillDesc: "Allows you to create and copy documents - including scripture, legal documents, and letters.", skillUser: user, skillSprite : "scribe", baseTimeToComplete : 10.0, passv: false, subsk: subsk )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}