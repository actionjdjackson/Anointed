//
//  UnderstandingElement.swift
//  Anointed
//
//  Created by Jacob Jackson on 10/3/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class UnderstandingElement: SKSpriteNode {
    
    let understanding : Understanding
    
    init( theUnderstanding: Understanding ) {
        
        understanding = theUnderstanding
        super.init(texture: SKTexture(imageNamed: "UnderstandingElement"), color: NSColor.clearColor(), size: CGSize(width: 32, height: 32))
        self.userInteractionEnabled = true
        
        let titleText = SKLabelNode(text: understanding.title)
        titleText.fontColor = SKColor.whiteColor()
        titleText.fontName = "Arial"
        titleText.fontSize = 12
        titleText.position = CGPoint.zero
        titleText.position.y -= 20
        titleText.name = understanding.title
        self.addChild(titleText)
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
        let scriptureText = SKLabelNode(text: understanding.scripture)
        scriptureText.fontColor = SKColor.whiteColor()
        scriptureText.fontName = "Arial"
        scriptureText.fontSize = 12
        scriptureText.position = CGPoint.zero
        scriptureText.position.y -= 40
        self.addChild(scriptureText)
        
        let descriptionText = SKMultiLineLabel(theText: understanding.description, theWidth: 30, fontsize: 12)
        descriptionText.position = CGPoint.zero
        descriptionText.position.y -= 60
        self.addChild(descriptionText)
        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        
        for child in self.children {
            if child.name != understanding.title {
                self.removeChildrenInArray([child])
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}