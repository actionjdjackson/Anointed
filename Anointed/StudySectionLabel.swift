//
//  StudySectionLabel.swift
//  Anointed
//
//  Created by Jacob Jackson on 9/19/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class StudySectionLabel : SKMultiLineLabel {    //inherit from SKmultilinelabel
    
    var scripture : String
    var highlighted : Bool = false
    
    init( theText : String, theWidth : Int, scrip : String) {
        
        scripture = scrip
        super.init(theText: theText, theWidth: theWidth, fontsize: 12)
        self.userInteractionEnabled = true
        
    }

    override func mouseDown(theEvent: NSEvent) {    //on mouse down
        
        if !highlighted {   //if not already highlighted
            
            /* REMOVES THE HIGHLIGHTING FROM ALL OTHER STUDYSECTIONLABELS AND REMOVES ENGLISH TRANSLATION W/ ALL K/W/U INCLUDED */
            if self.parent is SKSpriteNode {
                let theMenu = self.parent as! SKSpriteNode  //grab the menu
                for child in theMenu.children {     //for each child in the menu
                    if child is StudySectionLabel {     //if the child is a studysectionlabel
                        let ssl : StudySectionLabel = child as! StudySectionLabel   //grab the studysectionlabel
                        if ssl.highlighted {    //if it's already highlighted
                            ssl.highlightInColor(SKColor.whiteColor())  //make it white text (not highlighted)
                            ssl.highlighted = false //set to no longer highlighted
                        }
                    } else if child is SKMultiLineLabel {   //if the child is a regular SKmultilinelabel
                        let mll = child as! SKMultiLineLabel    //grab the multilinelabel
                        if mll.name!.hasSuffix("ENG") {     //if it's in english
                            mll.removeFromParent()      //remove from menu
                        }
                    }
                
                }
                
                /* HIGHLIGHTS CURRENT STUDYSECTIONLABEL */
                self.highlightInColor(SKColor.redColor())   //highlight this studysectionlabel in red
                self.highlighted = true     //set to highlighted
                
                /* DISPLAYS ENGLISH TRANSLATION OF STUDYSECTION WITH ALL K/W/U ELEMENTS INCLUDED */
                for child in theMenu.children {     //for each child in the menu
                    
                    if child is Scroll {    //if child is scroll
                        
                        let theScroll = child as! Scroll    //grab the scroll
                        let englishText = SKMultiLineLabel(theText: theScroll.studySections[scripture]![1], theWidth: 60, fontsize: 12)    //get text in english
                        englishText.position = CGPoint(x: 256 + 32, y: 128 + 32 + 16)   //position appropriately
                        englishText.zPosition = 2.0     //put behind text blockers, but in front of menu background
                        englishText.name = scripture + "ENG"    //name this multilinelabel "_SCRIPTURE_ENG"
                        
                        /* GRAB KNOWLEDGE */
                        if UNIVERSE.theGame.knowledgeBase[scripture] != nil && !UNIVERSE.theGame.player.knowsScripture(scripture) {   //if there's knowledge for this scripture, and the player doesn't already have it memorized...
                            
                            let titleLabel = SKLabelNode(text: UNIVERSE.theGame.knowledgeBase[scripture]!.title)    //make a title label
                            let scripLabel = SKLabelNode(text: scripture)   //make a scripture label
                            let descLabel = SKMultiLineLabel(theText: UNIVERSE.theGame.knowledgeBase[scripture]!.description, theWidth: 30, fontsize: 18)   //make a description multilinelabel
                            titleLabel.fontName = "Arial"   //set font for title
                            titleLabel.fontSize = 18        //set size for title
                            titleLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 20)   //position appropriately
                            titleLabel.zPosition = 2.0  //set zPosition above menu but below textblockers
                            titleLabel.name = scripture + " (Knowledge Title)"  //name the title label "_SCRIPTURE_ (Knowledge Title)"
                            scripLabel.fontName = "Arial"   //set font for scripture
                            scripLabel.fontSize = 18    //set size for scripture
                            scripLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 40)   //position appropriately
                            scripLabel.zPosition = 2.0  //set zPosition above menu but below textblockers
                            scripLabel.name = scripture + " (Knowledge Scripture)"  //name the scripture label "_SCRIPTURE_ (Knowledge Scripture)"
                            descLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 60)    //position description label appropriately
                            descLabel.zPosition = 2.0   //set description label zPosition above menu but below textblockers
                            descLabel.name = scripture + " (Knowledge Description)" //name description label "_SCRIPTURE_ (Knowledge Description)"
                            englishText.addChild(titleLabel)    //add to englishText
                            englishText.addChild(scripLabel)    //add to englishText
                            englishText.addChild(descLabel)     //add to englishText
                            let memorize = MemorizationButton()
                            memorize.position = CGPoint(x: 0, y: -englishText.pixelLength - 120)
                            memorize.zPosition = 2.0
                            memorize.name = scripture
                            englishText.addChild(memorize)
                            
                            /* GRAB UNDERSTANDING */
                        } else if UNIVERSE.theGame.understandingBase[scripture] != nil && !UNIVERSE.theGame.player.knowsScripture(scripture) {    //if there's understanding for this scripture
                            
                            if UNIVERSE.theGame.understandingBase[scripture]!.knowledge.count > 0 {     //if the understanding comes from knowledge
                                
                                let titleLabel = SKLabelNode(text: "REQUIRES MEDITATION")   //title created is "REQUIRES MEDITATION"
                                let scripLabel = SKLabelNode(text: scripture)   //scripture label created
                                titleLabel.fontName = "Arial"   //set font for title
                                titleLabel.fontSize = 24        //set size for title
                                titleLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 20)   //position appropriately
                                titleLabel.zPosition = 2.0  //set zPosition above menu but below textblockers
                                titleLabel.name = scripture + " (Understanding Requires Meditation)"    //name the title label "_SCRIPTURE_ (Understanding Requires Meditation"
                                scripLabel.fontName = "Arial"   //set font for scripture
                                scripLabel.fontSize = 18        //set size for scripture
                                scripLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 40)   //position appropriately
                                scripLabel.zPosition = 2.0      //set zPosition above menu but below textblockers
                                scripLabel.name = scripture + " (Understanding Scripture)"  //name the scripture label "_SCRIPTURE_ (Understanding Scripture)"
                                englishText.addChild(titleLabel)    //add to englishText
                                englishText.addChild(scripLabel)    //add to englishText
                                let meditate = MeditationButton()
                                meditate.position = CGPoint(x: 0, y: -englishText.pixelLength - 80)
                                meditate.zPosition = 2.0
                                meditate.name = scripture
                                englishText.addChild(meditate)
                                
                            } else if !UNIVERSE.theGame.player.knowsScripture(scripture) {    //if the understanding comes from scripture alone
                                
                                /* Do the same thing as with knowledge */
                                let titleLabel = SKLabelNode(text: UNIVERSE.theGame.understandingBase[scripture]!.title)
                                let scripLabel = SKLabelNode(text: scripture)
                                let descLabel = SKMultiLineLabel(theText: UNIVERSE.theGame.understandingBase[scripture]!.description, theWidth: 30, fontsize: 18)
                                titleLabel.fontName = "Arial"
                                titleLabel.fontSize = 18
                                titleLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 20)
                                titleLabel.zPosition = 2.0
                                titleLabel.name = scripture + " (Understanding Title)"
                                scripLabel.fontName = "Arial"
                                scripLabel.fontSize = 18
                                scripLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 40)
                                scripLabel.zPosition = 2.0
                                scripLabel.name = scripture + " (Understanding Scripture)"
                                descLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 60)
                                descLabel.zPosition = 2.0
                                descLabel.name = scripture + " (Understanding Description)"
                                englishText.addChild(titleLabel)
                                englishText.addChild(scripLabel)
                                englishText.addChild(descLabel)
                                let memorize = MemorizationButton()
                                memorize.position = CGPoint(x: 0, y: -englishText.pixelLength - 120)
                                memorize.zPosition = 2.0
                                memorize.name = scripture
                                englishText.addChild(memorize)
                            }
                            
                            /* GRAB WISDOM */
                        } else if UNIVERSE.theGame.wisdomBase[scripture] != nil && !UNIVERSE.theGame.player.knowsScripture(scripture){   //if there's wisdom for this scipture
                            
                            /* Do the same thing as with understanding */
                            if UNIVERSE.theGame.wisdomBase[scripture]!.understanding.count > 0 || UNIVERSE.theGame.wisdomBase[scripture]!.knowledge.count > 0 { //if it comes from understanding and/or knowledge
                                
                                let titleLabel = SKLabelNode(text: "REQUIRES MEDITATION")
                                let scripLabel = SKLabelNode(text: scripture)
                                titleLabel.fontName = "Arial"
                                titleLabel.fontSize = 24
                                titleLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 20)
                                titleLabel.zPosition = 2.0
                                titleLabel.name = scripture + " (Wisdom Requires Meditation)"
                                scripLabel.fontName = "Arial"
                                scripLabel.fontSize = 18
                                scripLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 40)
                                scripLabel.zPosition = 2.0
                                scripLabel.name = scripture + " (Wisdom Scripture)"
                                englishText.addChild(titleLabel)
                                englishText.addChild(scripLabel)
                                
                            } else if !UNIVERSE.theGame.player.knowsScripture(scripture) {    //if it comes from scripture alone
                                
                                let titleLabel = SKLabelNode(text: UNIVERSE.theGame.wisdomBase[scripture]!.title)
                                let scripLabel = SKLabelNode(text: scripture)
                                let descLabel = SKMultiLineLabel(theText: UNIVERSE.theGame.wisdomBase[scripture]!.description, theWidth: 30, fontsize: 18)
                                titleLabel.fontName = "Arial"
                                titleLabel.fontSize = 18
                                titleLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 20)
                                titleLabel.zPosition = 2.0
                                titleLabel.name = scripture + " (Wisdom Title)"
                                scripLabel.fontName = "Arial"
                                scripLabel.fontSize = 18
                                scripLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 40)
                                scripLabel.zPosition = 2.0
                                scripLabel.name = scripture + " (Wisdom Scripture)"
                                descLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 60)
                                descLabel.zPosition = 2.0
                                descLabel.name = scripture + " (Wisdom Description)"
                                englishText.addChild(titleLabel)
                                englishText.addChild(scripLabel)
                                englishText.addChild(descLabel)
                                
                            }
                            
                        }
                        
                        theMenu.addChild(englishText)   //add englishText to open menu
                        
                    }
                }
                
            } else if self.parent is SKShapeNode {
                
                
                
            }
            
        } else {    //if already highlighted
            
            /* REMOVES THE ENGLISH EXPLANATION ON RIGHT OF SCREEN (ASSOCIATED WITH THIS SSL */
            if self.parent is SKSpriteNode {
                let theMenu = self.parent as! SKSpriteNode  //grab the menu
                for child in theMenu.children {     //for each child in the menu
                    if child is SKMultiLineLabel {  //if it's a SKMLL
                        let mll = child as! SKMultiLineLabel    //grab the SKMLL
                        if mll.name!.hasSuffix("ENG") {     //if it's in english
                            mll.removeFromParent()  //remove from menu
                        }
                    }
                }
                self.highlightInColor(SKColor.whiteColor()) //change to white text
                self.highlighted = false    //now no longer highlighted
                
            } else if self.parent is SKShapeNode {
                
                
                
            }
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}