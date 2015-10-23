//
//  VisualizeKnowledgeButton.swift
//  Anointed
//
//  Created by Jacob Jackson on 10/3/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class VisualizeKnowledgeButton : SKNode {
    
    var button : SKShapeNode    //the button will be a skshapenode
    
    /* INITIALIZATION */
    override init() {
        
        button = SKShapeNode(rectOfSize: CGSize(width: 120, height: 30), cornerRadius: 8.0)  //make a rounded button shape
        button.fillColor = SKColor.blackColor() //make it black
        button.position = CGPoint.zero  //position at zero zero
        let text = SKLabelNode(text: "Visualize Knowledge")    //make a label for it
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
        visualize()  //meditate on the scripture associated with the meditation button (stored in the name variable of the meditationbutton)
        
    }
    
    /* MEDITATION CODE */
    func visualize() {
        
        let blackBackground = SKShapeNode(rectOfSize: CGSize(width: 1680, height: 1050))    //make a giant rectangle to cover the whole screen
        blackBackground.name = "VISUALIZATION BACKGROUND"  //name it VISUALIZATION BACKGROUND
        blackBackground.fillColor = SKColor.blackColor()    //make it black
        blackBackground.strokeColor = SKColor.blackColor()  //with a black outline
        blackBackground.position = CGPoint.zero //position at zero zero
        blackBackground.zPosition = 10.0    //put above everything else
        parent!.parent!.addChild(blackBackground)   //add to game scene
        
        var knowledgeUsed : [Knowledge] = []
        var understandingUsed : [Understanding] = []
        var wisdomUsed : [Wisdom] = []
        
        for wisdomElement in UNIVERSE.theGame.player.wisdom {
            
            let element = WisdomElement(theWisdom: wisdomElement)
            element.position = CGPoint.zero
            element.position.y += 128
            element.position.x = CGFloat( (UNIVERSE.theGame.player.wisdom as NSArray).indexOfObject(wisdomElement) * 64 - 512 )
            element.zPosition = 11.0
            blackBackground.addChild(element)
            wisdomUsed.append(wisdomElement)
            
            for understandingElement in wisdomElement.understanding {
                
                let element = UnderstandingElement(theUnderstanding: understandingElement)
                element.position = CGPoint.zero
                element.position.y += 64
                element.position.x = CGFloat( (UNIVERSE.theGame.player.understanding as NSArray).indexOfObject(understandingElement) * 64 - 512 )
                element.zPosition = 11.0
                blackBackground.addChild(element)
                understandingUsed.append(understandingElement)
                
                for knowledgeElement in understandingElement.knowledge {
                    
                    let element = KnowledgeElement(theKnowledge: knowledgeElement)
                    element.position = CGPoint.zero
                    element.position.x = CGFloat( (UNIVERSE.theGame.player.knowledge as NSArray).indexOfObject(knowledgeElement) * 64 - 512 )
                    element.zPosition = 11.0
                    blackBackground.addChild(element)
                    knowledgeUsed.append(knowledgeElement)
                    
                }
                
            }
            
            for knowledgeElement in wisdomElement.knowledge {
                
                let element = KnowledgeElement(theKnowledge: knowledgeElement)
                element.position = CGPoint.zero
                element.position.x = CGFloat( (UNIVERSE.theGame.player.knowledge as NSArray).indexOfObject(knowledgeElement) * 64 - 512 )
                element.zPosition = 11.0
                blackBackground.addChild(element)
                knowledgeUsed.append(knowledgeElement)
                
            }
            
        }
        
        for understandingElement in UNIVERSE.theGame.player.understanding {
            
            let element = UnderstandingElement(theUnderstanding: understandingElement)
            element.position = CGPoint.zero
            element.position.y += 64
            element.position.x = CGFloat( (UNIVERSE.theGame.player.understanding as NSArray).indexOfObject(understandingElement) * 64 - 512 )
            element.zPosition = 11.0
            blackBackground.addChild(element)
            understandingUsed.append(understandingElement)
            
            for knowledgeElement in understandingElement.knowledge {
                
                let element = KnowledgeElement(theKnowledge: knowledgeElement)
                element.position = CGPoint.zero
                element.position.x = CGFloat( (UNIVERSE.theGame.player.knowledge as NSArray).indexOfObject(knowledgeElement) * 64 - 512 )
                element.zPosition = 11.0
                blackBackground.addChild(element)
                knowledgeUsed.append(knowledgeElement)
                
            }
            
        }
        
        for knowledgeElement in UNIVERSE.theGame.player.knowledge {
            
            var foundUsed = false
            for ke in knowledgeUsed {
                
                if ke === knowledgeElement {
                 
                    foundUsed = true
                    break
                    
                }
                
            }
            
            if !foundUsed {
                
                let element = KnowledgeElement(theKnowledge: knowledgeElement)
                element.position = CGPoint.zero
                element.position.x += CGFloat((UNIVERSE.theGame.player.knowledge as NSArray).indexOfObject(knowledgeElement)) * CGFloat(64)
                element.position.y += 64
                element.zPosition = 11.0
                blackBackground.addChild(element)
                knowledgeUsed.append(knowledgeElement)
                
            }
            
        }
        
        self.removeFromParent() //remove button from parent
        
    }
    
    /* REQUIRED BY APPLE */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}