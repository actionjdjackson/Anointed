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
    var understanding : [Understanding]
    var wisdom : [Wisdom]
    var studySections : [String : [String]]
    let SELECTION_OUTLINE_SIZE = CGFloat(2.0)   //size of the line for drawing the selection halo
    let SELECTION_OUTLINE_GLOW_SIZE = CGFloat(5.0)  //size of the glow for drawing the selection halo
    
    init( ttl: String, desc: String, textFile: String, lang: String, scrollSize: Int, knowl: [Knowledge], under: [Understanding], wisd : [Wisdom] ) {
        
        fileName = textFile
        var path = NSBundle.mainBundle().pathForResource(textFile + lang, ofType: "txt")!  //grabs text file path for this scroll
        text = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)    //grab the text and put in string "text"
        path = NSBundle.mainBundle().pathForResource(textFile + "ENG", ofType: "txt")!  //grabs text file with added "ENG" for english translation
        ENGtext = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding) //grab the text of the english translation and put in string "ENGtext"
        language = lang //set language of scroll
        
        knowledge = knowl
        understanding = under
        wisdom = wisd
        studySections = [:] //empty dictionary for studysections
        
        for knowledgeElement in knowledge {     //for each knowledge element in the scroll
            
            let separators = NSCharacterSet.punctuationCharacterSet()   //grab the punctuation character set
            let words = knowledgeElement.scripture.componentsSeparatedByCharactersInSet(separators) //separate scripture by punctuation (":" in particular)
            //println(words[1] + "-" + words[2])
            var ENGverses = ENGtext.componentsSeparatedByString(":")    //separate verses in english text of scroll by ":" mark
            var verses = text.componentsSeparatedByString("׃")  //separate verses in original text by "׃" mark
            let startVerse : Int = Int(words[1])!   //grab start verse
            let endVerse : Int = Int(words[2])! //grab end verse
            var ENGsection = "" //set english section to blank string
            var section = ""    //set original language section to blank string
            if startVerse == 1 {    //if we're on verse 1
                section += verses[0]    //grab the first line for original text
                ENGsection += ENGverses[0]  //grab the first line for english text
            }
            for n in startVerse...endVerse {    //from start verse to end verse
                //println(verses[n])
                section += verses[n]    //add verse to original language section
                ENGsection += ENGverses[n]  //add verse to english section
            }
            studySections[textFile + ":" + String(startVerse) + "-" + String(endVerse)] = [section, ENGsection]     //add to studysections
            //println(studySections)
            
        }
        
        /* Do the same thing for understanding elements in scroll */
        for understandingElement in understanding {
            
            let separators = NSCharacterSet.punctuationCharacterSet()
            let words = understandingElement.scripture.componentsSeparatedByCharactersInSet(separators)
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
        
        /* Do the same thing for wisdom elements in scroll */
        for wisdomElement in wisdom {
            
            let separators = NSCharacterSet.punctuationCharacterSet()
            let words = wisdomElement.scripture.componentsSeparatedByCharactersInSet(separators)
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
                
                soundPlayer.stop()
                if backgroundMusicPlayer != nil {
                    backgroundMusicPlayer.play()
                }
                
                selected = false    //now deselected
                for obj in parent!.children {   //for all siblings
                    if obj is SKMultiLineLabel {    //if it's a multilinelabel
                        if obj.name!.hasPrefix(self.fileName) { //if it has prefix of scroll we're currently working with
                            obj.removeFromParent()  //remove the multilinelabel
                        } else if obj.name!.hasSuffix("ENG") {  //if it's an english section
                            obj.removeFromParent()  //remove the multilinelabel
                        }
                    }
                }
                
                for node in self.children {    //for all children of scroll
                    if node.name == "OUTLINE" { //if it's the halo
                        node.removeFromParent() //remove the halo
                    }
                }
                
            } else {    //if not already selected
                
                playSound(self.fileName + self.language + ".mp3")   //play original language clip
                if backgroundMusicPlayer != nil {   //if there is background music
                    if backgroundMusicPlayer.playing {  //if it's playing
                        backgroundMusicPlayer.pause()   //pause the background music
                    }
                }
                
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
                    originalText.name = knowledgeElement.scripture  //name this studysectionlabel after the scripture it contains
                    parent!.addChild(originalText)  //add to open menu
                    yOffset += Int(originalText.pixelLength) //don't pile them on top of eachother, move down along the y-axis
                    
                }
                
                for understandingElement in understanding { //for each nugget of understanding in this scroll
                    
                    let originalText = StudySectionLabel(theText: studySections[understandingElement.scripture]![0], theWidth: 60, scrip: understandingElement.scripture)   //get text in original language
                    originalText.position = CGPoint(x: -128, y: 128 + 32 + 16 - yOffset)    //position appropriately
                    originalText.zPosition = 2.0    //put behind text blockers, but in front of menu background
                    originalText.name = understandingElement.scripture  //name this studysectionlabel after the scripture it contains
                    parent!.addChild(originalText)  //add to open menu
                    yOffset += Int(originalText.pixelLength)    //don't pile on top of eachother, move down along the y-axis
                    
                }
                
                for wisdomElement in wisdom {   //for each nugget of wisdom in this scroll
                    
                    let originalText = StudySectionLabel(theText: studySections[wisdomElement.scripture]![0], theWidth: 60, scrip: wisdomElement.scripture) //get text in original language
                    originalText.position = CGPoint(x: -128, y: 128 + 32 + 16 - yOffset)    //position appropriately
                    originalText.zPosition = 2.0    //put behind text blockers, but in front of menu background
                    originalText.name = wisdomElement.scripture //name this studysectionlabel after the scripture it contains
                    parent!.addChild(originalText)  //add to open menu
                    yOffset += Int(originalText.pixelLength)    //don't pile on top of eachother, move down along the y-axis
                    
                }
                
            }
            
        } else {
            
            //super.mouseDown(theEvent)   //do what you normally do for an item (show the tooltip)
            let infoLabelA = SKLabelNode(text: toolTipSN.itemInfoA) //creates a label node with text for info A
            let infoLabelB = SKLabelNode(text: toolTipSN.itemInfoB) //same for info B
            infoLabelA.fontColor = SKColor.whiteColor() //set text color to white
            infoLabelB.fontColor = SKColor.whiteColor() //same
            infoLabelA.fontSize = 12    //set text size to 12
            infoLabelB.fontSize = 12    //same
            infoLabelA.fontName = "Arial"   //set text font to Arial
            infoLabelB.fontName = "Arial"   //same
            infoLabelA.position = CGPoint(x: 0, y: -32) //positions label A to mid-bottom
            infoLabelB.position = CGPoint(x: 0, y: -48) //positions label B to bottom
            infoLabelA.name = "INFOLABEL_A"
            infoLabelB.name = "INFOLABEL_B"
            toolTipSN.addChild(infoLabelA)  //add label to tooltip
            toolTipSN.addChild(infoLabelB)  //add label to tooltip
            toolTipSN.size = TOOLTIP_SIZE   //make visible (from zeroSize to normal tooltip size)
            
        }
        
    }
    
    /* REQUIRED BY APPLE FOR ANYTHING INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}