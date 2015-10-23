//
//  MeditationButton.swift
//  Anointed
//
//  Created by Jacob Jackson on 10/2/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MeditationButton: SKNode {
    
    var button : SKShapeNode    //the button will be a skshapenode
    
    /* INITIALIZATION */
    override init() {
        
        button = SKShapeNode(rectOfSize: CGSize(width: 80, height: 30), cornerRadius: 8.0)  //make a rounded button shape
        button.fillColor = SKColor.blackColor() //make it black
        button.position = CGPoint.zero  //position at zero zero
        let text = SKLabelNode(text: "Meditate")    //make a label for it
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
        meditateOn(self.name!)  //meditate on the scripture associated with the meditation button (stored in the name variable of the meditationbutton)
        
    }
    
    /* MEDITATION CODE */
    func meditateOn( scrip : String ) {     //input the scripture
        
        UNIVERSE.theGame.meditating = true  //game is in meditation mode (no clicks or keypresses are registered)
        let blackBackground = SKShapeNode(rectOfSize: CGSize(width: 1680, height: 1050))    //make a giant rectangle to cover the whole screen
        blackBackground.name = "MEDITATION BACKGROUND"  //name it MEDITATION BACKGROUND
        blackBackground.fillColor = SKColor.blackColor()    //make it black
        blackBackground.strokeColor = SKColor.blackColor()  //with a black outline
        blackBackground.position = CGPoint.zero //position at zero zero
        blackBackground.zPosition = 10.0    //put above everything else
        parent!.parent!.parent?.addChild(blackBackground)   //add to game scene
        var i = 0   //init child counter
        for child in (parent!.parent?.children)! {  //for all children in the menu
            
            if child is StudySectionLabel {     //if it's a study section label
                
                let ssl = child as! StudySectionLabel   //grab it
                
                ssl.setScale(1.0)
                ssl.alpha = 1.0
                
                let rotateFast = SKAction.rotateByAngle(6.28, duration: 1.0)    //set up a fast rotate action
                ssl.runAction(rotateFast)   //run the rotate action on the ssl
                
                ssl.highlightInColor(SKColor.redColor())   //highlight this studysectionlabel in red
                ssl.highlighted = true     //set to highlighted
                    
                if UNIVERSE.theGame.knowledgeBase[ssl.scripture] != nil {   //if there's knowledge for this scripture
                    
                    let titleLabel = SKLabelNode(text: UNIVERSE.theGame.knowledgeBase[ssl.scripture]!.title)    //make a title label
                    let scripLabel = SKLabelNode(text: ssl.scripture)   //make a scripture label
                    let descLabel = SKMultiLineLabel(theText: UNIVERSE.theGame.knowledgeBase[ssl.scripture]!.description, theWidth: 30, fontsize: 18)   //make a description multilinelabel
                    titleLabel.fontName = "Arial"   //set font for title
                    titleLabel.fontSize = 18        //set size for title
                    titleLabel.position = CGPoint(x: 0, y: ssl.pixelLength - 80)   //position appropriately
                    titleLabel.zPosition = 2.0  //set zPosition above menu but below textblockers
                    titleLabel.name = ssl.scripture + " (Knowledge Title)"  //name the title label "_SCRIPTURE_ (Knowledge Title)"
                    scripLabel.fontName = "Arial"   //set font for scripture
                    scripLabel.fontSize = 18    //set size for scripture
                    scripLabel.position = CGPoint(x: 0, y: ssl.pixelLength - 100)   //position appropriately
                    scripLabel.zPosition = 2.0  //set zPosition above menu but below textblockers
                    scripLabel.name = ssl.scripture + " (Knowledge Scripture)"  //name the scripture label "_SCRIPTURE_ (Knowledge Scripture)"
                    descLabel.position = CGPoint(x: 0, y: ssl.pixelLength - 120)    //position description label appropriately
                    descLabel.zPosition = 2.0   //set description label zPosition above menu but below textblockers
                    descLabel.name = ssl.scripture + " (Knowledge Description)" //name description label "_SCRIPTURE_ (Knowledge Description)"
                    ssl.addChild(titleLabel)    //add to ssl
                    ssl.addChild(scripLabel)    //add to ssl
                    ssl.addChild(descLabel)     //add to ssl
                        
                }
                
                ssl.zPosition = 11.0    //put on top of everything, including the black background
                ssl.removeFromParent()  //remove from it's current parent
                ssl.position = CGPoint.zero //set it at zero zero
                blackBackground.addChild(ssl)   //add to the black background
                let fadeout = SKAction.fadeOutWithDuration(3.0) //set up fade out action
                let moveAround = SKAction.followPath(CGPathCreateWithEllipseInRect(CGRect(origin: CGPoint(x: -400, y: -300), size: CGSize(width: 800, height: 600)), nil), asOffset: false, orientToPath: false, speed: CGFloat(100 - i*10))    //set up move around action, an elliptical path of size 800x600, slower and slower for each ssl so they spread out nicely
                ssl.runAction(SKAction.repeatAction(moveAround, count: 2), completion: {    //run the move around action twice, then...
                    
                    ssl.runAction(fadeout, completion: {    //run the fade out action, and then...
                        
                        ssl.removeFromParent()  //remove from the black background
                        if blackBackground.children.count == 2 {    //if we're down to just the "realized" understanding title and description
                            
                            blackBackground.removeFromParent()  //remove the black background from the scene
                            UNIVERSE.theGame.meditating = false //game is no longer in meditation mode
                            UNIVERSE.theGame.player.understanding.append(UNIVERSE.theGame.understandingBase[scrip]!)    //add understanding acquired to player
                            
                        }
                        
                    })
                    
                })
                i++ //increment child counter
                
                
            } else if child is SKMultiLineLabel {   //if it's an SKMultiLineLabel and not a StudySectionLabel
                
                let mll = child as! SKMultiLineLabel    //grab it
                
                mll.setScale(1.0)
                mll.alpha = 1.0
                
                for label in mll.children {     //for each child in mll
                    if label is SKLabelNode {   //if it's a label
                        if label.name == scrip + " (Understanding Requires Meditation)" {   //if it's the meditation notice label
                            let theLabel = label as! SKLabelNode    //grab it
                            theLabel.text = "MEDITATING"    //set text to "MEDITATING"
                        }
                    }
                }
                mll.highlightInColor(SKColor.whiteColor())  //make it white text
                mll.zPosition = 11.0    //put it above the black background
                mll.removeFromParent()  //remove from current parent
                mll.position = CGPoint.zero //set at zero zero
                blackBackground.addChild(mll)   //add to black background
                let enlarge = SKAction.scaleBy(3, duration: 60) //make an enlargement action
                let fadeout = SKAction.fadeOutWithDuration(3.0) //make a fade out action
                let fadein = SKAction.fadeInWithDuration(5.0)   //make a fade in action (for the resulting understanding element at end of meditation cycle)
                mll.runAction(enlarge, completion: {    //run enlarge action and then...
                    
                    mll.runAction(fadeout, completion: {    //run the fadeout action and then...
                        
                        mll.removeFromParent()  //remove from parent
                        
                    })
                    
                    let understandingCompletedTitle = SKLabelNode(text: UNIVERSE.theGame.understandingBase[scrip]?.title)   //make a label for the understanding title
                    understandingCompletedTitle.fontColor = SKColor.whiteColor()    //make it white
                    understandingCompletedTitle.fontSize = 48   //make it size 48
                    understandingCompletedTitle.fontName = "Arial"  //make it Arial
                    understandingCompletedTitle.position = CGPoint.zero //set it at zero zero
                    understandingCompletedTitle.zPosition = 11.0    //set above black background
                    understandingCompletedTitle.alpha = 0.0 //make it fully transparent

                    let understandingCompletedDescription = SKMultiLineLabel(theText: (UNIVERSE.theGame.understandingBase[scrip]?.description)!, theWidth: 30, fontsize: 16)    //make a mll for the understanding description
                    understandingCompletedDescription.highlightInColor(SKColor.whiteColor())    //make it white
                    understandingCompletedDescription.position = CGPoint(x: 0, y: -24)  //put it just below the title text
                    understandingCompletedDescription.zPosition = 11.0  //put it above black background
                    understandingCompletedDescription.alpha = 0.0   //make it fully transparent
                    
                    blackBackground.addChild(understandingCompletedTitle)   //add title to black background
                    blackBackground.addChild(understandingCompletedDescription) //add description to black background
                    understandingCompletedTitle.runAction(fadein)   //run fade in action on title
                    understandingCompletedDescription.runAction(fadein) //run fade in action on description
                    
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