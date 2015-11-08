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
    
    let TOOLTIP_SIZE : CGSize = CGSize( width: 128, height: 128 )   //tooltip size
    let title : String
    let desc : String
    var user : GameCharacter
    var sprite : String
    var toolTip : String
    var level : Int
    var baseHoursToComplete : Double
    var hoursToComplete : Double
    var toolTipSN : ToolTipSpriteNode
    var passive : Bool
    
    init( skillName : String, skillDesc : String, skillUser : GameCharacter, skillSprite : String, baseTimeToComplete : Double, passv: Bool ) {
        
        title = skillName
        desc = skillDesc
        user = skillUser
        sprite = skillSprite
        toolTip = sprite + "TOOLTIP"    //tooltip sprite is same as skill sprite plus TOOLTIP on the end
        level = 1   //starts at level 1
        baseHoursToComplete = baseTimeToComplete    //base time to complete
        hoursToComplete = baseHoursToComplete
        passive = passv
        let texture = SKTexture(imageNamed: sprite) //grab texture for this skill
        toolTipSN = ToolTipSpriteNode(tex: SKTexture(imageNamed: toolTip), infoA: "Level " + String( level ), infoB: "Time to Complete: ? hrs" )    //create ttip
        toolTipSN.itemInfoA = "Level " + String( level )    //set info A to the level of the skill
        toolTipSN.itemInfoB = "Time to Complete: "
        toolTipSN.itemInfoB += String(hoursToComplete) + " hrs"   //set info B to time to complete rounded to nearest hr
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size()) //init spritenode superclass with grabbed texture
        toolTipSN.position = CGPointZero    //center on skill
        toolTipSN.zPosition = 2.0   //set z position of tooltip to draw on top of skill
        toolTipSN.size = CGSize.zero    //initially hide tooltip
        self.addChild( toolTipSN )  //add tooltip to skill
        self.userInteractionEnabled = true  //detects mouse clicks, etc.
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func applyPassiveTraits() {
        
        //override for each skill using passive traits
        
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
    
    /* HANDLES MOUSE CLICK, DISPLAYS TOOLTIP WHILE MOUSE IS HELD DOWN */
    override func mouseDown( theEvent: NSEvent ) {
        
        let infoLabelA = SKLabelNode(text: toolTipSN.itemInfoA) //creates a label node with text for info A
        let infoLabelB = SKLabelNode(text: toolTipSN.itemInfoB) //same for info B
        infoLabelA.fontColor = SKColor.whiteColor() //set text color to white
        infoLabelB.fontColor = SKColor.whiteColor() //same for info B
        infoLabelA.fontSize = 12    //set label A font size (bigger)
        infoLabelB.fontSize = 10    //set label B font size (smaller)
        infoLabelA.fontName = "Arial"   //set font name
        infoLabelB.fontName = "Arial"   //same
        infoLabelA.position = CGPoint(x: 0, y: -32) //positions label A to mid-bottom
        infoLabelB.position = CGPoint(x: 0, y: -48) //positions label A to bottom
        toolTipSN.addChild(infoLabelA)  //adds label A to tooltip
        toolTipSN.addChild(infoLabelB)  //adds label B to tooltip
        toolTipSN.size = TOOLTIP_SIZE   //display tooltip (make size = full size)
        
    }
    
    /* HANDLES MOUSE RELEASE */
    override func mouseUp( theEvent : NSEvent ) {
    
        toolTipSN.removeAllChildren()   //remove all labels
        toolTipSN.size = CGSize.zero    //hide tooltip (zero size)
        
    }
    
}