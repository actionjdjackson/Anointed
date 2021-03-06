//
//  SpiritualGift.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class SpiritualGift : Gift {
    
    override init( giftName : String, giftDesc : String, giftUser : GameCharacter, giftSprite : String, giftSkills : [Skill] ) {
        
        super.init(giftName: giftName, giftDesc: giftDesc, giftUser: giftUser, giftSprite: giftSprite, giftSkills: giftSkills)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}