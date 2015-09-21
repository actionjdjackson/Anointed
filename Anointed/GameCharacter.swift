//
//  GameCharacter.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* DEFINES A PLAYER IN THE GAME (A GAME CHARACTER) */
class GameCharacter : SKSpriteNode {
    
    var firstName: String
    var from: String
    var birthplace: String
    var romanCitizen: Bool
    var age: Int
    var occupation: String
    var baptized: Bool
    var physicalHealth: Int
    var isDisciple: Bool
    var inventory: [Item]
    var inventorySize: Int
    var spiritualGifts: [SpiritualGift]
    var skills: [Skill]
    var knowledge: [Knowledge]
    var wisdom: [Wisdom]
    var understanding: [Understanding]
    var charisma: Int
    var intelligence:  Int
    var strength: Int
    var dexterity: Int
    var experience: Int
    var languagesKnown: [String]
    var currentGridLocation: CGPoint
    
    /* FOR NOW, JUST DEFAULT TO ME AND DEFINE THINGS AS WE NEED TO FOR DEBUGGING. CHARS WILL BE DEFINABLE/CREATABLE LATER IN GAME DEV - ***IN PROGRESS*** */
    
    init() {
        
        firstName = "Jacob"
        from = "Madison, WI"
        birthplace = "Madison, WI"
        romanCitizen = true
        age = 30
        occupation = "Computer Programmer"
        baptized = true
        physicalHealth = 100
        isDisciple = true
        inventory = []
        inventorySize = 120
        spiritualGifts = []
        skills = []
        knowledge = []
        wisdom = []
        understanding = []
        charisma = 10
        intelligence = 10
        strength = 10
        dexterity = 10
        experience = age * 1000
        languagesKnown = ["Hebrew", "Aramaic", "Greek", "Latin"]
        currentGridLocation = CGPoint(x: 5, y: 5)
        
        let texture = SKTexture(imageNamed: "characterDOWN")    //make a texture w/ the downward-facing character image
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size()) //defines tex, bgcolor, and size
        
    }
    
    func howManyInInventory(itemName: String) -> Int {
        
        var num : Int
        num = 0
        
        if inventory.count > 0 {
            for index in 0...inventory.count-1 {
                if(inventory[index].title == itemName) {
                    num++
                }
            }
        }
        
        return num
        
    }
    
    func grabFromInventory(itemName: String) -> Bool {
        if inventory.count > 0 {
            for index in 0...inventory.count-1 {
                if(inventory[index].title == itemName) {
                    inventory.removeAtIndex(index)
                    return true
                }
            }
        }
        return false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}