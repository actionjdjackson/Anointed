//
//  Scroll.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/16/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Scroll: Item {
    
    init( ttl: String, desc: String, textFile: String, lang: String, scrollSize: Int ) {
        
        if scrollSize == 1 {
            super.init(ttl: ttl, desc: desc, sx: 1, sy: 1, iconName: "SmallScroll")
        } else if scrollSize == 2 {
            super.init(ttl: ttl, desc: desc, sx: 2, sy: 1, iconName: "MediumScroll")
        } else if scrollSize >= 3 {
            super.init(ttl: ttl, desc: desc, sx: 2, sy: 2, iconName: "LargeScroll")
        } else {
            super.init(ttl: ttl, desc: desc, sx: 1, sy: 1, iconName: "SmallScroll")
        }
        
        let path = NSBundle.mainBundle().pathForResource(textFile, ofType: "txt")
        let text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        let language = lang
        
    }
    
}