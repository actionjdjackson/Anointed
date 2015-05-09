//
//  Room.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/24/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Room {
    
    let grid : [[GridSquare]]
    let title : String
    
    init( ttl: String, gridSquares: [[GridSquare]] ) {
        
        title = ttl
        grid = gridSquares
        
    }
    
}