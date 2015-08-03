//
//  NonPlayingCharacter.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/24/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class NonPlayingCharacter : GameCharacter {
    
    var selected : Bool = false //initially not selected
    let SELECTION_OUTLINE_SIZE = CGFloat(2.0)   //size of the line for drawing the selection halo
    let SELECTION_OUTLINE_GLOW_SIZE = CGFloat(5.0)  //size of the glow for drawing the selection halo
    
    override init( ) {
        
        super.init( )
        self.userInteractionEnabled = true  //detect mouse clicks, etc.
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* HANDLES MOUSE CLICKS ON NPC */
    override func mouseDown( theEvent: NSEvent ) {
        
        if selected == true {   //if already selected
            self.removeAllChildren()    //remove halo
            selected = false    //now deselected
        } else {    //if not already selected
            selected = true //we are now selected
            var outlineBox : SKShapeNode    //new shapenode
            outlineBox = SKShapeNode(rectOfSize: self.texture!.size(), cornerRadius: 10)    //make rounded rectangle
            outlineBox.lineWidth = SELECTION_OUTLINE_SIZE //set line width for halo
            outlineBox.strokeColor = SKColor.whiteColor()   //set color for halo
            outlineBox.glowWidth = SELECTION_OUTLINE_GLOW_SIZE  //set glow width for halo
            self.addChild(outlineBox)   //add halo to NPC
        }
        
    }
    
}