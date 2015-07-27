//
//  SpiritualGift.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class SpiritualGift : SKSpriteNode {
    
    let title : String
    let desc : String
    var user : GameCharacter
    var sprite : String
    var level : Int
    var subSkills : [Skill]
    
    init( giftName : String, giftDesc : String, giftUser : GameCharacter, giftSprite : String, giftSkills : [Skill] ) {
        
        title = giftName
        desc = giftDesc
        user = giftUser
        sprite = giftSprite
        level = 1
        subSkills = giftSkills
        var texture : SKTexture = SKTexture(imageNamed: sprite)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}