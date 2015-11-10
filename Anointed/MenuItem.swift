//
//  MenuItem.swift
//  Anointed
//
//  Created by Jacob Jackson on 8/23/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MenuItem : SKNode {
    
    var menuText : SKLabelNode  //the text of the menu
    var backgroundBox : SKShapeNode //the background box
    
    init( theText: String ) {
        
        menuText = HoverText()  //new hovertext
        menuText.text = theText //text is as passed in
        menuText.fontName = "Arial" //font assignment
        menuText.fontSize = 12  //size
        menuText.color = SKColor.whiteColor()   //color
        menuText.position = CGPoint(x: 0, y: menuText.fontSize / -2)    //center vertically on background box
        menuText.zPosition = 100.0  //put way out in front
        backgroundBox = SKShapeNode(rectOfSize: CGSize(width: Int(menuText.text!.characters.count) * Int(menuText.fontSize / 2) + 16, height: 32), cornerRadius: 3)    //appropriate sized background box
        backgroundBox.fillColor = SKColor.blackColor()  //make it black
        backgroundBox.lineWidth = 2 //make a 2pt outline
        backgroundBox.strokeColor = SKColor.whiteColor()    //outline is white
        backgroundBox.position = CGPoint(x: 0, y: 0)    //background box is centered
        backgroundBox.zPosition = 99.0  //slightly behind the text
        super.init()    //super init
        self.userInteractionEnabled = true  //detect mouse clicks, etc.
        self.addChild(backgroundBox)    //add backround box
        self.addChild(menuText) //add text
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** HANDLES MOUSE CLICK EVENTS **/
    override func mouseDown(theEvent: NSEvent) {
        
        if self.parent is Skill {
            
            let skill = self.parent as! Skill
            for subskill in skill.subskills {
                if subskill.name == self.name {
                    if subskill.canUse() {
                        subskill.use()
                        self.backgroundBox.fillColor = SKColor.blueColor()
                        let fade = SKAction.fadeOutWithDuration(NSTimeInterval(3)) //fade out over 3 seconds
                        self.runAction(fade, completion: {
                            self.parent?.removeAllChildren()
                        })
                    }
                }
            }
            if self.name == "Cancel" {
                self.parent?.removeAllChildren()
            }
            
        }
        
        if self.parent is NonPlayingCharacter { //if we're clicking on an NPC
            
        let par = self.parent as! NonPlayingCharacter   //grabs the npc we're associated with (the player right clicked on the npc that is the parent of this menu)
        
        if menuText.text!.hasPrefix("Trade ") {  //if we're trading
            
            var tradedItemsString = menuText.text   //grab the string describing the trade
            tradedItemsString!.removeRange(Range<String.Index>(start: menuText.text!.startIndex, end: menuText.text!.startIndex.advancedBy(6)))  //remove "Trade "
            
            for n in 0...UNIVERSE.theGame.player.inventory.count-1 {    //iterate through player inventory
                if tradedItemsString!.hasPrefix( UNIVERSE.theGame.player.inventory[n].title ) {  //if we've found the particular item we're trading with
                    par.inventory.append(UNIVERSE.theGame.player.inventory[n])  //add the item we're trading with to the NPC's inventory
                    UNIVERSE.theGame.player.inventory[n].removeFromParent() //remove the item from the inventory screen
                    UNIVERSE.theGame.player.inventory.removeAtIndex(n)  //remove the item from the player's inventory
                    break   //no need to iterate any further
                }
            }
            
            for m in 0...par.inventory.count-1 {    //iterate through npc inventory
                if tradedItemsString!.hasSuffix(par.inventory[m].title) {    //if we've found the item we're trading for
                    UNIVERSE.theGame.player.inventory.append(par.inventory[m])  //add the item to the player's inventory
                    for (key, value) in par.conversation.itemsToBeTraded {  //iterate through items to be traded conversation piece
                        if value == par.inventory[m] {  //if it's the one we're trading for
                            par.conversation.itemsToBeTraded.removeValueForKey(key) //remove it from the conversation
                        }
                    }
                    par.inventory[m].removeFromParent() //remove the item from everything it might be associated with
                    par.inventory.removeAtIndex(m)  //remove the item from the npc's inventory
                    break   //no need to iterate tany further
                }
            }
            
            /*let response = SKLabelNode(text: "It's a deal!")    //make a label node saying "It's a deal!"
            response.fontSize = 12  //same size
            response.fontName = "Arial" //same font
            response.fontColor = SKColor.whiteColor()   //same color
            response.position = CGPoint(x: 0, y: -96)  //below the bye button
            response.zPosition = 100.0  //on top of everything*/
            UNIVERSE.alertText("It's a deal!")
            let fade = SKAction.fadeOutWithDuration(NSTimeInterval(3)) //fade out over 3 seconds
            /*self.addChild(response) //add response text above NPC
            response.runAction(fade)    //start fading out*/
            
            backgroundBox.fillColor = SKColor.redColor()   //makes the box red
            self.runAction(fade)    //start fading out trade menu box

        } else if name == "END_CONVERSATION" {  //if we're saying goodbye
          
            par.removeAllChildren() //close out all the convo menus
            par.talking = false //not talking anymore
            
        } else {    //if we're not trading, nor are we ending the conversation...
        
            backgroundBox.fillColor = SKColor.blueColor()   //makes the box blue
        
            if par.conversation.itemsToBeTraded[menuText.text!] != nil { //if we've clicked a trading button
                
                var item : Item //declare temporary item
                item = par.conversation.itemsToBeTraded[menuText.text!]! //set it to the item to be traded
                let randomkey = random() % (UNIVERSE.theGame.player.inventory.count)    //pick a random inventory item
                /*let response = SKLabelNode(text: "I'll take your " + UNIVERSE.theGame.player.inventory[randomkey].title)    //say "I'll take your ..."
                response.fontSize = 12  //same size
                response.fontName = "Arial" //same font
                response.fontColor = SKColor.whiteColor()   //same color
                response.position = CGPoint(x: 0, y: 128)  //above the NPC
                response.zPosition = 100.0  //on top of everything
                let fade = SKAction.fadeOutWithDuration(NSTimeInterval(10)) //fade out over 10 seconds
                self.addChild(response) //add response text above NPC
                response.runAction(fade)    //start fading out*/
                UNIVERSE.alertText("I'll take your " + UNIVERSE.theGame.player.inventory[randomkey].title)
                menuText.text = "Trade " + UNIVERSE.theGame.player.inventory[randomkey].title + " for " + item.title    //now the menu reads "Trade X for Y"
                
            } else if par.conversation.informationToBeShared[menuText.text!] != nil {    //if we've clicked an information button
                
                var answer : String //answer text
                answer = par.conversation.informationToBeShared[menuText.text!]! //grab the answer from the infotobeshared dictionary
                /*let response = SKLabelNode(text: answer)    //make a label node
                response.fontSize = 12  //same size
                response.fontName = "Arial" //same font
                response.fontColor = SKColor.whiteColor()   //same color
                response.position = CGPoint(x: 0, y: 128)  //above the NPC
                response.zPosition = 100.0  //on top of everything
                let fade = SKAction.fadeOutWithDuration(NSTimeInterval(10)) //fade out over 10 seconds
                self.addChild(response) //add response text above NPC
                response.runAction(fade)    //start fading out*/
                UNIVERSE.alertText(answer)
            
            } else if par.conversation.knowledgeToBeShared[menuText.text!] != nil {  //if we've clicked a knowledge button
                
                var newKnowledge : Knowledge //declare temporary knowledge element
                newKnowledge = par.conversation.knowledgeToBeShared[menuText.text!]! //grab the knowledge
                UNIVERSE.theGame.player.knowledge.append(newKnowledge)  //add the knowledge to the player
                for (key, value) in par.conversation.knowledgeToBeShared {  //iterate over all knowledge to be shared in npc
                    if value.title == newKnowledge.title {  //if it's the one we just got
                        par.conversation.knowledgeToBeShared.removeValueForKey(key) //remove it
                    }
                }
                /*let response = SKLabelNode(text: newKnowledge.title)    //make a label node with text = to title of knowledge element
                response.fontSize = 12  //same size
                response.fontName = "Arial" //same font
                response.fontColor = SKColor.whiteColor()   //same color
                response.position = CGPoint(x: 0, y: 128)  //above the NPC
                response.zPosition = 100.0  //on top of everything
                let fade = SKAction.fadeOutWithDuration(NSTimeInterval(10)) //fade out over 10 seconds
                self.addChild(response) //add response text above NPC
                response.runAction(fade)    //start fading out*/
                UNIVERSE.alertText(newKnowledge.title)
                
            } else if par.conversation.understandingToBeShared[menuText.text!] != nil {  //if we've clicked an understanding button
                
                var newUnderstanding : Understanding //declare temporary understanding element
                newUnderstanding = par.conversation.understandingToBeShared[menuText.text!]! //grab the understanding
                UNIVERSE.theGame.player.understanding.append(newUnderstanding)  //add the understanding to the player
                for (key, value) in par.conversation.understandingToBeShared {  //iterate over all understanding to be shared in npc
                    if value.title == newUnderstanding.title {  //if it's the one we just got
                        par.conversation.understandingToBeShared.removeValueForKey(key) //remove it
                    }
                }
                /*let response = SKLabelNode(text: newUnderstanding.title)    //make a label node with text = to title of understanding element
                response.fontSize = 12  //same size
                response.fontName = "Arial" //same font
                response.fontColor = SKColor.whiteColor()   //same color
                response.position = CGPoint(x: 0, y: 128)  //above the NPC
                response.zPosition = 100.0  //on top of everything
                let fade = SKAction.fadeOutWithDuration(NSTimeInterval(10)) //fade out over 10 seconds
                self.addChild(response) //add response text above NPC
                response.runAction(fade)    //start fading out*/
                UNIVERSE.alertText(newUnderstanding.title)
                
            } else if par.conversation.wisdomToBeShared[menuText.text!] != nil { //if we've clicked a wisdom button
                
                var newWisdom : Wisdom //declare temporary wisdom element
                newWisdom = par.conversation.wisdomToBeShared[menuText.text!]!   //grab the wisdom
                UNIVERSE.theGame.player.wisdom.append(newWisdom)    //add the wisdom to the player
                for (key, value) in par.conversation.wisdomToBeShared { //iterate over all wisdom to be shared in npc
                    if value.title == newWisdom.title { //if it's the one we just got
                        par.conversation.wisdomToBeShared.removeValueForKey(key)    //remove it
                    }
                }
                /*let response = SKLabelNode(text: newWisdom.title)   //make a label node with text = to title of wisdom element
                response.fontSize = 12  //same size
                response.fontName = "Arial" //same font
                response.fontColor = SKColor.whiteColor()   //same color
                response.position = CGPoint(x: 0, y: 128)  //above the NPC
                response.zPosition = 100.0  //on top of everything
                let fade = SKAction.fadeOutWithDuration(NSTimeInterval(10)) //fade out over 10 seconds
                self.addChild(response) //add response text above NPC
                response.runAction(fade)    //start fading out*/
                UNIVERSE.alertText(newWisdom.title)
                
            }
            
        }
    
    }
        
    }
    
}