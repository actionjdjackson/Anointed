
//
//  Location.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Location {
    
    var name:String
    var description:String
    var grid:[[GridSquare]]
    
    init( n:String, d:String, g:[[GridSquare]]) {
        
        name = n
        description = d
        grid = g
        
    }
    
}