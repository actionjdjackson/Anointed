//
//  BlindingLight.swift
//  Anointed
//
//  Created by Jacob Jackson on 11/9/15.
//  Copyright © 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class BlindingLight : Skill {
    
    /* SET UP BLINDING LIGHT SKILL */
    init( user : GameCharacter ) {
        super.init( skillName: "Blinding Light", skillDesc: "Allows you to cast a blinding light over a crowd or individual", skillUser: user, skillSprite : "blindingLight", baseTimeToComplete : 0.25, passv: false, subsk: [] )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* USE BLINDING LIGHT SKILL ON ENTIRE VIEWABLE AREA */
    override func use() {
        
        //if you have all the raw materials necessary,
        if canUse() {
            
            let light : SKShapeNode
            light = SKShapeNode(rectOfSize: CGSize(width: 4096*2, height: 4096*2))
            light.fillColor = SKColor.whiteColor()
            light.position = CGPoint(x: 0.5, y: 0.5)
            light.zPosition = 1000
            UNIVERSE.theScene.world.addChild(light)
            playSound("BlindingLight.mp3")
            light.runAction(SKAction.fadeOutWithDuration(3), completion: {
                light.removeFromParent()
                })
            //level up
            level++
            //update tooltip info
            self.toolTipSN.itemInfoA = "Level " + String( level )
            self.toolTipSN.itemInfoB = "Time to Complete: "
            self.toolTipSN.itemInfoB += String(stringInterpolationSegment: round((10.0 - log(Double(self.level))) * self.hoursToComplete / 10.0)) + "hrs"
            //report to console
            UNIVERSE.alertText("Whoa! Totally miraculous, dude!")
            UNIVERSE.alertText("Blinding Light +1")
            
        } else {    //if we don't
            
            UNIVERSE.alertText("Not enough resources to make wine. Sorry.")    //it's a no-go
            
        }
        
    }
    
    /* CAN WE USE THIS SKILL RIGHT NOW? */
    override func canUse() -> Bool {
        
        return true
        
    }
    
}