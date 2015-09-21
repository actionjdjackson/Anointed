//
//  Conversation.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/4/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Conversation {
    
    var knowledgeToBeShared : [String: Knowledge]
    var understandingToBeShared : [String: Understanding]
    var wisdomToBeShared : [String: Wisdom]
    var itemsToBeTraded : [String: Item]
    var informationToBeShared: [String: String]
    
    init( knowledge: [String : Knowledge], understanding: [String : Understanding], wisdom: [String : Wisdom], items: [String : Item], info: [String : String]) {
        
        knowledgeToBeShared = knowledge
        understandingToBeShared = understanding
        wisdomToBeShared = wisdom
        itemsToBeTraded = items
        informationToBeShared = info
        
    }
    
}