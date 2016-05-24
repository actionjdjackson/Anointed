//
//  Quest.swift
//  Anointed
//
//  Created by Jacob Jackson on 5/24/16.
//  Copyright © 2016 ThinkMac Innovations. All rights reserved.
//

import Foundation

class Quest {
    
    var itemsRequired : [Item]  //item(s) to find to complete quest
    var knowledgeRequired : [Knowledge] //knowledge required to complete quest
    var understandingRequired : [Understanding] //understanding required to complete quest
    var wisdomRequired : [Wisdom]   //wisdom required to complete quest
    
    var rewardItems : [Item]    //reward item(s)
    
    var timeLimit : Double  //time limit on quest (< 0 means no time limit)
    var timeStarted : CFTimeInterval    //time started timestamp
    
    var completed : Bool    //completed quest
    var failed : Bool   //failed quest
    var succeeded : Bool    //succeeded in quest
    
    let title : String  //title of quest
    let description : String    //quest description
    
    init( questTitle : String, desc : String, items : [Item], knowledge : [Knowledge], understanding : [Understanding], wisdom : [Wisdom], rewards : [Item], limit : Double ) {
        
        title = "Quest: " + questTitle  //add a prefix "Quest: " to quest title so we can parse it out of menu items
        description = desc
        itemsRequired = items
        knowledgeRequired = knowledge
        understandingRequired = understanding
        wisdomRequired = wisdom
        rewardItems = rewards
        timeLimit = limit
        completed = false
        failed = false      //neither succeeded nor failed == either in progress or not attempted yet
        succeeded = false   // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        timeStarted = 0.0   // when 0 it hasnt been attempted yet
        
    }
    
    func update( time : CFTimeInterval ) {  //update quest progress
        
        if succeeded == false && failed == false {  //if in progress
        
            /* CHECKS TO SEE IF WE'VE PASSED THE TIME LIMIT */
            if time - timeStarted > Double(timeLimit) && completed == false && timeLimit > 0.0 {
                completed = true
                failed = true
                succeeded = false
            }
            
            /* CHECKS FOR ITEMS AND KNOWLEDGE/WISDOM/UNDERSTANDING AND SEES IF QUEST HAS BEEN COMPLETED */
            
            succeeded = true
            
            for item in itemsRequired {
            
                if !UNIVERSE.theGame.player.inventory.contains(item) {
                    succeeded = false
                }
            
            }
            
            for knowledge in knowledgeRequired {
                
                var didntfindit = true
                
                for knowledgeInPlayer in UNIVERSE.theGame.player.knowledge {
                    
                    if knowledge.title == knowledgeInPlayer.title {
                        
                        didntfindit = false
                        
                    }
                    
                }
                
                if didntfindit {
                    succeeded = false
                }
                
            }
            
            for understanding in understandingRequired {
                
                var didntfindit = true
                
                for understandingInPlayer in UNIVERSE.theGame.player.understanding {
                    
                    if understanding.title == understandingInPlayer.title {
                        
                        didntfindit = false
                        
                    }
                    
                }
                
                if didntfindit {
                    succeeded = false
                }
                
            }
            
            for wisdom in wisdomRequired {
                
                var didntfindit = true
                
                for wisdomInPlayer in UNIVERSE.theGame.player.wisdom {
                    
                    if wisdom.title == wisdomInPlayer.title {
                        
                        didntfindit = false
                        
                    }
                    
                }
                
                if didntfindit {
                    succeeded = false
                }
                
            }
        
            if succeeded == true {
            
                UNIVERSE.alertText("You completed the quest " + title)  //yay! we've completed the quest so make an alert for it
            
            }
        
        }
        
    }
    
    func startQuest( time : CFTimeInterval ) {
       
        timeStarted = time
        
    }
    
    func isCompleted() -> Bool {
        
        return completed
        
    }
    
}