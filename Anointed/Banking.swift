//
//  Banking.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Banking : Skill {
    
    /* SETS UP BANKING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Banking", skillDesc: "Allows you to conduct business as a banker, including making a lockbox, exchanging currency, lending money, etc.", skillUser: user, skillSprite : "banking", baseTimeToComplete : 10.0, passv: false, subsk: [] )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}