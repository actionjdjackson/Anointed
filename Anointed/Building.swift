//
//  Building.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Building {
    
    var rooms:[[Room]]
    let title : String
    
    init( ttl: String, r:[[Room]] ) {
        
        title = ttl
        rooms = r
        
    }
    
}