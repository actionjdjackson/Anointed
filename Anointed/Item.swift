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
    
    let title: String   //title
    let descr: String   //description
    let inventorySizeX: Int //dimensions in inventory screen
    let inventorySizeY: Int //""
    public let spriteName: String  //image name for item icon
    
    init( ttl: String, desc: String, sx: Int, sy: Int, iconName: String ) {
        
        title = ttl
        descr = desc
        inventorySizeX = sx
        inventorySizeY = sy
        spriteName = iconName
        
        let texture = SKTexture(imageNamed: spriteName) //make a texture from the icon/sprite image
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size()) //sets up tex, bgcolor, and size
        
    }

    /* FROM APPLE. APPARENTLY NECESSARY IF I'M INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}