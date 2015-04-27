//
//  GridSquare.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/16/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

/* DEFINES A GRID SQUARE - WITH A TEXTURE AND A CONTENTS ARRAY */
class GridSquare {
    
    var texture: String
    var contents: [Item]
    var extraObject: String
    
    init( tex: String, hasItems: [Item], obj: String ) {
        
        texture = tex
        contents = hasItems
        extraObject = obj
        
    }
    
}