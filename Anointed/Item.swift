//
//  Item.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Item {
    
    let title: String
    let description: String
    let inventorySizeX: Int
    let inventorySizeY: Int
    let spriteName: String
    
    init( ttl: String, desc: String, sx: Int, sy: Int, iconName: String ) {
        
        title = ttl
        description = desc
        inventorySizeX = sx
        inventorySizeY = sy
        spriteName = iconName
        
    }
    
}