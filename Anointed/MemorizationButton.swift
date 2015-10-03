//
//  MemorizationButton.swift
//  Anointed
//
//  Created by Jacob Jackson on 10/2/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MemorizationButton: SKNode {
    
    var button : SKShapeNode    //the button will be a skshapenode
    
    /* INITIALIZATION */
    override init() {
        
        button = SKShapeNode(rectOfSize: CGSize(width: 80, height: 30), cornerRadius: 8.0)  //make a rounded button shape
        button.fillColor = SKColor.blackColor() //make it black
        button.position = CGPoint.zero  //position at zero zero
        let text = SKLabelNode(text: "Memorize")    //make a label for it
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
    
    /* ON CLICK */
    override func mouseDown(theEvent: NSEvent) {
        
        button.fillColor = SKColor.redColor()   //make the button red when clicked
        
    }
    
    /* ON RELEASE MOUSE BUTTON */
    override func mouseUp(theEvent: NSEvent) {
        
        button.fillColor = SKColor.blackColor()     //return to black color when released
        memorize(self.name!)  //meditate on the scripture associated with the meditation button (stored in the name variable of the meditationbutton)
        
    }
    
    /* MEDITATION CODE */
    func memorize( scrip : String ) {     //input the scripture
        
        for child in (parent!.parent?.children)! {  //for all children in the menu
            
            if child is SKMultiLineLabel {   //if it's an SKMultiLineLabel
                
                let mll = child as! SKMultiLineLabel    //grab it
                mll.zPosition = 11.0    //put it above everything
                let shrink = SKAction.scaleBy(0, duration: 3.0) //make an enlargement action
                let fadeout = SKAction.fadeOutWithDuration(1.0) //make a fade out action
                mll.runAction(shrink, completion: {    //run enlarge action and then...
                    
                    mll.runAction(fadeout, completion: {    //run the fadeout action and then...
                        
                        mll.removeFromParent()  //remove from parent
                        
                    })
                    
                })
                
            }
            
        }
        
        self.removeFromParent() //remove button from parent
        
    }
    
    /* REQUIRED BY APPLE */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}