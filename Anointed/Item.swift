//
//  Item.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Item : SKSpriteNode {
    
    let title: String
    let descr: String
    let inventorySizeX: Int
    let inventorySizeY: Int
    let spriteName: String
    
    init( ttl: String, desc: String, sx: Int, sy: Int, iconName: String ) {
        
        title = ttl
        descr = desc
        inventorySizeX = sx
        inventorySizeY = sy
        spriteName = iconName
        
        let texture = SKTexture(imageNamed: spriteName)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}