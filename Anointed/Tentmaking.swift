
//
//  Tentmaking.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/8/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Tentmaking : Skill {
    
    /* SETS UP TENTMAKING SKILL */
    init( user : GameCharacter, subsk: [Subskill] ) {
        super.init( skillName: "Tentmaking", skillDesc: "Allows you to make tents out of wood, cloth, and cord.", skillUser: user, skillSprite : "tentmaking", baseTimeToComplete : 10.0, passv: false, subsk: subsk )
        self.name = "Tentmaking"
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}