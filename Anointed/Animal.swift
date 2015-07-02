//
//  Animal.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/26/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* DEFINES AN ANIMAL */
class Animal : SKSpriteNode {
    
    let animalName: String   //name
    let descript: String   //description
    let spriteSheetName: String  //image name for spritesheet
    var deltaT = 0.0    //start delta time for AI at zero
    var startTime = 0.0 //start time is zero, will be set to current time in updateAI's first call
    var sprites : [[SKTexture]] //texture array
    
    init( name: String, desc: String, sheetName: String ) {
        
        animalName = name
        descript = desc
        spriteSheetName = sheetName
        
        let spriteSheet = SKTexture(imageNamed: spriteSheetName)    //grab spritesheet
        let w = spriteSheet.size().width    //width of spritesheet
        let h = spriteSheet.size().height   //height of spritesheet
        let sw = 32 / spriteSheet.size().width  //individual sprite width
        let sh = 32 / spriteSheet.size().height //individual sprite height
        sprites = [ [   //this is all the sprites for the animal in a 2D array with direction in the y and walking iterations in the x
                SKTexture(rect: CGRect(x: CGFloat(0), y: CGFloat(0), width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(32)/w, y: CGFloat(0), width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(64)/w, y: CGFloat(0), width: sw, height: sh), inTexture: spriteSheet)
            ], [ SKTexture(rect: CGRect(x: CGFloat(0), y: CGFloat(32)/h, width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(32)/w, y: CGFloat(32)/h, width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(64)/w, y: CGFloat(32)/h, width: sw, height: sh), inTexture: spriteSheet)
            ], [ SKTexture(rect: CGRect(x: CGFloat(0), y: CGFloat(64)/h, width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(32)/w, y: CGFloat(64)/h, width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(64)/w, y: CGFloat(64)/h, width: sw, height: sh), inTexture: spriteSheet)
            ], [ SKTexture(rect: CGRect(x: CGFloat(0), y: CGFloat(96)/h, width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(32)/w, y: CGFloat(96)/h, width: sw, height: sh), inTexture: spriteSheet),
                SKTexture(rect: CGRect(x: CGFloat(64)/w, y: CGFloat(96)/h, width: sw, height: sh), inTexture: spriteSheet)
            ] ]
        super.init(texture: sprites[0][0], color: SKColor.clearColor(), size: sprites[0][0].size()) //sets up tex, bgcolor, and size
        
    }
    
    func updateAI( time: CFTimeInterval ) {
        
        if startTime == 0.0 {
            startTime = time
        } else {
            deltaT = time - startTime
        }
        if deltaT > 2 {
            moveRandom()
            deltaT = 0.0
            startTime = time
        }
        
    }
    
    func moveRandom() {
        
        var direction = random() % 4
        switch( direction ) {
            
        case 0: moveUP()
            break
        case 1: moveRT()
            break
        case 2: moveDN()
            break
        case 3: moveLT()
            break
        default:
            break
        }
        
    }
    
    func moveUP() {
        
        self.texture = sprites[0][0]
        var walkFrames = [SKTexture]()
        walkFrames.append(sprites[0][0])
        walkFrames.append(sprites[0][1])
        walkFrames.append(sprites[0][2])
        walkFrames.append(sprites[0][0])
        walkFrames.append(sprites[0][1])
        walkFrames.append(sprites[0][2])
        let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: 0.16667)
        let moveUp = SKAction.moveByX(0, y: 64, duration: 1.0)
        self.runAction(walk)
        self.runAction(moveUp)
        
    }
    
    func moveRT() {
        
        self.texture = sprites[1][0]
        var walkFrames = [SKTexture]()
        walkFrames.append(sprites[1][0])
        walkFrames.append(sprites[1][1])
        walkFrames.append(sprites[1][2])
        walkFrames.append(sprites[1][0])
        walkFrames.append(sprites[1][1])
        walkFrames.append(sprites[1][2])
        let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: 0.16667)
        let moveRt = SKAction.moveByX(128, y: 0, duration: 1.0)
        self.runAction(walk)
        self.runAction(moveRt)
        
    }
    
    func moveLT() {
        
        self.texture = sprites[2][0]
        var walkFrames = [SKTexture]()
        walkFrames.append(sprites[2][0])
        walkFrames.append(sprites[2][1])
        walkFrames.append(sprites[2][2])
        walkFrames.append(sprites[2][0])
        walkFrames.append(sprites[2][1])
        walkFrames.append(sprites[2][2])
        let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: 0.16667)
        let moveLt = SKAction.moveByX(-128, y: 0, duration: 1.0)
        self.runAction(walk)
        self.runAction(moveLt)
        
    }
    
    func moveDN() {
        
        self.texture = sprites[3][0]
        var walkFrames = [SKTexture]()
        walkFrames.append(sprites[3][0])
        walkFrames.append(sprites[3][1])
        walkFrames.append(sprites[3][2])
        walkFrames.append(sprites[3][0])
        walkFrames.append(sprites[3][1])
        walkFrames.append(sprites[3][2])
        let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: 0.16667)
        let moveDn = SKAction.moveByX(0, y: -64, duration: 1.0)
        self.runAction(walk)
        self.runAction(moveDn)
        
    }

    /* FROM APPLE. APPARENTLY NECESSARY IF I'M INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}