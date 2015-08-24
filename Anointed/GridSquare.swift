//
//  GridSquare.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/16/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* DEFINES A GRID SQUARE - WITH A TEXTURE AND A CONTENTS ARRAY AND THE OPTION FOR AN EXTRA OBJECT */
class GridSquare {
    
    var texture: String
    var contents: [Item]
    var extraObject: String
    var npcList : [NonPlayingCharacter]
    var animalList : [Animal]
    
    init( tex: String, hasItems: [Item], obj: String, npc: [NonPlayingCharacter], animal: [Animal] ) {
        
        texture = tex
        contents = hasItems
        extraObject = obj
        npcList = npc
        animalList = animal
        
    }
    
}