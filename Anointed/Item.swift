//
//  Item.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* DEFINES AN ITEM TO BE USED BY THE PLAYER IN THE GAME */
class Item : SKSpriteNode {
    
    let TOOLTIP_SIZE : CGSize = CGSize( width: 128, height: 128 )
    let title: String   //title
    let descr: String   //description
    let inventorySizeX: Int //dimensions in inventory screen
    let inventorySizeY: Int //""
    let sprite: String  //image name for item icon
    var toolTipSN : ToolTipSpriteNode
    
    init( ttl: String, desc: String, sx: Int, sy: Int, spriteName: String ) {
        
        title = ttl
        descr = desc
        inventorySizeX = sx
        inventorySizeY = sy
        sprite = spriteName
        
        let texture = SKTexture(imageNamed: spriteName)
        toolTipSN = ToolTipSpriteNode(tex: SKTexture(imageNamed: sprite + "TOOLTIP"), infoA: "SizeX: " + String( inventorySizeX ), infoB: "SizeY: " + String( inventorySizeY ) )
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        toolTipSN.position = CGPointZero
        toolTipSN.zPosition = 2.0
        toolTipSN.size = CGSize.zeroSize
        self.addChild( toolTipSN )
        self.userInteractionEnabled = true
        
    }

    override func mouseDown( theEvent: NSEvent ) {
        
        var infoLabelA = SKLabelNode(text: toolTipSN.itemInfoA)
        var infoLabelB = SKLabelNode(text: toolTipSN.itemInfoB)
        infoLabelA.fontColor = SKColor.whiteColor()
        infoLabelB.fontColor = SKColor.whiteColor()
        infoLabelA.fontSize = 12
        infoLabelB.fontSize = 12
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
    
    /* FROM APPLE. APPARENTLY NECESSARY IF I'M INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}