//
//  Animal.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/26/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit
import ScreenSaver

/* DEFINES AN ANIMAL */
class Animal : SKSpriteNode {
    
    /* VARIABLES */
    let descript: String   //description
    let spriteSheetName: String  //image name for spritesheet
    var deltaT = 0.0    //start delta time for AI at zero
    var startTime = 0.0 //start time is zero, will be set to current time in updateAI's first call
    var sprites : [[SKTexture]] //texture array
    var selected : Bool = false //initially not selected
    var physicalHealth : Int = 100  //starts with full health
    var boundsArray : [Int]
    var gridLocation : CGPoint
    
    /* CONSTANTS */
    let WALK_TIME = NSTimeInterval(1.0) //how long the walk sequence lasts
    let ONE_SQUARE_UP = CGFloat(64)
    let ONE_SQUARE_DN = CGFloat(-64)
    let ONE_SQUARE_LT = CGFloat(-128)
    let ONE_SQUARE_RT = CGFloat(128)
    let ZERO = CGFloat(0)
    let SPRITE_SIZE_X = CGFloat(32)
    let SPRITE_SIZE_Y = CGFloat(32)
    let SELECTION_OUTLINE_SIZE = CGFloat(2.0)   //size of the line for drawing the selection halo
    let SELECTION_OUTLINE_GLOW_SIZE = CGFloat(5.0)  //size of the glow for drawing the selection halo
    let SELECTION_CORNER_RADIUS = CGFloat(10)
    
    init( name: String, desc: String, sheetName: String, gridLoc : CGPoint, bounds: [Int] ) {

        descript = desc
        spriteSheetName = sheetName
        gridLocation = gridLoc
        boundsArray = bounds
        
        let spriteSheet = SKTexture(imageNamed: spriteSheetName)    //grab spritesheet
        let w = spriteSheet.size().width    //width of spritesheet
        let h = spriteSheet.size().height   //height of spritesheet
        let sw = SPRITE_SIZE_X / spriteSheet.size().width  //individual sprite width
        let sh = SPRITE_SIZE_Y / spriteSheet.size().height //individual sprite height
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
        self.name = name
        self.userInteractionEnabled = true
        
    }
    
    /* on mouse click */
    override func mouseDown( theEvent: NSEvent ) {
        
        if selected == true {   //if it is already selected
            self.removeAllChildren()    //remove halo
            selected = false    //now no longer selected
        } else {    //if it is not already selected
            for npc in UNIVERSE.theGame.currentLocation.people {
                if npc.selected {
                    npc.removeAllChildren()
                    npc.selected = false
                }
            }
            for animal in UNIVERSE.theGame.currentLocation.animals {
                if animal.selected {
                    animal.removeAllChildren()
                    animal.selected = false
                }
            }
            var outlineBox : SKShapeNode    //create new halo shapenode
            outlineBox = SKShapeNode(rectOfSize: self.texture!.size(), cornerRadius: SELECTION_CORNER_RADIUS)    //make a rounded rectangle of size equal to animal sprite size
            outlineBox.lineWidth = SELECTION_OUTLINE_SIZE   //set the line width
            outlineBox.strokeColor = SKColor.whiteColor()   //set the color to white
            outlineBox.glowWidth = SELECTION_OUTLINE_GLOW_SIZE  //set the glow width
            self.addChild(outlineBox)   //add the halo to the animal
            selected = true //it is now selected
        }
        
    }
    
    /* called every frame from Scene */
    func updateAI( time: CFTimeInterval ) {
        
        if startTime == 0.0 {   //if we're just starting out
            startTime = time    //set marker to present time
        } else {
            deltaT = time - startTime   //if we've been running at all, get the change in time since last AI call
        }
        if deltaT > Double(SSRandomIntBetween(2, 20)) { //randomly vary the time it takes to begin a new movement cycle
            moveRandom()    //move in a random direction
            deltaT = 0.0    //reset change in time
            startTime = time    //new marker set to present timne
        }
        
    }
    
    /* moves the animal in a random direction */
    func moveRandom() {
        
        let direction = random() % 4    //random number 0 - 3
        switch( direction ) {
            
        case 0: moveUP()    //move up
            break
        case 1: moveRT()    //move right
            break
        case 2: moveDN()    //move down
            break
        case 3: moveLT()    //move left
            break
        default:
            break
        }
        
    }
    
    /* handles moving up */
    func moveUP() {
        
        if Int(gridLocation.x + 1) >= Int(boundsArray[0]) || Int(gridLocation.y + 1) >= Int(boundsArray[1]) {
            //do nothing
        } else {
            gridLocation.y += 1
            gridLocation.x += 1
            self.texture = sprites[0][0]    //face the appropriate direction
            var walkFrames = [SKTexture]()  //create new working walk frames variable
            walkFrames.append(sprites[0][0])    //grab the sprites for walking up
            walkFrames.append(sprites[0][1])
            walkFrames.append(sprites[0][2])
            walkFrames.append(sprites[0][0])
            walkFrames.append(sprites[0][1])
            walkFrames.append(sprites[0][2])
            let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: NSTimeInterval(WALK_TIME / Double(walkFrames.count))) //make a new walk animation
            let moveUp = SKAction.moveByX( ZERO, y: ONE_SQUARE_UP, duration: WALK_TIME) //make a new movement animation
            self.runAction(walk)    //run walk cycle animation
            self.runAction(moveUp)  //run movement animation
        }
        
    }
    
    /* handles moving right - same steps taken as in moveUP() */
    func moveRT() {
        
        if Int(gridLocation.x - 1) < 0 || Int(gridLocation.y + 1) >= Int(boundsArray[1]) {
            //do nothing
        } else {
            gridLocation.y += 1
            gridLocation.x -= 1
            self.texture = sprites[1][0]
            var walkFrames = [SKTexture]()
            walkFrames.append(sprites[1][0])
            walkFrames.append(sprites[1][1])
            walkFrames.append(sprites[1][2])
            walkFrames.append(sprites[1][0])
            walkFrames.append(sprites[1][1])
            walkFrames.append(sprites[1][2])
            let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: NSTimeInterval(WALK_TIME / Double(walkFrames.count)))
            let moveRt = SKAction.moveByX( ONE_SQUARE_RT, y: ZERO, duration: WALK_TIME)
            self.runAction(walk)
            self.runAction(moveRt)
        }
        
    }
    
    /* handles moving left - same steps taken as in moveUP() */
    func moveLT() {
        
        if Int(gridLocation.x + 1) >= Int(boundsArray[0]) || Int(gridLocation.y - 1) < 0 {
            //do nothing
        } else {
            gridLocation.y -= 1
            gridLocation.x += 1
            self.texture = sprites[2][0]
            var walkFrames = [SKTexture]()
            walkFrames.append(sprites[2][0])
            walkFrames.append(sprites[2][1])
            walkFrames.append(sprites[2][2])
            walkFrames.append(sprites[2][0])
            walkFrames.append(sprites[2][1])
            walkFrames.append(sprites[2][2])
            let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: NSTimeInterval(WALK_TIME / Double(walkFrames.count)))
            let moveLt = SKAction.moveByX( ONE_SQUARE_LT, y: ZERO, duration: WALK_TIME)
            self.runAction(walk)
            self.runAction(moveLt)
        }
    
    }
    
    /* handles moving down - same steps taken as in moveUP() */
    func moveDN() {
        
        if Int(gridLocation.x - 1) < 0 || Int(gridLocation.y - 1) < 0 {
            //do nothing
        } else {
            gridLocation.y -= 1
            gridLocation.x -= 1
            self.texture = sprites[3][0]
            var walkFrames = [SKTexture]()
            walkFrames.append(sprites[3][0])
            walkFrames.append(sprites[3][1])
            walkFrames.append(sprites[3][2])
            walkFrames.append(sprites[3][0])
            walkFrames.append(sprites[3][1])
            walkFrames.append(sprites[3][2])
            let walk = SKAction.animateWithTextures(walkFrames, timePerFrame: NSTimeInterval(WALK_TIME / Double(walkFrames.count)))
            let moveDn = SKAction.moveByX( ZERO, y: ONE_SQUARE_DN, duration: WALK_TIME)
            self.runAction(walk)
            self.runAction(moveDn)
        }
        
    }

    /* FROM APPLE. APPARENTLY NECESSARY IF I'M INHERITING FROM SKSpriteNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}