//
//  StartScreenLabel.swift
//  Anointed
//
//  Created by Jacob Jackson on 5/10/16.
//  Copyright © 2016 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class StartScreenLabel : SKLabelNode {
    
    override init() {
        super.init()
        self.fontColor = SKColor.whiteColor()
        self.fontSize = 48
        self.fontName = "Arial"
        self.position = CGPoint.zero
        self.text = "DOUBLE-CLICK TO PLAY!"
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
        self.removeFromParent()
        
        UNIVERSE.theScene.createLocation()    //creates the current location in spritekit
        
        UNIVERSE.theScene.orderCorrectly()
        
        UNIVERSE.theScene.setupLowerBanner()  //creates the game function buttons and experience bars on a lower banner
        
        playBackgroundMusic("BackgroundMusicB.mp3") //start background music
        
    }
    
}