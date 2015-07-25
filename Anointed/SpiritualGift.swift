//
//  SpiritualGift.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class SpiritualGift {
    
    public let title : String
    public let desc : String
    var user : GameCharacter
    var sprite : String
    public var level : Int
    public var subSkills : [Skill]
    
    init( giftName : String, giftDesc : String, giftUser : GameCharacter, giftSprite : String, giftSkills : [Skill] ) {
        
        title = giftName
        desc = giftDesc
        user = giftUser
        sprite = giftSprite
        level = 1
        subSkills = giftSkills
        
    }
    
}