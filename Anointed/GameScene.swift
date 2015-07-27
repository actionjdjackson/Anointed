//
//  GameScene.swift
//  Anointed The Game
//
//  Created by Jacob Jackson on 3/28/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import SpriteKit
import AVFoundation

var bibleEventTitle = SKLabelNode(fontNamed:"Chalkduster")
var bibleEventDescription = MultiLineLabel(text: "Placeholder text blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah Lorem ipsum dolor setia imet raggi dieassm ilitia", fontName: "Chalkduster", fontsize: 12, wrap: 1024 - 64)

var backgroundMusicPlayer: AVAudioPlayer!
var soundPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {    //sets up an audio player to play background music
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    if (url == nil) {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil {
        println("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1    //loop continuously
    backgroundMusicPlayer.prepareToPlay()   //load into memory
    backgroundMusicPlayer.play()    //play song
}

func playSound(filename: String) {    //sets up an audio player to play sound effects
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    if (url == nil) {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    soundPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
    if soundPlayer == nil {
        println("Could not create audio player: \(error!)")
        return
    }
    
    soundPlayer.numberOfLoops = 0   //play once
    soundPlayer.prepareToPlay() //load into memory
    soundPlayer.play()  //play sound
}

class GameScene: SKScene {
    
    var lowerBanner = SKSpriteNode(imageNamed:"LowerBannerBASE")    //load button bar into memory
    var experienceBars = SKSpriteNode(imageNamed:"ExperienceBarsBASE")  //load experience bar into memory
    var theOpenMenu = SKSpriteNode(imageNamed:"INVENTORYmenu")  //load inventory menu as default menu to open
    var menuUp = "NONE" //no menu up for starters
    var theGame = GameWorld()   //sets up the game world
    let hebrew = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew) //defines hebrew calendar
    let formatter = NSDateFormatter()   //sets up a date formatter for displaying hebrew dates
    let dateLabel = SKLabelNode(fontNamed:"Courier New")    //creates date label with font Courier New (fixed width)
    var GAME_SPEED = 1.0    //default game speed is 60 game seconds per real second
    var PREV_GAME_SPEED = 1.0   //this is used for when pausing the game, and going back to previous game speed
    var PAUSED = false  //obviously, the game doesn't start out paused
    var world = SKNode() //sets up the world node
    var progBarFrame : SKSpriteNode = SKSpriteNode(imageNamed: "progressBarFrame")
    var progBar : SKSpriteNode = SKSpriteNode(imageNamed: "progressBar")
    var progBarCaption : SKLabelNode = SKLabelNode(text: "")
    var progBarTime : Double = 0.0
    var progBarDuration : Double = 0.0
    var skillInUse : Int = -1
    var giftSkills : [Skill] = []
    
    let CENTER_OF_SCREEN_X = CGFloat(0.5)
    let CENTER_OF_SCREEN_Y = CGFloat(0.5)
    let LOWER_BANNER_X = CGFloat(-112)
    let LOWER_BANNER_Y = CGFloat(-768/2 + 32)
    let LOWER_BANNER_Z = CGFloat(2.0)
    let EXPERIENCE_BARS_X = CGFloat(400)
    let EXPERIENCE_BARS_Y = CGFloat(-768/2 + 32)
    let EXPERIENCE_BARS_Z = CGFloat(2.0)
    let OPEN_MENU_Y = CGFloat(-32 + 8)
    let OPEN_MENU_Z = CGFloat(2.0)
    let MENU_TITLE_FONT_SIZE = CGFloat(24)
    let MENU_TITLE_X = CGFloat(0.0)
    let MENU_TITLE_Y = CGFloat(CGRectGetMaxY(SKSpriteNode(imageNamed:"INVENTORYmenu").frame) / 2.0 + 128 - 32)
    let SKILLS_BAR_BASE_X = CGFloat(-16)
    let SKILLS_BAR_BASE_Y = CGFloat(-768/2 + 32 + 16)
    let SKILLS_BAR_BASE_Z = CGFloat(2.0)
    let SKILL_POSITION_BASE_X = CGFloat(96.0 - CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.width) / 2.0)
    let SKILL_POSITION_BASE_Y = CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.height) / 2.0 - 518.0
    let GIFT_POSITION_BASE_Y = CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.height) / 2.0 - 128.0 - 48.0
    let GIFT_POSITION_BASE_X = CGFloat(96.0 - CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.width) / 2.0) - 2.0
    let GIFT_SKILLS_GRID_HEIGHT = 9
    let SKILL_ICON_SIZE = CGFloat(32.0)
    let INVENTORY_ITEM_BASE_X = CGFloat(88 - 234)
    let INVENTORY_ITEM_BASE_Y = CGFloat(100)
    let INVENTORY_ITEM_SIZE = CGFloat(32.0)
    let INVENTORY_GRID_WIDTH = 10
    let INVENTORY_GRID_HEIGHT = 12
    let SKILLS_GRID_WIDTH = 10
    let SKILLS_GRID_HEIGHT = 2
    let LOWER_BANNER_TOP_EDGE = CGFloat(64 - 768 / 2)
    let PARTY_BUTTON_EDGE = CGFloat(85 - 1024 / 2)
    let NOTES_BUTTON_EDGE = CGFloat(85 + 64 - 1024 / 2)
    let KNOWLEDGE_BUTTON_EDGE = CGFloat(85 + 128 - 1024 / 2)
    let PRAYER_BUTTON_EDGE = CGFloat(85 + 128 + 64 - 10 - 1024 / 2)
    let TRAVEL_BUTTON_EDGE = CGFloat(85 + 256 - 10 - 1024 / 2)
    let INVENTORY_BUTTON_EDGE = CGFloat(85 + 256 + 64 - 10 - 1024 / 2)
    let SKILLS_BUTTON_EDGE = CGFloat(85 + 256 + 128 - 10 - 1024 / 2)
    let SKILLS_BAR_EDGE = CGFloat(-32)
    let TIMESTAMP_OFFSET_Y = CGFloat(64 + 14 - 768 / 2)
    let TIMESTAMP_OFFSET_Z = CGFloat(100.0)
    let TIMESTAMP_FONT_SIZE = CGFloat(14)
    let PROG_BAR_WIDTH = CGFloat(256.0)
    let PLAYER_MOVE_TIME = 0.125
    let SECONDS_IN_ONE_HOUR = 60.0 * 60.0
    
    let SPACEBAR = UInt16(49)
    let MINUS = UInt16(27)
    let PLUS = UInt16(24)
    let I = UInt16(34)
    let P = UInt16(35)
    let N = UInt16(45)
    let K = UInt16(40)
    let R = UInt16(15)
    let T = UInt16(17)
    let L = UInt16(37)
    let NUMPAD7 = UInt16(89)
    let NUMPAD8 = UInt16(91)
    let NUMPAD9 = UInt16(92)
    let NUMPAD4 = UInt16(86)
    let NUMPAD5 = UInt16(87)
    let NUMPAD6 = UInt16(88)
    let NUMPAD1 = UInt16(83)
    let NUMPAD2 = UInt16(84)
    let NUMPAD3 = UInt16(85)
    let Q = UInt16(12)
    let W = UInt16(13)
    let E = UInt16(14)
    let A = UInt16(0)
    let S = UInt16(1)
    let D = UInt16(2)
    let Z = UInt16(6)
    let X = UInt16(7)
    let C = UInt16(8)
    
    /* INITIALIZATION */
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        formatter.calendar = hebrew     //using the Hebrew calendar
        formatter.dateStyle = .FullStyle    //full date
        formatter.timeStyle = .MediumStyle  //basic timestamp
        
        self.addChild(world)    //world node is added to the scene immediately
        self.anchorPoint = CGPoint(x: CENTER_OF_SCREEN_X, y: CENTER_OF_SCREEN_Y) //anchor the screen on center
        
        createLocation()    //creates the current location in spritekit
        
        setupLowerBanner()  //creates the game function buttons and experience bars on a lower banner
        
        playBackgroundMusic("BackgroundMusicA.mp3") //start background music
        
    }
    
    /* EVERY FRAME... */
    override func didFinishUpdate() {
        self.centerOnNode(theGame.player)   //continually center on the player
    }
    
    /* centers the screen on a given SKNode, in our case the player (as above) */
    func centerOnNode( node: SKNode ) {
        
        let cameraPositionInScene = node.scene?.convertPoint(node.position, fromNode: node.parent!) //convert point
        node.parent!.position = CGPointMake(node.parent!.position.x - cameraPositionInScene!.x, node.parent!.position.y - cameraPositionInScene!.y)   //translate to give parent node correct position
        
    }
    
    /* CREATES THE LOWER BANNER WITH GAME BUTTONS, SKILLS, AND EXPERIENCE BARS */
    func setupLowerBanner() {
        lowerBanner.removeFromParent()  //just in case we're re-setting-up, remove the current banner
        lowerBanner = SKSpriteNode(imageNamed:"LowerBannerBASE")    //define the lowerBanner as basic button bar with nothing selected
        lowerBanner.position = CGPoint( x: LOWER_BANNER_X, y: LOWER_BANNER_Y )   //put the button bar at correct location
        lowerBanner.zPosition = LOWER_BANNER_Z
        self.addChild(lowerBanner)  //add the banner to the current scene
        experienceBars.removeFromParent()   //just in case we're re-setting-up, remove the current exp bars
        experienceBars.position = CGPoint(x: EXPERIENCE_BARS_X, y: EXPERIENCE_BARS_Y) //put experience bars at the correct location
        experienceBars.zPosition = EXPERIENCE_BARS_Z
        self.addChild(experienceBars)   //add the experience bars (to the right of the button bar, as above)
        
        
        if theGame.player.skills.count > 0 {
            for n in 0...theGame.player.skills.count-1 {
                var skill = SKSpriteNode(imageNamed: theGame.player.skills[n].sprite)
                skill.position = CGPoint(x: SKILLS_BAR_BASE_X + CGFloat(n % SKILLS_GRID_WIDTH) * SKILL_ICON_SIZE, y: SKILLS_BAR_BASE_Y)
                skill.zPosition = SKILLS_BAR_BASE_Z
                if n >= SKILLS_GRID_WIDTH {
                    fatalError("TOO MANY SKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")
                }
                theOpenMenu.addChild(skill)
            }
        }
        
        grabGiftSkills()
        
        if giftSkills.count > 0 {
            for n in 0...giftSkills.count-1 {
                var skill = SKSpriteNode(imageNamed: giftSkills[n].sprite)
                skill.position = CGPoint(x: SKILLS_BAR_BASE_X + CGFloat(n % SKILLS_GRID_WIDTH) * SKILL_ICON_SIZE, y: SKILLS_BAR_BASE_Y - 48)
                skill.zPosition = SKILLS_BAR_BASE_Z
                if n >= SKILLS_GRID_WIDTH {
                    fatalError("TOO MANY SPIRITUAL GIFT SKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")
                }
                theOpenMenu.addChild(skill)
            }
        }
    
    }
    
    /* GRABS ALL GIFT SKILLS AND PUTS THEM INTO AN ARRAY STORED IN THE SCENE FOR EASY ACCESS **/
    func grabGiftSkills() {
        
        giftSkills = []
        if theGame.player.spiritualGifts.count > 0 {
            for n in 0...theGame.player.spiritualGifts.count-1 {
                if theGame.player.spiritualGifts[n].subSkills.count > 0 {
                    for m in 0...theGame.player.spiritualGifts[n].subSkills.count-1 {
                        giftSkills.append(theGame.player.spiritualGifts[n].subSkills[m])
                    }
                }
            }
        }
        
    }
    
    /* RESETS THE LOWER BANNER TO NOTHING SELECTED OR HIGHLIGHTED */
    func resetLowerBanner() {
        lowerBanner.texture = SKTexture(imageNamed:"LowerBannerBASE")   //changes the lower banner's texture to the plain button bar with nothing selected
    }
    
    /* ACTIVATES (HIGHLIGHTS) A PARTICULAR BUTTON ON THE LOWER BANNER */
    func activateLowerBanner(image: String) {
        lowerBanner.texture = SKTexture(imageNamed: image)  //changes the lower banner's texture to an image named whatever
    }
    
    /* CLEARS THE LOWER BANNER, REMOVES ANY OPEN MENU FROM THE SCREEN */
    func clearMenu() {
        resetLowerBanner()  //nothing highlighted
        theOpenMenu.removeFromParent()  //remove the open menu if it's there
        menuUp = "NONE" //set menuUp to "NONE" - so we know there's no menu up at this time
    }
    
    /* OPENS A MENU NAMED theMenu - HIGHLIGHTS THE BUTTON PRESSED AND DISPLAYS THE RESPECTIVE MENU DISPLAY */
    func openMenu(theMenu: String) {
        activateLowerBanner("LowerBanner" + theMenu)    //highlights the button
        menuUp = theMenu    //keeping track of what menu is open currently
        theOpenMenu.removeFromParent()  //remove any previous menu
        theOpenMenu = SKSpriteNode(imageNamed: theMenu + "menu")    //sets up the menu image
        theOpenMenu.position = CGPoint( x: CGRectGetMidX(self.frame), y: CGFloat(OPEN_MENU_Y) ) //places it just above the button bar, and centered on the scene's frame
        theOpenMenu.zPosition = OPEN_MENU_Z
        self.addChild(theOpenMenu)  //displays the menu
        var menuTitle = SKLabelNode(fontNamed: "Zapfino")   //sets up a label for the menu title
        menuTitle.text = theMenu.lowercaseString.capitalizedString  //makes the menu Thisway instead of THISWAY
        menuTitle.fontSize = MENU_TITLE_FONT_SIZE //sets the font size
        menuTitle.position = CGPoint(x: MENU_TITLE_X, y: MENU_TITLE_Y)    //positions at top center of menu
        theOpenMenu.addChild(menuTitle) //displays the label as a child of the current menu
        
        /* SPECIAL INSTRUCTIONS FOR INVENTORY MENU - ***INCOMPLETE*** */
        if theMenu == "INVENTORY" { //if we're working with the inventory menu
            if theGame.player.inventory.count > 0 {
                for n in 0...theGame.player.inventory.count-1   { //if there's anything in the player's inventory
                    var item = SKSpriteNode(imageNamed: theGame.player.inventory[n].spriteName) //grab the title of the first item
                    item.position = CGPoint( x: INVENTORY_ITEM_BASE_X + CGFloat(n % INVENTORY_GRID_WIDTH) * INVENTORY_ITEM_SIZE, y: INVENTORY_ITEM_BASE_Y - CGFloat(Int(n / INVENTORY_GRID_WIDTH)) * INVENTORY_ITEM_SIZE)
                    if n > INVENTORY_GRID_WIDTH * INVENTORY_GRID_HEIGHT {
                        fatalError("TOO MANY ITEMS IN INVENTORY. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")
                    }
                    theOpenMenu.addChild(item)
                }
            }
        }
        
        /* SPECIAL INSTRUCTIONS FOR SKILLS MENU - ***INCOMPLETE*** */
        if theMenu ==  "SKILLS" { //if we're working with the skills menu
            if theGame.player.skills.count > 0 {
                for n in 0...theGame.player.skills.count-1 {
                    var skill = theGame.player.skills[n]
                    skill.position = CGPoint(x: SKILL_POSITION_BASE_X + CGFloat(n % SKILLS_GRID_WIDTH) * SKILL_ICON_SIZE, y: SKILL_POSITION_BASE_Y - CGFloat(Int(n / SKILLS_GRID_WIDTH)) * SKILL_ICON_SIZE)
                    if n >= SKILLS_GRID_WIDTH * SKILLS_GRID_HEIGHT {
                        fatalError("TOO MANY SKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")
                    }
                    theOpenMenu.addChild(skill)
                }
            }
            if theGame.player.spiritualGifts.count > 0 {
                for n in 0...theGame.player.spiritualGifts.count-1 {
                    var gift = theGame.player.spiritualGifts[n]
                    gift.position = CGPoint(x: GIFT_POSITION_BASE_X + CGFloat(n % SKILLS_GRID_WIDTH) * SKILL_ICON_SIZE, y: GIFT_POSITION_BASE_Y - CGFloat(Int(n / SKILLS_GRID_WIDTH)) * SKILL_ICON_SIZE)
                    theOpenMenu.addChild(gift)
                    if n >= SKILLS_GRID_WIDTH {
                        fatalError("TOO MANY GIFTS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")
                    }
                    for m in 0...gift.subSkills.count-1 {
                        var skill = gift.subSkills[m]
                        skill.position = CGPoint(x: GIFT_POSITION_BASE_X + CGFloat(Int(m / SKILLS_GRID_HEIGHT)) * SKILL_ICON_SIZE, y: GIFT_POSITION_BASE_Y - CGFloat((m + 1) % GIFT_SKILLS_GRID_HEIGHT) * SKILL_ICON_SIZE)
                        if m >= GIFT_SKILLS_GRID_HEIGHT {
                            fatalError("TOO MANY GIFT SKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON")
                        }
                        theOpenMenu.addChild(skill)
                    }
                }
            }
        }
        
        /* NEED TO WRITE CODE FOR OTHER MENUS' SPECIAL INSTRUCTIONS */
        
    }
    
    /* HANDLES ALL MOUSE CLICKS */
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)    //grabs the location where the user has clicked
        
        /* Has the user clicked a menu button on the lower banner? */
        if location.y <= LOWER_BANNER_TOP_EDGE {
            if location.x <= PARTY_BUTTON_EDGE {    //if they clicked the party button...
                if menuUp == "PARTY" {  //if it's already up,
                    clearMenu() // clear it
                } else {    // otherwise,
                    openMenu("PARTY")   //open the party menu
                }
            } else if location.x <= NOTES_BUTTON_EDGE {    //same thing here and for all menu button clicks
                if menuUp == "NOTES" {
                    clearMenu()
                } else {
                    openMenu("NOTES")
                }
            } else if location.x <= KNOWLEDGE_BUTTON_EDGE {
                if menuUp == "KNOWLEDGE" {
                    clearMenu()
                } else {
                    openMenu("KNOWLEDGE")
                }
            } else if location.x <= PRAYER_BUTTON_EDGE {
                if menuUp == "PRAYER" {
                    clearMenu()
                } else {
                    openMenu("PRAYER")
                }
            } else if location.x <= TRAVEL_BUTTON_EDGE {
                if menuUp == "TRAVEL" {
                    clearMenu()
                } else {
                    openMenu("TRAVEL")
                }
            } else if location.x <= INVENTORY_BUTTON_EDGE {
                if menuUp == "INVENTORY" {
                    clearMenu()
                } else {
                    openMenu("INVENTORY")
                }
            } else if location.x <= SKILLS_BUTTON_EDGE {
                if menuUp == "SKILLS" {
                    clearMenu()
                } else {
                    openMenu("SKILLS")
                }
            } else if location.x >= SKILLS_BAR_EDGE && theGame.player.skills.count > 0 && location.y >= SKILLS_BAR_BASE_Y - 16 {    //if we're beyond the skills bar edge and the player has at least 1 skill
                var skillNo = Int((location.x+32) / 32) //
                if skillNo < 0 { skillNo = 0 }
                if skillNo > theGame.player.skills.count-1 { return }
                if theGame.player.skills[skillNo].canUse() {
                    if skillInUse < 0 {
                        makeProgressBarFor( SECONDS_IN_ONE_HOUR * (theGame.player.skills[skillNo].hoursToComplete - log(Double(theGame.player.skills[0].level) * 1.0)), caption: theGame.player.skills[0].title )
                        skillInUse = skillNo
                    }
                }
            } else if location.x >= SKILLS_BAR_EDGE && giftSkills.count > 0 && location.y >= SKILLS_BAR_BASE_Y - 48 && location.y <= SKILLS_BAR_BASE_Y - 16 {
                var skillNo = Int((location.x+32) / 32) //
                if skillNo < 0 { skillNo = 0 }
                if skillNo > theGame.player.skills.count-1 { return }
                if giftSkills[skillNo].canUse() {
                    if skillInUse < 0 {
                        makeProgressBarFor( SECONDS_IN_ONE_HOUR * (giftSkills[skillNo].hoursToComplete - log(Double(giftSkills[skillNo].level) * 1.0)), caption: giftSkills[skillNo].title )
                        skillInUse = skillNo
                    }
                }
            } else {
                clearMenu()
            }
        } else { /* Has the user clicked OUTSIDE the lower banner? */
            //resetLowerBanner()  //clear all button highlights
            //theOpenMenu.removeFromParent()  //remove any open menu
            //menuUp = "NONE" //set menuUp to "NONE" - everything is cleared
        }
        
    }
    
    /* PREVENTS BEEP WHEN A KEY IS PRESSED */
    override func keyDown(theEvent: NSEvent) {
        
    }
    
    /* HANDLES TOGGLING PAUSING AND UNPAUSING THE GAME */
    func pauseUnPause() {
        
        if PAUSED == false {    //if the game is currently running
            PREV_GAME_SPEED = GAME_SPEED    //store game speed for when unpaused
            GAME_SPEED = 0.0    //game speed set to zero, which is pause mode
            PAUSED = true   //keep track that we're paused
        } else {    //if the game is paused
            bibleEventTitle.removeFromParent()  //remove the bible event title
            bibleEventDescription.removeFromParent()    //remove the bible event text
            GAME_SPEED = PREV_GAME_SPEED    //restore game speed from before
            PAUSED = false  //no longer paused
        }
        
    }
    
    /* PAUSES ONLY */
    func pause() {
        
        if PAUSED == false {
            PREV_GAME_SPEED = GAME_SPEED
        }
        GAME_SPEED = 0.0
        PAUSED = true
        
    }
    
    /* UNPAUSES ONLY */
    func unpause() {
        
        bibleEventTitle.removeFromParent()  //remove the bible event title
        bibleEventDescription.removeFromParent()    //remove the bible event text
        GAME_SPEED = PREV_GAME_SPEED
        PAUSED = false
        
    }
    
    /* HANDLES ALL KEYPRESSES */
    override func keyUp(theEvent: NSEvent) {
        
        let key = theEvent.keyCode  //grab the key code of the key pressed
        
        if key == SPACEBAR { //SPACEBAR IS PRESSED, PAUSE/UNPAUSE GAME
            pauseUnPause()
        } else if key == MINUS {   //MINUS KEY PRESSED
            GAME_SPEED /= 2.0   //divide game speed in half
        } else if key == PLUS {   //PLUS KEY PRESSED
            GAME_SPEED *= 2.0   //multiply game speed by two
        } else if key == I {   //'I' KEY IS PRESSED
            if menuUp == "INVENTORY" {  //pretty self explanatory, shows the menu corresponding to the key pressed
                clearMenu()
            } else {
                openMenu("INVENTORY")
            }
        } else if key == P {   //'P' KEY PRESSED
            if menuUp == "PARTY" {
                clearMenu()
            } else {
                openMenu("PARTY")
            }
        } else if key == N {   //'N' KEY
            if menuUp == "NOTES" {
                clearMenu()
            } else {
                openMenu("NOTES")
            }
        } else if key == K {   //'K'
            if menuUp == "KNOWLEDGE" {
                clearMenu()
            } else {
                openMenu("KNOWLEDGE")
            }
        } else if key == R {   //'R'
            if menuUp == "PRAYER" {
                clearMenu()
            } else {
                openMenu("PRAYER")
            }
        } else if key == T {   //'T'
            if menuUp == "TRAVEL" {
                clearMenu()
            } else {
                openMenu("TRAVEL")
            }
        } else if key == L {    //'L'
            if menuUp == "SKILLS" {
                clearMenu()
            } else {
                openMenu("SKILLS")
            }
            
        /* CHARACTER MOVEMENT & STATE CHANGE (SITTING, ETC.) CODE HERE */
        } else if ( key == NUMPAD7 || key == Q ) && !PAUSED {   //'7' NUM PAD PRESSED - MOVING INTO UPPER LEFT SQUARE
            theGame.player.texture = SKTexture(imageNamed: "characterUPPERLEFT")    //displays char moving up-left
            if Int(theGame.player.currentGridLocation.x + 1) < theGame.currentLocation.grid[0].count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y)][Int(theGame.player.currentGridLocation.x + 1)].extraObject == "" { //if in bounds and no collision
                let moveUpperLeft = SKAction.moveByX(-64, y: 32, duration: PLAYER_MOVE_TIME)   //move gradually to new location
                theGame.player.runAction(moveUpperLeft) //runs the action defined above
                theGame.player.currentGridLocation.x += 1   //sets grid location (corresponding to matrix, not spritekit location)
                pickUpItems(theGame.player.currentGridLocation) //pick up any items in-square automatically
                orderCorrectly()    //change the Z order of the player depending on objects around them
            }
        } else if ( key == NUMPAD8 || key == W ) && !PAUSED {   //'8' NUM PAD PRESSED - everything else is the same idea as above, just look at [imageNamed:"characterXXXX"] for movement direction
            theGame.player.texture = SKTexture(imageNamed: "characterUP")
            if Int(theGame.player.currentGridLocation.x + 1) < theGame.currentLocation.grid[0].count && Int(theGame.player.currentGridLocation.y + 1) < theGame.currentLocation.grid.count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y + 1)][Int(theGame.player.currentGridLocation.x + 1)].extraObject == "" {
                let moveUp = SKAction.moveByX(0, y: 64, duration: PLAYER_MOVE_TIME)
                theGame.player.runAction(moveUp)
                theGame.player.currentGridLocation.x += 1
                theGame.player.currentGridLocation.y += 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if ( key == NUMPAD9 || key == E ) && !PAUSED {   //'9' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterUPPERRIGHT")
            if Int(theGame.player.currentGridLocation.y + 1) < theGame.currentLocation.grid.count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y + 1)][Int(theGame.player.currentGridLocation.x)].extraObject == "" {
                let moveUpperRight = SKAction.moveByX(64, y: 32, duration: PLAYER_MOVE_TIME)
                theGame.player.runAction(moveUpperRight)
                theGame.player.currentGridLocation.y += 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if ( key == NUMPAD4 || key == A ) && !PAUSED {   //'4' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterLEFT")
            if Int(theGame.player.currentGridLocation.x + 1) < theGame.currentLocation.grid[0].count && Int(theGame.player.currentGridLocation.y - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y - 1)][Int(theGame.player.currentGridLocation.x + 1)].extraObject == "" {
                let moveLeft = SKAction.moveByX(-128, y: 0, duration: PLAYER_MOVE_TIME)
                theGame.player.runAction(moveLeft)
                theGame.player.currentGridLocation.y -= 1
                theGame.player.currentGridLocation.x += 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if ( key == NUMPAD5 || key == S ) && !PAUSED {   //'5' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterSEATED") //make character sit for center key
        } else if ( key == NUMPAD6 || key == D ) && !PAUSED {   //'6' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterRIGHT")
            if Int(theGame.player.currentGridLocation.x - 1) >= 0 && Int(theGame.player.currentGridLocation.y + 1) < theGame.currentLocation.grid.count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y + 1)][Int(theGame.player.currentGridLocation.x - 1)].extraObject == "" {
                let moveRight = SKAction.moveByX(128, y: 0, duration: PLAYER_MOVE_TIME)
                theGame.player.runAction(moveRight)
                theGame.player.currentGridLocation.y += 1
                theGame.player.currentGridLocation.x -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if ( key == NUMPAD1 || key == Z ) && !PAUSED {   //'1' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterLOWERLEFT")
            if Int(theGame.player.currentGridLocation.y - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y - 1)][Int(theGame.player.currentGridLocation.x)].extraObject == "" {
                let moveLowerLeft = SKAction.moveByX(-64, y: -32, duration: PLAYER_MOVE_TIME)
                theGame.player.runAction(moveLowerLeft)
                theGame.player.currentGridLocation.y -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if ( key == NUMPAD2 || key == X ) && !PAUSED {   //'2' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterDOWN")
            if Int(theGame.player.currentGridLocation.x - 1) >= 0 && Int(theGame.player.currentGridLocation.y - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y - 1)][Int(theGame.player.currentGridLocation.x - 1)].extraObject == "" {
                let moveDown = SKAction.moveByX(0, y: -64, duration: PLAYER_MOVE_TIME)
                theGame.player.runAction(moveDown)
                theGame.player.currentGridLocation.y -= 1
                theGame.player.currentGridLocation.x -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if ( key == NUMPAD3 || key == C ) && !PAUSED {   //'3' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterLOWERRIGHT")
            if Int(theGame.player.currentGridLocation.x - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y)][Int(theGame.player.currentGridLocation.x - 1)].extraObject == "" {
                let moveLowerRight = SKAction.moveByX(64, y: -32, duration: PLAYER_MOVE_TIME)
                theGame.player.runAction(moveLowerRight)
                theGame.player.currentGridLocation.x -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else {
            println(key)    //FOR DEBUGGING, PRINT ANY KEY CODE NOT YET USED
        }
        
    }
    
    /* CHANGES THE Z POSITION OF THE CHARACTER TO KEEP THEM IN FRONT OF OR BEHIND OTHER OBJECTS LIKE TREES DEPENDING ON THEIR LOCATION */
    func orderCorrectly() {
        
        var xcoord = Int(theGame.player.currentGridLocation.x + 1)  //looking at the square just above the player
        var ycoord = Int(theGame.player.currentGridLocation.y + 1)  //  "     "   "   "     "     "     "   "
        if xcoord >= 0 && xcoord < theGame.currentLocation.grid[0].count && ycoord >= 0 && ycoord < theGame.currentLocation.grid.count {
            if theGame.currentLocation.grid[ycoord][xcoord].extraObject != "" || theGame.currentLocation.grid[ycoord-1][xcoord].extraObject != "" || theGame.currentLocation.grid[ycoord][xcoord-1].extraObject != "" {     //check that square and the two adjacent squares (L and R) for objects
                theGame.player.zPosition = 1    //player should be drawn in front of the object
            } else {
                theGame.player.zPosition = 0    //otherwise player should be drawn behind the object
            }
        }
        
        xcoord = Int(theGame.player.currentGridLocation.x - 1)  //looking at square just below the player
        ycoord = Int(theGame.player.currentGridLocation.y - 1)  //  "       "   "   "       "   "   "
        if xcoord >= 0 && xcoord < theGame.currentLocation.grid[0].count && ycoord >= 0 && ycoord < theGame.currentLocation.grid.count {
            if theGame.currentLocation.grid[ycoord][xcoord].extraObject != "" || theGame.currentLocation.grid[ycoord+1][xcoord].extraObject != "" || theGame.currentLocation.grid[ycoord][xcoord+1].extraObject != "" {     //check that square and two adjacent squares (L and R) for objects
                theGame.player.zPosition = 0    //player should be drawn behind the object
            } else {
                theGame.player.zPosition = 1    //otherwise player should be drawn in front of object
            }
        }
        
    }
    
    /* HANDLES PICKING UP ITEMS IN A PARTICULAR LOCATION ON THE GRID */
    func pickUpItems(pt: CGPoint) {
        var x = Int(pt.x)   //make the CGPoint into two integer coordinates for the grid
        var y = Int(pt.y)   //as above
        if theGame.currentLocation.grid[y][x].contents.count > 0 {  //if there's something to pick up
            theGame.player.inventory.append(theGame.currentLocation.grid[y][x].contents[0]) //add to player inventory
            theGame.currentLocation.grid[y][x].contents[0].removeFromParent()   //remove from the scene
            theGame.currentLocation.grid[y][x].contents.removeAtIndex(0)    //remove from the grid square entirely
        }
        
    }
    
    /* CONVERTS ISOMETRIC COORDS TO 2D GRID COORDS */
    func isoTo2D(pt: CGPoint) -> CGPoint {
        var tempPt = CGPoint(x: 0, y: 0)
        tempPt.x = (2 * pt.y + pt.x) / 2
        tempPt.y = (2 * pt.y - pt.x) / 2
        return(tempPt)
    }
    
    /* CONVERTS 2D GRID COORDS TO ISOMETRIC COORDS */
    func twoDToIso(pt: CGPoint) -> CGPoint {
        var tempPt = CGPoint(x: 0, y: 0)
        tempPt.x = pt.x - pt.y
        tempPt.y = (pt.x + pt.y) / 2
        return(tempPt)
    }
    
    /* GOOD FOR MOUSE CLICKS GOING FROM ISO VIEW ON THE SCENE INTO A GRID SQUARE 2D COORD I.E. WHERE DID I CLICK? */
    func getTileCoordinates(pt: CGPoint) -> CGPoint {
        var tempPt = CGPoint(x: 0, y: 0)
        var tileHeight = CGFloat(64.0)
        tempPt.x = floor(pt.x / tileHeight)
        tempPt.y = floor(pt.y / tileHeight)
        return(tempPt)
    }
    
    /* CREATES THE CURRENT LOCATION THE PLAYER IS IN ON THE SCENE */
    func createLocation() {
        
        for x in 0...theGame.currentLocation.grid.count-1 {     //iterating through the x coords of the loc. grid
            for y in 0...theGame.currentLocation.grid[0].count-1 {  //iterating through the y coords of the loc. grid
                var xx = theGame.currentLocation.grid.count-x-1 //converts x to reverse order for drawing prettiness
                var yy = theGame.currentLocation.grid[0].count-y-1  //same for y
                var square = SKSpriteNode(imageNamed:theGame.currentLocation.grid[xx][yy].texture)  //grabs the tex
                square.position = twoDToIso(CGPoint(x: xx * 64, y: yy * 64))    //converts to iso coords
                square.zPosition = 0    //draw square underneath player and extra objects
                world.addChild(square)  //adds to the world
                if theGame.currentLocation.grid[xx][yy].contents.count > 0 {    //if there's an item to draw
                    theGame.currentLocation.grid[xx][yy].contents[0].position = CGPoint(x: 0, y: 0)  //puts it in the center of the iso square
                    square.addChild(theGame.currentLocation.grid[xx][yy].contents[0])    //adds to the square
                }
            }
        }
        
        /* draw player before objects for correct layering */
        theGame.player.position = twoDToIso(CGPoint(x: theGame.player.currentGridLocation.x * 64 + 32, y: theGame.player.currentGridLocation.y * 64 + 32))  //sets the player's position as the correct grid location
        theGame.player.zPosition = 0
        world.addChild(theGame.player)  //add the player to the world
        
        for x in 0...theGame.currentLocation.grid.count-1 {     //iterating through the x coords of the loc. grid
            for y in 0...theGame.currentLocation.grid[0].count-1 {  //iterating through the y coords of the loc. grid
                var xx = theGame.currentLocation.grid.count-x-1 //converts x to reverse order for drawing prettiness
                var yy = theGame.currentLocation.grid[0].count-y-1  //same for y
                if theGame.currentLocation.grid[xx][yy].extraObject != "" {     //if there's an extra object to draw in this square
                    var object = SKSpriteNode(imageNamed: theGame.currentLocation.grid[xx][yy].extraObject) //create the object as a sprite node based on its name stored in extraObject data member
                    var pos = twoDToIso(CGPoint(x: xx * 64, y: yy * 64))
                    object.position = CGPoint(x: pos.x, y: pos.y + object.size.height / 2)     //position puts bottom of sprite at baseline for grid square
                    object.zPosition = 0.5  //draw the extra objects in front of the squares but behind the player when player is in front of the object on the grid
                    world.addChild(object) //adds to the square
                }
            }
        }
        
        for x in 0...theGame.currentLocation.animals.count-1 {
            
            var animal = theGame.currentLocation.animals[x]
            var pos = twoDToIso(CGPoint(x: (random() % (theGame.currentLocation.grid.count-1)) * 64, y: (random() % (theGame.currentLocation.grid[0].count-1)) * 64))
            animal.position = CGPoint(x: pos.x, y: pos.y + animal.size.height / 2)
            world.addChild(animal)
            
        }
        
        dateLabel.fontSize = TIMESTAMP_FONT_SIZE //set date label font size
        dateLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: TIMESTAMP_OFFSET_Y)    //puts the date/time at bottom center of the screen, just above the button bar
        dateLabel.zPosition = TIMESTAMP_OFFSET_Z
        self.addChild(dateLabel)    //adds the date label to the scene (not the world, so it stays in place like the banner
        
    }
    
    var timeSpentReadingMarker : CFTimeInterval = 0.0
    
    func updateBibleEvents( time: CFTimeInterval ) {
        
        if theGame.bibleEvents.count == theGame.nextEvent { //if the Bible has no more events to describe...
            exit(0) //exit the game completely
        }
        
        if theGame.bibleEvents[theGame.nextEvent].date.laterDate(theGame.gameDate) == theGame.gameDate {    //if we've hit or slightly passed a Bible Event...
            
            playSound(theGame.bibleEvents[theGame.nextEvent].soundFile)
            theGame.nextEvent++
            
        }
    }
    
    func makeProgressBarFor( time: Double, caption: String) {
        
        progBarCaption = SKLabelNode(text: caption)
        progBarCaption.zPosition = 5.0
        progBarCaption.position = CGPointZero
        progBarCaption.fontSize = 14
        progBarFrame.position = CGPointZero
        progBarFrame.zPosition = 3.0
        progBar.position = CGPointZero
        progBar.zPosition = 4.0
        progBarDuration = time
        progBar.size = CGSizeMake(0, progBar.size.height)
        self.addChild(progBarFrame)
        self.addChild(progBarCaption)
        self.addChild(progBar)
        
    }
    
    func updateProgressBar( deltaTime : Double ) {
        
        if progBarDuration != 0.0 {
            progBarTime += deltaTime
            progBar.size = CGSizeMake( CGFloat( ( CGFloat(progBarTime) / CGFloat(progBarDuration) ) * PROG_BAR_WIDTH ), progBar.size.height )
        }
        if progBarTime >= progBarDuration && progBarDuration != 0.0 {
            removeProgressBar()
        }
        
    }
    
    func removeProgressBar() {
        
        progBarFrame.removeFromParent()
        progBar.removeFromParent()
        progBarCaption.removeFromParent()
        progBarTime = 0.0
        progBarDuration = 0.0
        progBarCaption = SKLabelNode(text: "")
        theGame.player.skills[skillInUse].use()
        skillInUse = -1
        
    }
    
    /* EVERY FRAME DO THIS (60 times/sec) */
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        updateProgressBar( GAME_SPEED )
        
        theGame.currentLocation.animals[0].updateAI(currentTime)
        
        dateLabel.text = formatter.stringFromDate(theGame.gameDate) //grabs the date & time and puts it in the dateLabel
        
        updateBibleEvents( currentTime )
        
        theGame.gameDate = theGame.gameDate.dateByAddingTimeInterval(GAME_SPEED)    //increase game time by game speed amount, so 1.0 would be 60 sec game time per 1 sec real time, 2.0 would be 120 sec game time per 1 sec real time, 0.5 would be 30 sec game time per 1 sec real time, etc. etc.
        
    }
    
}
