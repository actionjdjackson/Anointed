//
//  PlaySoundButton.swift
//  Anointed
//
//  Created by Jacob Jackson on 9/18/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class PlaySoundButton : SKNode {
    
    var soundToPlay : String
    var button : SKShapeNode    //the button will be a skshapenode
    
    init( buttonText : String, sound : String ) {
        
        soundToPlay = sound
        button = SKShapeNode(rectOfSize: CGSize(width: 6 * (buttonText.characters.count + 4), height: 30), cornerRadius: 8.0)  //make a rounded button shape
        button.fillColor = SKColor.blackColor() //make it black
        button.position = CGPoint.zero  //position at zero zero
        let text = SKLabelNode(text: buttonText)    //make a label for it
        text.fontColor = SKColor.whiteColor()   //make the label text white
        text.fontName = "Arial" //make the label font Arial
        text.fontSize = 12  //make the label font size 12
        text.position = CGPoint.zero    //put the initial position of the text at zero zero
        text.position.y -= 6    //move it down a touch
        button.addChild(text)   //add text to button
        super.init()    //super init
        self.addChild(button)   //add button to self (a placeholder sknode)
        self.userInteractionEnabled = true  //make it clickable
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
        button.fillColor = SKColor.redColor()
        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        
        button.fillColor = SKColor.blackColor()
        playSound(soundToPlay)
        
    }
    
}