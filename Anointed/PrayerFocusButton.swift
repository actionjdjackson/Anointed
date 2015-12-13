//
//  PrayerFocusButton.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/30/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class PrayerFocusButton : SKNode {

    var button : SKShapeNode    //the button will be a skshapenode
    var selected = false

    /* INITIALIZATION */
    init( focusArea : String ) {
    
        button = SKShapeNode(rectOfSize: CGSize(width: 120, height: 30), cornerRadius: 8.0)  //make a rounded button shape
        button.fillColor = SKColor.blackColor() //make it black
        button.position = CGPoint.zero  //position at zero zero
        let text = SKLabelNode(text: focusArea)    //make a label for it
        text.fontColor = SKColor.whiteColor()   //make the label text white
        text.fontName = "Arial" //make the label font Arial
        text.fontSize = 12  //make the label font size 12
        text.position = CGPoint.zero    //put the initial position of the text at zero zero
        text.position.y -= 6    //move it down a touch
        button.addChild(text)   //add text to button
        super.init()    //super init
        self.name = focusArea
        self.addChild(button)   //add button to self (a placeholder sknode)
        self.userInteractionEnabled = true  //make it clickable
        if UNIVERSE.theGame.player.currentPrayerFocus.contains(self.name!) {
            button.fillColor = SKColor.blueColor()
            self.selected = true
        }
    
    }

    /* ON CLICK */
    override func mouseDown(theEvent: NSEvent) {
        
        button.fillColor = SKColor.redColor()   //make the button red when clicked
        
    }
    
    /* ON RELEASE MOUSE BUTTON */
    override func mouseUp(theEvent: NSEvent) {
        
        if self.selected {
            
            button.fillColor = SKColor.blackColor()
            self.selected = false
            if UNIVERSE.theGame.player.currentPrayerFocus.count > 0 {
                for n in 0...UNIVERSE.theGame.player.currentPrayerFocus.count-1 {
                    if UNIVERSE.theGame.player.currentPrayerFocus[n] == self.name {
                        UNIVERSE.theGame.player.currentPrayerFocus.removeAtIndex(n)
                        break
                    }
                }
            }
            
        } else {
            button.fillColor = SKColor.blueColor()     //make button color blue when released
            UNIVERSE.theGame.player.currentPrayerFocus.append(self.name!)
            self.selected = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}