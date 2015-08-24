//
//  MenuItem.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/23/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MenuItem : SKNode {
    
    var menuText : SKLabelNode  //the text of the menu
    var backgroundBox : SKShapeNode //the background box
    
    init( theText: String ) {
        
        menuText = HoverText()  //new hovertext
        menuText.text = theText //text is as passed in
        menuText.fontName = "Arial" //font assignment
        menuText.fontSize = 12  //size
        menuText.color = SKColor.whiteColor()   //color
        menuText.position = CGPoint(x: 0, y: menuText.fontSize / -2)    //center vertically on background box
        menuText.zPosition = 100.0  //put way out in front
        backgroundBox = SKShapeNode(rectOfSize: CGSize(width: Int(count(menuText.text)) * Int(menuText.fontSize / 2) + 16, height: 32), cornerRadius: 3)    //appropriate sized background box
        backgroundBox.fillColor = SKColor.blackColor()  //make it black
        backgroundBox.lineWidth = 2 //make a 2pt outline
        backgroundBox.strokeColor = SKColor.whiteColor()    //outline is white
        backgroundBox.position = CGPoint(x: 0, y: 0)    //background box is centered
        backgroundBox.zPosition = 99.0  //slightly behind the text
        super.init()    //super init
        self.userInteractionEnabled = true  //detect mouse clicks, etc.
        self.addChild(backgroundBox)    //add backround box
        self.addChild(menuText) //add text
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** HANDLES MOUSE CLICK EVENTS **/
    override func mouseDown(theEvent: NSEvent) {
    
        backgroundBox.fillColor = SKColor.blueColor()   //makes the box blue
        var par = self.parent as! NonPlayingCharacter   //grabs the npc we're associated with (the player right clicked on the npc that is the parent of this menu)
        var answer : String //answer text
        answer = par.conversation.informationToBeShared[menuText.text]! //grab the answer from the infotobeshared dictionary
        var response = SKLabelNode(text: answer)    //make a label node
        response.fontSize = 12  //same size
        response.fontName = "Arial" //same font
        response.fontColor = SKColor.whiteColor()   //same color
        response.position = CGPoint(x: 0, y: 128 - 32)  //above the NPC
        response.zPosition = 100.0  //on top of everything
        
        var fade = SKAction.fadeOutWithDuration(NSTimeInterval(10)) //fade out over 10 seconds
        
        self.addChild(response) //add response text above NPC
        response.runAction(fade)    //start fading out
        
        
    }
    
}