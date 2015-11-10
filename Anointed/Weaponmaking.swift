//
//  Weaponmaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Weaponmaking : Skill {
    
    /* SETS UP WEAPONMAKING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Weaponmaking", skillDesc: "Allows you to make various kinds of weaponry.", skillUser: user, skillSprite : "weaponmaking", baseTimeToComplete : 10.0, passv: false, subsk: [] )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}