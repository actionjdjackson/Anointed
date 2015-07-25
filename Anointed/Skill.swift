//
//  Skill.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Skill : SKSpriteNode {
    
    let TOOLTIP_SIZE : CGSize = CGSize( width: 128, height: 128 )
    let ZERO_SIZE : CGSize = CGSize( width: 0, height: 0 )
    public let title : String
    let desc : String
    var user : GameCharacter
    var sprite : String
    public var toolTip : String
    public var level : Int
    public var hoursToComplete : Double
    public var toolTipSN : ToolTipSpriteNode
    
    init( skillName : String, skillDesc : String, skillUser : GameCharacter, skillSprite : String, baseTimeToComplete : Double ) {
        
        title = skillName
        desc = skillDesc
        user = skillUser
        sprite = skillSprite
        toolTip = sprite + "TOOLTIP"
        level = 1
        hoursToComplete = baseTimeToComplete
        let texture = SKTexture(imageNamed: sprite)
        toolTipSN = ToolTipSpriteNode(tex: SKTexture(imageNamed: toolTip))
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        toolTipSN.position = CGPointZero
        toolTipSN.zPosition = 2.0
        toolTipSN.size = ZERO_SIZE
        self.addChild( toolTipSN )
        self.userInteractionEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    internal func canUse() -> Bool {
        
        //override for each skill
        return false
        
    }
    
    override func mouseDown( theEvent: NSEvent ) {
        
        println("Clicked a skill")
        toolTipSN.size = TOOLTIP_SIZE
        
    }
    
    override func mouseUp( theEvent : NSEvent ) {
        
        println("Unclicked a skill")
        toolTipSN.size = ZERO_SIZE
        
    }
    
}