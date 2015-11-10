//
//  Medicine.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/5/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Medicine : Skill {
    
    /* SETS UP MEDICINE SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Medicine", skillDesc: "Allows you to treat and cure various kinds of ailments, diseases, or injuries by the use of medicine.", skillUser: user, skillSprite : "medicine", baseTimeToComplete : 10.0, passv: false, subsk: [] )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}