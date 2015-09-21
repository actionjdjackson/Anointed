//
//  Scroll.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/16/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* DEFINES A SCROLL OBJECT, WITH 3 DIFFERENT SIZES, TEXT FILE SOURCE, LANGUAGE, TITLE, AND DESCRIPTION */
class Scroll: Item {
    
    let fileName : String
    let text : String
    let ENGtext: String
    let language: String
    var selected : Bool = false
    var knowledge : [Knowledge]
    var studySections : [String : [String]]
    let SELECTION_OUTLINE_SIZE = CGFloat(2.0)   //size of the line for drawing the selection halo
    let SELECTION_OUTLINE_GLOW_SIZE = CGFloat(5.0)  //size of the glow for drawing the selection halo
    
    init( ttl: String, desc: String, textFile: String, lang: String, scrollSize: Int, knowl: [Knowledge] ) {
        
        fileName = textFile
        var path = NSBundle.mainBundle().pathForResource(textFile + lang, ofType: "txt")!  //grabs text file path for this scroll
        text = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)    //grab the text and put in string "text"
        path = NSBundle.mainBundle().pathForResource(textFile + "ENG", ofType: "txt")!  //grabs text file with added "ENG" for english translation
        ENGtext = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding) //grab the text of the english translation and put in string "ENGtext"
        language = lang //set language of scroll
        
        knowledge = knowl
        studySections = [:]
        
        for knowledgeElement in knowledge {
            
            let separators = NSCharacterSet.punctuationCharacterSet()
            let words = knowledgeElement.scripture.componentsSeparatedByCharactersInSet(separators)
            //println(words[1] + "-" + words[2])
            var ENGverses = ENGtext.componentsSeparatedByString(":")
            var verses = text.componentsSeparatedByString("׃")
            let startVerse : Int = Int(words[1])!
            let endVerse : Int = Int(words[2])!
            var ENGsection = ""
            var section = ""
            for n in startVerse...endVerse {
                //println(verses[n])
                section += verses[n]
                ENGsection += ENGverses[n]
            }
            studySections[textFile + ":" + String(startVerse) + "-" + String(endVerse)] = [section, ENGsection]
            //println(studySections)
            
        }
        
        //println(studySections)
        
        if scrollSize == 1 {
            super.init(ttl: ttl, desc: desc, sx: 1, sy: 1, spriteName: "smallScroll")   //1 means small scroll size and graphic
        } else if scrollSize == 2 {
            super.init(ttl: ttl, desc: desc, sx: 2, sy: 1, spriteName: "mediumScroll")  //2 means medium scroll size and graphic
        } else if scrollSize >= 3 {
            super.init(ttl: ttl, desc: desc, sx: 2, sy: 2, spriteName: "largeScroll")   //3 means large scroll size and graphic
        } else {
            super.init(ttl: ttl, desc: desc, sx: 1, sy: 1, spriteName: "smallScroll") //DEFAULTS TO SMALL SCROLL IMAGE/SIZE
        }
        
    }

    override func mouseDown(theEvent: NSEvent) {
        
        if parent!.name == "KNOWLEDGE" {
            if selected == true {   //if already selected
                
                selected = false    //now deselected
                if soundPlayer != nil {
                    if soundPlayer.playing {
                        soundPlayer.stop()
                    }
                }
                for obj in parent!.children {
                    if obj is SKMultiLineLabel {
                        if obj.name!.hasPrefix(self.fileName) {
                            obj.removeFromParent()
                        } else if obj.name!.hasSuffix("ENG") {
                            obj.removeFromParent()
                        }
                    }
                }
                
                for node in self.children {    //remove halo
                    if node.name == "OUTLINE" {
                        node.removeFromParent()
                    }
                }
                
            } else {    //if not already selected
                
                selected = true //we are now selected
                var outlineBox : SKShapeNode    //new shapenode
                outlineBox = SKShapeNode(rectOfSize: self.texture!.size(), cornerRadius: 10)    //make rounded rectangle
                outlineBox.name = "OUTLINE" //set name for later removal
                outlineBox.lineWidth = SELECTION_OUTLINE_SIZE //set line width for halo
                outlineBox.strokeColor = SKColor.whiteColor()   //set color for halo
                outlineBox.glowWidth = SELECTION_OUTLINE_GLOW_SIZE  //set glow width for halo
                self.addChild(outlineBox)   //add halo to NPC
                
                var yOffset = 0 //start y offset at zero
                for knowledgeElement in knowledge { //for each nugget of knowledge in this scroll
                    
                    let originalText = StudySectionLabel(theText: studySections[knowledgeElement.scripture]![0], theWidth: 60, scrip: knowledgeElement.scripture)    //get text in original language
                    originalText.position = CGPoint(x: -128, y: 128 + 32 + 16 - yOffset)  //position appropriately
                    originalText.zPosition = 2.0    //put behind text blockers, but in front of menu background
                    originalText.name = knowledgeElement.scripture  //name this multilinelabel "ORIGINAL"
                    parent!.addChild(originalText)  //add to open menu
                    yOffset += Int(originalText.pixelLength) //don't pile them on top of eachother, move down along the y-axis
                    
                }
                
                //let playENGAudioButton : PlaySoundButton = PlaySoundButton(tex: SKTexture(imageNamed: "playENGAudioButton"), sound: self.fileName + "ENG" + ".mp3")
                //playENGAudioButton.position = CGPoint.zero
                //parent!.addChild(playENGAudioButton)
                
            }
            
        } else {
            
            super.mouseDown(theEvent)   //do what you normally do for an item (show the tooltip)
            
        }
        
    }
    
    /*override func mouseDragged(theEvent: NSEvent) {
        
        if self.parent!.name == "KNOWLEDGE" {
            self.position.x += theEvent.deltaX
            self.position.y -= theEvent.deltaY
        }
        
    }*/
    
    /* REQUIRED BY APPLE FOR ANYTHING INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}