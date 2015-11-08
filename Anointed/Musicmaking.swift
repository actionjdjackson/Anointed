//
//  Musicmaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Musicmaking : Skill {
    
    /* SETS UP MUSICMAKING SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Musicmaking", skillDesc: "Allows you to make music on various instruments, including singing.", skillUser: user, skillSprite : "musicmaking", baseTimeToComplete : 10.0, passv: false )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}