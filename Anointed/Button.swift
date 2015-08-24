//
//  Button.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/3/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class Button : SKSpriteNode {
    
    var imageToShow : SKSpriteNode
    
    init( tex : SKTexture, image : String ) {
        
        imageToShow = SKSpriteNode(imageNamed: image)
        super.init(texture: tex, color: NSColor.clearColor(), size: tex.size())
        self.userInteractionEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
        imageToShow.position = CGPoint.zeroPoint
        self.addChild(imageToShow)
        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        
        self.removeAllChildren()
        
    }
    
}