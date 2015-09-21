//
//  StudySectionLabel.swift
//  Anointed
//
//  Created by Jacob Jackson on 9/19/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class StudySectionLabel : SKMultiLineLabel {
    
    var scripture : String
    var highlighted : Bool = false
    
    init( theText : String, theWidth : Int, scrip : String) {
        
        scripture = scrip
        super.init(theText: theText, theWidth: theWidth, fontsize: 12)
        self.userInteractionEnabled = true
        
    }

    override func mouseDown(theEvent: NSEvent) {
        
        
        if !highlighted {
            
            let theMenu = self.parent as! SKSpriteNode
            for child in theMenu.children {
                if child is StudySectionLabel {
                    let ssl : StudySectionLabel = child as! StudySectionLabel
                    if ssl.highlighted {
                        ssl.highlightInColor(SKColor.whiteColor())
                        ssl.highlighted = false
                    }
                } else if child is SKMultiLineLabel {
                    let mll = child as! SKMultiLineLabel
                    if mll.name!.hasSuffix("ENG") {
                        mll.removeFromParent()
                    }
                }
            }
            
            self.highlightInColor(SKColor.redColor())
            self.highlighted = true
            
            for child in theMenu.children {
                if child is Scroll {
                    let theScroll = child as! Scroll
                    let englishText = SKMultiLineLabel(theText: theScroll.studySections[scripture]![1], theWidth: 60, fontsize: 12)    //get text in english
                    englishText.position = CGPoint(x: 256 + 32, y: 128 + 32 + 16)   //position appropriately
                    englishText.zPosition = 2.0     //put behind text blockers, but in front of menu background
                    englishText.name = scripture + "ENG"    //name this multilinelabel "_SCRIPTURE_ENG"
                    
                    if UNIVERSE.theGame.knowledgeBase[scripture] != nil {
                        let titleLabel = SKLabelNode(text: UNIVERSE.theGame.knowledgeBase[scripture]!.title)
                        let scripLabel = SKLabelNode(text: scripture)
                        let descLabel = SKMultiLineLabel(theText: UNIVERSE.theGame.knowledgeBase[scripture]!.description, theWidth: 30, fontsize: 18)
                        titleLabel.fontName = "Arial"
                        titleLabel.fontSize = 18
                        titleLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 20)
                        titleLabel.zPosition = 2.0
                        titleLabel.name = scripture + " (Knowledge Title)"
                        scripLabel.fontName = "Arial"
                        scripLabel.fontSize = 18
                        scripLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 40)
                        scripLabel.zPosition = 2.0
                        scripLabel.name = scripture + " (Knowledge Scripture)"
                        descLabel.position = CGPoint(x: 0, y: -englishText.pixelLength - 60)
                        descLabel.zPosition = 2.0
                        descLabel.name = scripture + " (Knowledge Description)"
                        englishText.addChild(titleLabel)
                        englishText.addChild(scripLabel)
                        englishText.addChild(descLabel)
                    }
                    
                    theMenu.addChild(englishText)   //add to open menu
                    
                }
            }
            
        } else {
            
            self.highlightInColor(SKColor.whiteColor())
            
            self.highlighted = false
            
            let theMenu = self.parent as! SKSpriteNode
            for child in theMenu.children {
                if child is SKMultiLineLabel {
                    let mll = child as! SKMultiLineLabel
                    if mll.name!.hasSuffix("ENG") {
                        mll.removeFromParent()
                    }
                }
            }
            
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}