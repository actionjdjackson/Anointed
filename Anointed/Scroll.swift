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
    
    let text: String
    let ENGtext: String
    let language: String
    
    init( ttl: String, desc: String, textFile: String, lang: String, scrollSize: Int ) {
        
        var path = NSBundle.mainBundle().pathForResource(textFile, ofType: "txt")!  //grabs text file path for this scroll
        text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!    //grab the text and put in string "text"
        path = NSBundle.mainBundle().pathForResource(textFile + "ENG", ofType: "txt")!  //grabs text file with added "ENG" for english translation
        ENGtext = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)! //grab the text of the english translation and put in string "ENGtext"
        language = lang //set language of scroll
        
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

    /* WHEN SCROLL IS OPENED FOR STUDYING... */
    func studyScroll(chap: Int, verseStart: Int, verseEnd: Int) {
        
        if sprite == "smallScroll" {
            
            //do single chapter scroll
            
        } else {
            
            //do multi-chapter scroll
            
        }
        
    }
    
    /* REQUIRED BY APPLE FOR ANYTHING INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}