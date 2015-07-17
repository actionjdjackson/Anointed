//
//  Skill.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Skill {
    
    public let title : String
    let desc : String
    var user : GameCharacter
    var sprite : String
    public var level : Int
    
    init( skillName : String, skillDesc : String, skillUser : GameCharacter, skillSprite : String ) {
        
        title = skillName
        desc = skillDesc
        user = skillUser
        sprite = skillSprite
        level = 1
        
    }
    
    internal func use() {
        
        //override for each skill
        
    }
    
    internal func useOnNPC( npc: NonPlayingCharacter ) {
        
        //override for each skill
        
    }
    
    internal func useOnAnimal( animal : Animal ) {
        
        //override for each skill
        
    }
    
}