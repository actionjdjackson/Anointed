//
//  ToolTipSpriteNode.swift
//  Anointed
//
//  Created by Jacob Jackson on 7/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//


import Foundation
import SpriteKit

class ToolTipSpriteNode : SKSpriteNode {
    
    var itemInfoA : String
    var itemInfoB : String
    
    init( tex : SKTexture, infoA: String, infoB: String ) {
        
        itemInfoA = infoA
        itemInfoB = infoB
        super.init(texture: tex, color: SKColor.clearColor(), size: tex.size())
        self.userInteractionEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown( theEvent: NSEvent ) {
    
        self.size = texture!.size()
        
    }
    
    override func mouseUp( theEvent : NSEvent ) {

        self.size = CGSize( width: 0, height: 0 )
        
    }
    
}
