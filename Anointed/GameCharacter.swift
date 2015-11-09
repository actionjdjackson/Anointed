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
    var lastName: String
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
    var calling: OfficeCalling
    var gifts: [Gift]
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
        lastName = "Bar Daniel"
        from = "Jerusalem"
        birthplace = "Carthage"
        romanCitizen = true
        age = 30
        occupation = "Tentmaker"
        baptized = true
        physicalHealth = 100
        isDisciple = true
        inventory = []
        inventorySize = 120
        calling = Apostle()
        gifts = []
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
    
    func knowsScripture( scripture : String ) -> Bool {
        
        for knowledgeElement in knowledge {
            if knowledgeElement.scripture == scripture {
                return true
            }
        }
        
        for understandingElement in understanding {
            if understandingElement.scripture == scripture {
                return true
            }
        }
        
        for wisdomElement in wisdom {
            if wisdomElement.scripture == scripture {
                return true
            }
        }
        
        return false
        
    }
    
    /* RETURNS HOW MANY ITEMS WITH GIVEN NAME IN INVENTORY OF CHARACTER */
    func howManyInInventory(itemName: String) -> Int {  //item name input
        
        var num : Int = 0  //init item counter
        
        if inventory.count > 0 {    //if there's anything in the inventory
            for item in inventory { //for each item in inventory...
                if(item.title == itemName) {    //if the title of the object matches
                    num++   //increment the item counter
                }
            }
        }
        
        return num  //return total number of items with name "_itemName_"
        
    }
    
    /* GRAB AN ITEM FROM THE INVENTORY (REMOVING IT FROM THE INVENTORY AND RETURNING TRUE IF IT WAS SUCCESSFULLY REMOVED) */
    func grabFromInventory(itemName: String) -> Bool {  //item name input
        if inventory.count > 0 {    //if the inventory is not empty
            for index in 0...inventory.count-1 {    //go thru inventory with an index
                if(inventory[index].title == itemName) {    //if the title matches
                    inventory.removeAtIndex(index)  //remove it
                    return true //return success
                }
            }
        }
        return false    //if nothing gets removed, return false (failure)
    }

    /* REQUIRED BY APPLE */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}