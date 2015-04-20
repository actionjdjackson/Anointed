//
//  GameScene.swift
//  Anointed The Game
//
//  Created by Jacob Jackson on 3/28/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import SpriteKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(
        filename, withExtension: nil)
    if (url == nil) {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer =
        AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil {
        println("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
}

class GameScene: SKScene {
    
    var lowerBanner = SKSpriteNode(imageNamed:"LowerBannerBASE")
    var experienceBars = SKSpriteNode(imageNamed:"ExperienceBarsBASE")
    var theOpenMenu = SKSpriteNode(imageNamed:"INVENTORYmenu")
    var menuUp = "NONE"
    var theGame = GameWorld()
    let hebrew = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)
    let formatter = NSDateFormatter()
    let dateLabel = SKLabelNode(fontNamed:"Courier New")
    let bibleEventTitle = SKLabelNode(fontNamed:"Chalkduster")
    let bibleEventDescription = SKLabelNode(fontNamed:"Chalkduster")
    var GAME_SPEED = 0.5
    var PREV_GAME_SPEED = 0.5
    var PAUSED = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        playBackgroundMusic("BackgroundMusicA.mp3")
        
        formatter.calendar = hebrew
        formatter.dateStyle = .FullStyle
        formatter.timeStyle = .MediumStyle
        
        createLocation()
        
        resetLowerBanner()
        
    }
    
    func resetLowerBanner() {
        lowerBanner.removeFromParent()
        lowerBanner = SKSpriteNode(imageNamed:"LowerBannerBASE")
        lowerBanner.position = CGPoint(x:CGRectGetMidX(self.frame)-112, y:32)
        self.addChild(lowerBanner)
        experienceBars.removeFromParent()
        experienceBars.position = CGPoint(x:800+112, y:32)
        self.addChild(experienceBars)
    }
    
    func activateLowerBanner(image: String) {
        lowerBanner.removeFromParent()
        lowerBanner = SKSpriteNode(imageNamed: image)
        lowerBanner.position = CGPoint(x:CGRectGetMidX(self.frame)-112, y:32)
        self.addChild(lowerBanner)
    }
    
    func clearMenu() {
        resetLowerBanner()
        theOpenMenu.removeFromParent()
        menuUp = "NONE"
    }
    
    func openMenu(theMenu: String) {
        activateLowerBanner("LowerBanner" + theMenu)
        menuUp = theMenu
        theOpenMenu.removeFromParent()
        theOpenMenu = SKSpriteNode(imageNamed: theMenu + "menu")
        theOpenMenu.position = CGPoint(x: CGRectGetMidX(self.frame), y: 300 + 64)
        self.addChild(theOpenMenu)
        var menuTitle = SKLabelNode(fontNamed: "Zapfino")
        menuTitle.text = theMenu.lowercaseString.capitalizedString
        menuTitle.fontSize = 24
        menuTitle.position = CGPoint(x: 0, y: CGRectGetMaxY(theOpenMenu.frame)/2 - 128)
        theOpenMenu.addChild(menuTitle)
        
        if theMenu == "INVENTORY" {
            var inventoryItems = SKLabelNode(fontNamed: "Arial")
            inventoryItems.text = " "
            inventoryItems.fontSize = 16
            inventoryItems.position = CGPoint(x: 0, y: CGRectGetMaxY(theOpenMenu.frame)/2 - 256)
            if theGame.player.inventory.count > 0 {
                inventoryItems.text = theGame.player.inventory[0].title
            }
            theOpenMenu.addChild(inventoryItems)
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)
        
        /* Has the user clicked a menu button on the lower banner? */
        if location.y <= 64 {
            if location.x <= 85 {
                if menuUp == "PARTY" {
                    clearMenu()
                } else {
                    openMenu("PARTY")
                }
            } else if location.x <= 85 + 64 {
                if menuUp == "NOTES" {
                    clearMenu()
                } else {
                    openMenu("NOTES")
                }
            } else if location.x <= 85 + 128 {
                if menuUp == "KNOWLEDGE" {
                    clearMenu()
                } else {
                    openMenu("KNOWLEDGE")
                }
            } else if location.x <= 85 + 128 + 64 - 10 {
                if menuUp == "PRAYER" {
                    clearMenu()
                } else {
                    openMenu("PRAYER")
                }
            } else if location.x <= 85 + 256 - 10 {
                if menuUp == "TRAVEL" {
                    clearMenu()
                } else {
                    openMenu("TRAVEL")
                }
            } else if location.x <= 85 + 256 + 64 - 10 {
                if menuUp == "INVENTORY" {
                    clearMenu()
                } else {
                    openMenu("INVENTORY")
                }
            } else if location.x <= 85 + 256 + 128 - 10 {
                if menuUp == "SKILLS" {
                    clearMenu()
                } else {
                    openMenu("SKILLS")
                }
            } else {
                clearMenu()
            }
        } else { /* Has the user clicked OUTSIDE the lower banner? */
            resetLowerBanner()
            theOpenMenu.removeFromParent()
            menuUp = "NONE"
        }
        
    }
    
    override func keyDown(theEvent: NSEvent) {
        
    }
    
    override func keyUp(theEvent: NSEvent) {
        
        let key = theEvent.keyCode
        
        if key == 49 && PAUSED == false {
            PREV_GAME_SPEED = GAME_SPEED
            GAME_SPEED = 0.0
            PAUSED = true
        } else if key == 49 && PAUSED == true {
            GAME_SPEED = PREV_GAME_SPEED
            PAUSED = false
        } else if key == 27 {
            GAME_SPEED /= 2.0
        } else if key == 24 {
            GAME_SPEED *= 2.0
        } else if key == 34 {
            if menuUp == "INVENTORY" {
                clearMenu()
            } else {
                openMenu("INVENTORY")
            }
        } else if key == 35 {
            if menuUp == "PARTY" {
                clearMenu()
            } else {
                openMenu("PARTY")
            }
        } else if key == 89 {
            theGame.player.texture = SKTexture(imageNamed: "characterUPPERLEFT")
            var moveUpperLeft = SKAction.moveByX(-64, y: 32, duration: 0.125)
            theGame.player.runAction(moveUpperLeft)
            theGame.player.currentGridLocation.x += 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else if key == 91 {
            theGame.player.texture = SKTexture(imageNamed: "characterUP")
            var moveUp = SKAction.moveByX(0, y: 64, duration: 0.125)
            theGame.player.runAction(moveUp)
            theGame.player.currentGridLocation.x += 1
            theGame.player.currentGridLocation.y += 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else if key == 92 {
            theGame.player.texture = SKTexture(imageNamed: "characterUPPERRIGHT")
            var moveUpperRight = SKAction.moveByX(64, y: 32, duration: 0.125)
            theGame.player.runAction(moveUpperRight)
            theGame.player.currentGridLocation.y += 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else if key == 86 {
            theGame.player.texture = SKTexture(imageNamed: "characterLEFT")
            var moveLeft = SKAction.moveByX(-128, y: 0, duration: 0.125)
            theGame.player.runAction(moveLeft)
            theGame.player.currentGridLocation.y -= 1
            theGame.player.currentGridLocation.x += 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else if key == 87 {
            theGame.player.texture = SKTexture(imageNamed: "characterSEATED")
        } else if key == 88 {
            theGame.player.texture = SKTexture(imageNamed: "characterRIGHT")
            var moveRight = SKAction.moveByX(128, y: 0, duration: 0.125)
            theGame.player.runAction(moveRight)
            theGame.player.currentGridLocation.y += 1
            theGame.player.currentGridLocation.x -= 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else if key == 83 {
            theGame.player.texture = SKTexture(imageNamed: "characterLOWERLEFT")
            var moveLowerLeft = SKAction.moveByX(-64, y: -32, duration: 0.125)
            theGame.player.runAction(moveLowerLeft)
            theGame.player.currentGridLocation.y -= 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else if key == 84 {
            theGame.player.texture = SKTexture(imageNamed: "characterDOWN")
            var moveDown = SKAction.moveByX(0, y: -64, duration: 0.125)
            theGame.player.runAction(moveDown)
            theGame.player.currentGridLocation.y -= 1
            theGame.player.currentGridLocation.x -= 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else if key == 85 {
            theGame.player.texture = SKTexture(imageNamed: "characterLOWERRIGHT")
            var moveLowerRight = SKAction.moveByX(64, y: -32, duration: 0.125)
            theGame.player.runAction(moveLowerRight)
            theGame.player.currentGridLocation.x -= 1
            println(theGame.player.currentGridLocation)
            pickUpItems(theGame.player.currentGridLocation)
        } else {
            println(key)
        }
        
    }
    
    func pickUpItems(pt: CGPoint) {
        var x = Int(pt.x)
        var y = Int(pt.y)
        if theGame.currentLocation.grid[x][y].contents.count > 0 {
            println("Found an item!")
            theGame.player.inventory.append(theGame.currentLocation.grid[x][y].contents[0])
            theGame.currentLocation.grid[x][y].contents[0].removeFromParent()
            theGame.currentLocation.grid[x][y].contents.removeAtIndex(0)
        }
        
    }
    
    func isoTo2D(pt: CGPoint) -> CGPoint {
        var tempPt = CGPoint(x: 0, y: 0)
        tempPt.x = (2 * pt.y + pt.x) / 2
        tempPt.y = (2 * pt.y - pt.x) / 2
        return(tempPt)
    }
    
    func twoDToIso(pt: CGPoint) -> CGPoint {
        var tempPt = CGPoint(x: 0, y: 0)
        tempPt.x = pt.x - pt.y
        tempPt.y = (pt.x + pt.y) / 2
        return(tempPt)
    }
    
    func getTileCoordinates(pt: CGPoint, tileHeight: CGFloat) -> CGPoint {
        var tempPt = CGPoint(x: 0, y: 0)
        tempPt.x = floor(pt.x / tileHeight)
        tempPt.y = floor(pt.y / tileHeight)
        return(tempPt)
    }
    
    func createLocation() {
        
        for x in 0...theGame.currentLocation.grid.count-1 {
            for y in 0...theGame.currentLocation.grid[0].count-1 {
                var xx = theGame.currentLocation.grid.count-x-1
                var yy = theGame.currentLocation.grid[0].count-y-1
                var square = SKSpriteNode(imageNamed:theGame.currentLocation.grid[xx][yy].texture)
                square.position = twoDToIso(CGPoint(x: xx*64 + 512, y: yy*64 - 128))
                self.addChild(square)
                if theGame.currentLocation.grid[xx][yy].contents.count > 0 {
                    theGame.currentLocation.grid[xx][yy].contents[0].position = twoDToIso(CGPoint(x: xx*64 + 512, y: yy*64 - 128))
                    self.addChild(theGame.currentLocation.grid[xx][yy].contents[0])
                }
            }
        }
        
        theGame.player.position = twoDToIso(CGPoint(x: theGame.player.currentGridLocation.x*64 + 512 + 32, y: theGame.player.currentGridLocation.y*64 + 32 - 128))
        self.addChild(theGame.player)
        
        dateLabel.fontSize = 14
        dateLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:64+14)
        self.addChild(dateLabel)
        
        bibleEventTitle.text = " "
        bibleEventTitle.fontSize = 18
        bibleEventTitle.position = CGPoint(x:CGRectGetMidX(self.frame), y:512)
        self.addChild(bibleEventTitle)
        
        bibleEventDescription.text = " "
        bibleEventDescription.fontSize = 12
        bibleEventDescription.position = CGPoint(x:CGRectGetMidX(self.frame), y:256+128)
        self.addChild(bibleEventDescription)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        dateLabel.text = formatter.stringFromDate(theGame.gameDate)
        
        if theGame.bibleEvents.count == theGame.nextEvent {
            exit(0)
        }
        
        if theGame.bibleEvents[theGame.nextEvent].date.laterDate(theGame.gameDate) == theGame.gameDate {

            bibleEventTitle.text = theGame.bibleEvents[theGame.nextEvent].title
            bibleEventDescription.text = theGame.bibleEvents[theGame.nextEvent].description
            
            theGame.nextEvent++
        
        }
        
        theGame.gameDate = theGame.gameDate.dateByAddingTimeInterval(GAME_SPEED)
        
    }
    
}
