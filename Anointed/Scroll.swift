//
//  Scroll.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/16/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

/* DEFINES A SCROLL OBJECT, WITH 3 DIFFERENT SIZES, TEXT FILE SOURCE, LANGUAGE, TITLE, AND DESCRIPTION */
class Scroll: Item {
    
    let text: String
    let ENGtext: String
    let language: String
    
    init( ttl: String, desc: String, textFile: String, lang: String, scrollSize: Int ) {
        
        var path = NSBundle.mainBundle().pathForResource(textFile, ofType: "txt")!
        text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
        path = NSBundle.mainBundle().pathForResource(textFile + "ENG", ofType: "txt")!
        ENGtext = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
        language = lang
        
        if scrollSize == 1 {
            super.init(ttl: ttl, desc: desc, sx: 1, sy: 1, spriteName: "SmallScroll")
        } else if scrollSize == 2 {
            super.init(ttl: ttl, desc: desc, sx: 2, sy: 1, spriteName: "MediumScroll")
        } else if scrollSize >= 3 {
            super.init(ttl: ttl, desc: desc, sx: 2, sy: 2, spriteName: "LargeScroll")
        } else {
            super.init(ttl: ttl, desc: desc, sx: 1, sy: 1, spriteName: "SmallScroll") //DEFAULTS TO SMALL SCROLL IMAGE/SIZE
        }
        
    }

    func studyScroll(chap: Int, verseStart: Int, verseEnd: Int) {
        
        if sprite == "SmallScroll" {
            
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