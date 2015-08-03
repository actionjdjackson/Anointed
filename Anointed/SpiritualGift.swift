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
    
    let TOOLTIP_SIZE : CGSize = CGSize( width: 128, height: 128 )
    let title : String
    let desc : String
    var user : GameCharacter
    var sprite : String
    var level : Int
    var subSkills : [Skill]
    var toolTipSN : ToolTipSpriteNode
    
    init( giftName : String, giftDesc : String, giftUser : GameCharacter, giftSprite : String, giftSkills : [Skill] ) {
        
        title = giftName
        desc = giftDesc
        user = giftUser
        sprite = giftSprite
        level = 1   //starts at level 1
        subSkills = giftSkills  //subskills
        let texture = SKTexture(imageNamed: giftSprite) //grab texture for spiritual gift
        toolTipSN = ToolTipSpriteNode(tex: SKTexture(imageNamed: giftSprite + "TOOLTIP"), infoA: " ", infoB: " ")   //creates tooltip
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size()) //calls superclass init with grabbed texture
        toolTipSN.position = CGPointZero    //center tooltip on spiritual gift
        toolTipSN.zPosition = 2.0   //set z position to draw in front of spiritual gift
        toolTipSN.size = CGSize.zeroSize    //hide initially (zero size)
        self.addChild( toolTipSN )  //add tooltip to spiritual gift
        self.userInteractionEnabled = true  //detect mouseclicks, etc.
        
    }

    /* HANDLES MOUSE CLICK, DISPLAYS TOOLTIP WHILE MOUSE IS HELD DOWN */
    override func mouseDown( theEvent: NSEvent ) {
        
        var infoLabelA = SKLabelNode(text: toolTipSN.itemInfoA) //creates a label node with text for info A
        var infoLabelB = SKLabelNode(text: toolTipSN.itemInfoB) //same for info B
        infoLabelA.fontColor = SKColor.whiteColor() //set text color to white
        infoLabelB.fontColor = SKColor.whiteColor() //same for info B
        infoLabelA.fontSize = 12    //set label A font size
        infoLabelB.fontSize = 12    //set label B font size
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
        toolTipSN.size = CGSize.zeroSize    //hide tooltip (zero size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}