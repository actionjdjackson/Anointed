//
//  NonPlayingCharacter.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/24/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class NonPlayingCharacter : GameCharacter {
    
    var selected : Bool = false //initially not selected
    let SELECTION_OUTLINE_SIZE = CGFloat(2.0)   //size of the line for drawing the selection halo
    let SELECTION_OUTLINE_GLOW_SIZE = CGFloat(5.0)  //size of the glow for drawing the selection halo
    var conversation : Conversation //conversation elements go here
    var quests : [Quest] //quest element goes here
    var talking : Bool = false  //keeps track of whether or not we're in a conversation
    
    init( convo: Conversation, theQuests : [Quest] ) {
        
        conversation = convo    //stores the conversation
     quests = theQuests
        super.init( )   //super initializer
        if conversation.itemsToBeTraded.count > 0 {
            for (_, item) in conversation.itemsToBeTraded {
                inventory.append(item)
            }
        }
        self.userInteractionEnabled = true  //detect mouse clicks, etc.
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* HANDLES MOUSE CLICKS ON NPC */
    override func mouseDown( theEvent: NSEvent ) {
        
        if selected == true && talking == false {   //if already selected
            self.removeAllChildren()    //remove halo
            selected = false    //now deselected
        } else if talking == true {
            //do nothing
        } else {    //if not already selected
            for npc in UNIVERSE.theGame.currentLocation.people {    //run thru npcs
                if npc.selected {   //if selected
                    npc.removeAllChildren() //remove selection halo
                    npc.selected = false    //deselect
                }
            }
            for animal in UNIVERSE.theGame.currentLocation.animals {    //run thru animals
                if animal.selected {    //if selected
                    animal.removeAllChildren()  //remove selection halo
                    animal.selected = false //deselect
                }
            }
            selected = true //we are now selected
            var outlineBox : SKShapeNode    //new shapenode
            outlineBox = SKShapeNode(rectOfSize: self.texture!.size(), cornerRadius: 10)    //make rounded rectangle
            outlineBox.lineWidth = SELECTION_OUTLINE_SIZE //set line width for halo
            outlineBox.strokeColor = SKColor.whiteColor()   //set color for halo
            outlineBox.glowWidth = SELECTION_OUTLINE_GLOW_SIZE  //set glow width for halo
            self.addChild(outlineBox)   //add halo to NPC
        }
        
    }
    
    /* HANDLES RIGHT MOUSE CLICKS ON NPC */
    override func rightMouseDown(theEvent: NSEvent) {
        
        if talking == false {   //if we're not already in a conversation
            
            talking = true  //we are now
            
            var i = 0   //how many questions have we gone through
            
            for (question, _) in conversation.informationToBeShared {  //iterate through all informational conversation pieces
                let menuItem = MenuItem(theText: question)  //put a menu up on top of the NPC with the text of the question
                menuItem.position.y = CGFloat(i * -32)  //put it below any previous questions
                menuItem.name = question    //names the menu item after the question it refers to
                self.addChild(menuItem) //add to NPC, and thus, to the scene
                i++ //increment the question counter
            }
            
            for (question, _) in conversation.itemsToBeTraded {  //iterate through all items to be traded
                let menuItem = MenuItem(theText: question)  //put a menu up on top of the NPC with the text of the trade question
                menuItem.position.y = CGFloat(i * -32)  //put it below any previous questions
                menuItem.name = question    //names the menu item after the question it refers to
                self.addChild(menuItem) //add to NPC, and thus, to the scene
                i++ //increment the question counter
            }
            
            for (question, _) in conversation.knowledgeToBeShared { //iterate through all knowledge to be shared
                let menuItem = MenuItem(theText: question)  //put a menu up on top of the NPC with the text of the knowledge question
                menuItem.position.y = CGFloat(i * -32)  //put it below any previous questions
                menuItem.name = question    //names the menu item after the question it refers to
                self.addChild(menuItem) //add to NPC, and thus, to the scene
                i++ //increment the question counter
            }
            
            for (question, _) in conversation.understandingToBeShared { //same as above, but for understanding
                let menuItem = MenuItem(theText: question)
                menuItem.position.y = CGFloat(i * -32)
                menuItem.name = question
                self.addChild(menuItem)
                i++
            }
            
            for (question, _) in conversation.wisdomToBeShared {   //same as above, but for wisdom
                let menuItem = MenuItem(theText: question)
                menuItem.position.y = CGFloat(i * -32)
                menuItem.name = question
                self.addChild(menuItem)
                i++
            }
            
            for quest in quests {   //run thru quests
                if quest.isCompleted() {    //if quest requirements are met
                    let menuItem = MenuItem(theText: "Complete " + quest.title) //change title to have "Complete " at the beginning
                    menuItem.position.y = CGFloat(i * -32)  //same as above, but for quests
                    menuItem.name = "Complete " + quest.title   //make menu item name same as it's text
                    quest.title = menuItem.name! //make
                    self.addChild(menuItem) //add to NPC
                    i++
                } else if quest.timeStarted == 0.0 {    //if quest requirements are not met and the quest hasn't been started yet
                    let menuItem = MenuItem(theText: quest.title)   //add menu item for quest
                    menuItem.position.y = CGFloat(i * -32)  //same as above, but for quests
                    menuItem.name = quest.title
                    self.addChild(menuItem)
                    i++
                }
            }
            
            let menuItem = MenuItem(theText: "Bye!")    //add a bye menu item
            menuItem.position.y = CGFloat(i * -32)  //put it below any previous questions
            menuItem.name = "END_CONVERSATION"  //name it "END_CONVERSATION" for later use in identifying the button as the conversation-ender
            self.addChild(menuItem) //add to NPC, and thus, to the scene
            i++ //increment the question counter
            
        } else {    //if we're already in a conversation
            
            self.removeAllChildren()    //remove conversation elements (and everything else, like the selection outline)
            talking = false //we are no longer talking
            
        }
        
    }
    
    func update( time : NSTimeInterval ) {  //update the quest timer for all quests
        
        for quest in self.quests {  //for each quest
            quest.update(time)  //update the quest timer
        }
        
    }
    
}