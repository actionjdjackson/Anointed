//
//  Artmaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Artmaking : Skill {
    
    /* SETS UP ARTMAKING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Artmaking", skillDesc: "Allows you to make drawings, paintings, carvings, or scupltures.", skillUser: user, skillSprite : "artmaking", baseTimeToComplete : 10.0, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}