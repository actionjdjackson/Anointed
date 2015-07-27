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
    let title : String
    let desc : String
    var user : GameCharacter
    var sprite : String
    var toolTip : String
    var level : Int
    var hoursToComplete : Double
    var toolTipSN : ToolTipSpriteNode
    
    init( skillName : String, skillDesc : String, skillUser : GameCharacter, skillSprite : String, baseTimeToComplete : Double ) {
        
        title = skillName
        desc = skillDesc
        user = skillUser
        sprite = skillSprite
        toolTip = sprite + "TOOLTIP"
        level = 1
        hoursToComplete = baseTimeToComplete
        let texture = SKTexture(imageNamed: sprite)
        toolTipSN = ToolTipSpriteNode(tex: SKTexture(imageNamed: toolTip), infoA: "Level " + String( level ), infoB: "Time to Complete: ? hrs" )
        toolTipSN.itemInfoA = "Level " + String( level )
        toolTipSN.itemInfoB = "Time to Complete: "
        toolTipSN.itemInfoB += String(Int(self.hoursToComplete - log(Double(self.level) * 1.0))) + " hrs"
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        toolTipSN.position = CGPointZero
        toolTipSN.zPosition = 2.0
        toolTipSN.size = CGSize.zeroSize
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
        
        var infoLabelA = SKLabelNode(text: toolTipSN.itemInfoA)
        var infoLabelB = SKLabelNode(text: toolTipSN.itemInfoB)
        infoLabelA.fontColor = SKColor.whiteColor()
        infoLabelB.fontColor = SKColor.whiteColor()
        infoLabelA.fontSize = 12
        infoLabelB.fontSize = 10
        infoLabelA.fontName = "Arial"
        infoLabelB.fontName = "Arial"
        infoLabelA.position = CGPoint(x: 0, y: -32)
        infoLabelB.position = CGPoint(x: 0, y: -48)
        toolTipSN.addChild(infoLabelA)
        toolTipSN.addChild(infoLabelB)
        toolTipSN.size = TOOLTIP_SIZE
        
    }
    
    override func mouseUp( theEvent : NSEvent ) {
    
        toolTipSN.removeAllChildren()
        toolTipSN.size = CGSize.zeroSize
        
    }
    
}