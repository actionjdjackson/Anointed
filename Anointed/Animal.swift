//
//  Animal.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/26/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* DEFINES AN ANIMAL */
class Animal : SKSpriteNode {
    
    let animalName: String   //name
    let descr: String   //description
    let spriteName: String  //image name for item icon
    
    init( name: String, desc: String, iconName: String ) {
        
        animalName = name
        descr = desc
        spriteName = iconName
        
        let texture = SKTexture(imageNamed: spriteName) //make a texture for the animal's initial state
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size()) //sets up tex, bgcolor, and size
        
    }

    /* FROM APPLE. APPARENTLY NECESSARY IF I'M INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}