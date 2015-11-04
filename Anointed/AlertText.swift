//
//  AlertText.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/4/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class AlertText: SKLabelNode {
    
    init( alertText : String ) {
        
        super.init()
        self.text = alertText
        self.fontSize = 18
        self.fontName = "Arial"
        self.fontColor = SKColor.whiteColor()
        self.position = CGPoint.zero
        self.zPosition = 100
        UNIVERSE.theGame.player.addChild(self)
        self.fadeOut()
        
    }
    
    internal func fadeOut() {
        
        let fadeout : SKAction = SKAction.fadeOutWithDuration(5)
        self.runAction(fadeout, completion: {
            
            self.removeFromParent()
            UNIVERSE.alertCount--
            
        })
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}