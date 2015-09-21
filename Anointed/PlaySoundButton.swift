//
//  PlaySoundButton.swift
//  Anointed
//
//  Created by Jacob Jackson on 9/18/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class PlaySoundButton : SKSpriteNode {
    
    var soundToPlay : String
    
    init( tex : SKTexture, sound : String ) {
        
        soundToPlay = sound
        super.init(texture: tex, color: NSColor.clearColor(), size: tex.size())
        self.userInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        
        playSound(soundToPlay)
        
    }
    
}