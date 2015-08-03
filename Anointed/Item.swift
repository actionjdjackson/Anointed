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
    
    let TOOLTIP_SIZE : CGSize = CGSize( width: 128, height: 128 )   //tooltip size
    let TOOLTIP_Z_POSITION = CGFloat(2.0)    //z position of tooltip
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
        
        let texture = SKTexture(imageNamed: spriteName) //sets temp texture to appropriate sprite
        toolTipSN = ToolTipSpriteNode(tex: SKTexture(imageNamed: sprite + "TOOLTIP"), infoA: "SizeX: " + String( inventorySizeX ), infoB: "SizeY: " + String( inventorySizeY ) )    //grab tooltip image and set displayed info to the sizeX and sizeY values
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size()) //calls super.init with temp texture and with normal size
        toolTipSN.position = CGPointZero    //center on screen
        toolTipSN.zPosition = TOOLTIP_Z_POSITION   //draw above item
        toolTipSN.size = CGSize.zeroSize    //initially hide (zero size)
        self.addChild( toolTipSN )  //add tooltip to the item
        self.userInteractionEnabled = true  //allow clicks and such on item
        
    }

    /* HANDLES MOUSE CLICK ON ITEM */
    override func mouseDown( theEvent: NSEvent ) {
        
        var infoLabelA = SKLabelNode(text: toolTipSN.itemInfoA) //creates a label node with text for info A
        var infoLabelB = SKLabelNode(text: toolTipSN.itemInfoB) //same for info B
        infoLabelA.fontColor = SKColor.whiteColor() //set text color to white
        infoLabelB.fontColor = SKColor.whiteColor() //same
        infoLabelA.fontSize = 12    //set text size to 12
        infoLabelB.fontSize = 12    //same
        infoLabelA.fontName = "Arial"   //set text font to Arial
        infoLabelB.fontName = "Arial"   //same
        infoLabelA.position = CGPoint(x: 0, y: -32) //positions label A to mid-bottom
        infoLabelB.position = CGPoint(x: 0, y: -48) //positions label B to bottom
        toolTipSN.addChild(infoLabelA)  //add label to tooltip
        toolTipSN.addChild(infoLabelB)  //add label to tooltip
        toolTipSN.size = TOOLTIP_SIZE   //make visible (from zeroSize to normal tooltip size)
        
    }
    
    /* HANDLES MOUSE RELEASE */
    override func mouseUp( theEvent : NSEvent ) {
        
        toolTipSN.removeAllChildren()   //remove all labels and such from tooltip
        toolTipSN.size = CGSize.zeroSize    //hides tooltip (zero size)
        
    }
    
    /* FROM APPLE. APPARENTLY NECESSARY IF I'M INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}