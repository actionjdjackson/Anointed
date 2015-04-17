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
    var GAME_SPEED = 1.0
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
        
        let key = theEvent.keyCode
        if key == 49 && PAUSED == false {
            GAME_SPEED = 0.0
            PAUSED = true
        } else if key == 49 && PAUSED == true {
            GAME_SPEED = 1.0
            PAUSED = false
        } else if key == 24 {
            GAME_SPEED = 10.0
        } else if key == 27 {
            GAME_SPEED = 0.01
        } else {
            println(key)
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
        
        for x in 0...15 {
            for y in 0...11 {
                var square = SKSpriteNode(imageNamed:theGame.currentLocation.grid[x][y].texture)
                square.position = twoDToIso(CGPoint(x: x*64 + 512, y: y*64 - 128))
                self.addChild(square)
                if theGame.currentLocation.grid[x][y].contents.count > 0 {
                    var item = SKSpriteNode(imageNamed: theGame.currentLocation.grid[x][y].contents[0].spriteName)
                    item.position = twoDToIso(CGPoint(x: x*64 + 512, y: y*64 - 128))
                    self.addChild(item)
                }
            }
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        dateLabel.removeFromParent()
        dateLabel.text = formatter.stringFromDate(theGame.gameDate)
        dateLabel.fontSize = 14
        dateLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:256)
        self.addChild(dateLabel)
        
        if theGame.bibleEvents[theGame.nextEvent].date.isEqualToDate( theGame.gameDate ) {
            
            bibleEventTitle.removeFromParent()
            bibleEventTitle.text = theGame.bibleEvents[theGame.nextEvent].title
            bibleEventTitle.fontSize = 18
            bibleEventTitle.position = CGPoint(x:CGRectGetMidX(self.frame), y:512)
            self.addChild(bibleEventTitle)
            
            bibleEventDescription.removeFromParent()
            bibleEventDescription.text = theGame.bibleEvents[theGame.nextEvent].description
            bibleEventDescription.fontSize = 12
            bibleEventDescription.position = CGPoint(x:CGRectGetMidX(self.frame), y:256+128)
            self.addChild(bibleEventDescription)
            
            theGame.nextEvent++
            
            if theGame.bibleEvents.count <= theGame.nextEvent {
                EXIT_SUCCESS
            }
            
        }
        theGame.gameDate = theGame.gameDate.dateByAddingTimeInterval(GAME_SPEED)
    }
    
}
