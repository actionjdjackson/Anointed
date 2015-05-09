//
//  Understanding.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/31/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Understanding {
    
    let knowledge : [Knowledge]
    let title : String
    let description : String
    let scripture : String
    
    init( knowledgeElements: [Knowledge], ttl: String, desc: String, scrip: String ) {
        
        knowledge = knowledgeElements
        title = ttl
        description = desc
        scripture = scrip
        
    }
    
}