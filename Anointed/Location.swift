
//
//  Location.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Location {
    
    var name : String
    var description : String
    var grid : [[GridSquare]]
    var animals : [Animal]
    var people : [NonPlayingCharacter]
    var visited : Bool
    
    init( n:String, d:String, g:[[GridSquare]], a:[Animal], npc:[NonPlayingCharacter]) {
        
        name = n
        description = d
        grid = g
        animals = a
        people = npc
        visited = false
        
    }
    
}