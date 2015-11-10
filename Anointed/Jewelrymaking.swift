//
//  Jewelrymaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Jewelrymaking : Skill {
    
    /* SETS UP JEWELRYMAKING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Jewelrymaking", skillDesc: "Allows you to make various kinds of jewelry.", skillUser: user, skillSprite : "jewelrymaking", baseTimeToComplete : 10.0, passv: false, subsk: [] )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}