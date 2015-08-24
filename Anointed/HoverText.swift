//
//  HoverText.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/23/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class HoverText: SKLabelNode {
    
    override init() {
        
        super.init()
        self.userInteractionEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* MOUSE MOVED INSIDE THE HOVERTEXT */
    override func mouseMoved(theEvent: NSEvent) {
        
        if theEvent.locationInNode(self).y > self.frame.height / -2 && theEvent.locationInNode(self).y < self.frame.height / 2 {    //if we're inside the frame
            self.fontName = "Arial Bold"    //make the text bold
        } else {    //otherwise,
            self.fontName = "Arial" //make text plain (NOT WORKING... MUST FIX)
        }
        
    }
    
    /* MOUSE CLICK ON THE HOVERTEXT */
    override func mouseDown(theEvent: NSEvent) {
        
        self.parent?.mouseDown( theEvent )
        
    }
    
}