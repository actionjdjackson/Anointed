//
//  Seafaring.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Seafaring : Skill {
    
    /* SETS UP SEAFARING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Seafaring", skillDesc: "Allows you to row, sail, and travel on your own boat.", skillUser: user, skillSprite : "seafaring", baseTimeToComplete : 10.0, passv: false, subsk: [] )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}