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

func playBackgroundMusic(filename: String) {    //sets up an audio player to play background music
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
    
    backgroundMusicPlayer.numberOfLoops = -1    //loop continuously
    backgroundMusicPlayer.prepareToPlay()   //load into memory
    backgroundMusicPlayer.play()    //play song
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
    
    /* INITIALIZATION */
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        playBackgroundMusic("BackgroundMusicA.mp3") //immediately start background music
        
        formatter.calendar = hebrew     //using the Hebrew calendar
        formatter.dateStyle = .FullStyle    //full date
        formatter.timeStyle = .MediumStyle  //basic timestamp
        
        self.addChild(world)    //world node is added to the scene immediately
        self.anchorPoint = CGPointMake(0.5, 0.5)    //anchor the screen on center
        
        createLocation()    //creates the current location in spritekit
        
        setupLowerBanner()  //creates the game function buttons and experience bars on a lower banner
        
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
    
    /* CREATES THE LOWER BANNER WITH GAME BUTTONS AND EXPERIENCE BARS */
    func setupLowerBanner() {
        lowerBanner.removeFromParent()  //just in case we're re-setting-up, remove the current banner
        lowerBanner = SKSpriteNode(imageNamed:"LowerBannerBASE")    //define the lowerBanner as basic button bar with nothing selected
        lowerBanner.position = CGPoint(x:-112, y:-768/2 + 32)   //put the button bar at correct location
        self.addChild(lowerBanner)  //add the banner to the current scene
        experienceBars.removeFromParent()   //just in case we're re-setting-up, remove the current exp bars
        experienceBars.position = CGPoint(x:400, y:-768/2 + 32) //put experience bars at the correct location
        self.addChild(experienceBars)   //add the experience bars (to the right of the button bar, as above)
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
        theOpenMenu.position = CGPoint(x: CGRectGetMidX(self.frame), y: -32 + 8)    //places image just above the button bar, and centered on the scene's frame
        self.addChild(theOpenMenu)  //displays the menu
        var menuTitle = SKLabelNode(fontNamed: "Zapfino")   //sets up a label for the menu title
        menuTitle.text = theMenu.lowercaseString.capitalizedString  //makes the menu Thisway instead of THISWAY
        menuTitle.fontSize = 24 //sets the font size
        menuTitle.position = CGPoint(x: 0, y: CGRectGetMaxY(theOpenMenu.frame)/2 + 128 - 32)    //positions at top center of menu
        theOpenMenu.addChild(menuTitle) //displays the label as a child of the current menu
        
        /* SPECIAL INSTRUCTIONS FOR INVENTORY MENU - ***INCOMPLETE*** */
        if theMenu == "INVENTORY" { //if we're working with the inventory menu
            var inventoryItems = SKLabelNode(fontNamed: "Arial")    //sets up a label for the inventory items
            inventoryItems.text = " "   //initially, it's blank
            inventoryItems.fontSize = 16    //sets font size
            inventoryItems.position = CGPoint(x: 0, y: CGRectGetMaxY(theOpenMenu.frame)/2 + 32) //arbitrary location
            if theGame.player.inventory.count > 0 { //if there's anything in the player's inventory
                inventoryItems.text = theGame.player.inventory[0].title //grab the title of the first item
            }
            theOpenMenu.addChild(inventoryItems)    //add the label with that title to the menu (this needs expansion to include additional inventory items as well as images for them)
        }
        
        /* NEED TO WRITE CODE FOR OTHER MENUS' SPECIAL INSTRUCTIONS */
        
    }
    
    /* HANDLES ALL MOUSE CLICKS */
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)    //grabs the location where the user has clicked
        
        /* Has the user clicked a menu button on the lower banner? */
        if location.y <= 64 - 768 / 2 {
            if location.x <= 85 - 1024 / 2 {    //if they clicked the party button...
                if menuUp == "PARTY" {  //if it's already up,
                    clearMenu() // clear it
                } else {    // otherwise,
                    openMenu("PARTY")   //open the party menu
                }
            } else if location.x <= 85 + 64 - 1024 / 2 {    //same thing here and for all menu button clicks
                if menuUp == "NOTES" {
                    clearMenu()
                } else {
                    openMenu("NOTES")
                }
            } else if location.x <= 85 + 128 - 1024 / 2 {
                if menuUp == "KNOWLEDGE" {
                    clearMenu()
                } else {
                    openMenu("KNOWLEDGE")
                }
            } else if location.x <= 85 + 128 + 64 - 10 - 1024 / 2 {
                if menuUp == "PRAYER" {
                    clearMenu()
                } else {
                    openMenu("PRAYER")
                }
            } else if location.x <= 85 + 256 - 10 - 1024 / 2 {
                if menuUp == "TRAVEL" {
                    clearMenu()
                } else {
                    openMenu("TRAVEL")
                }
            } else if location.x <= 85 + 256 + 64 - 10 - 1024 / 2 {
                if menuUp == "INVENTORY" {
                    clearMenu()
                } else {
                    openMenu("INVENTORY")
                }
            } else if location.x <= 85 + 256 + 128 - 10 - 1024 / 2 {
                if menuUp == "SKILLS" {
                    clearMenu()
                } else {
                    openMenu("SKILLS")
                }
            } else {
                clearMenu()
            }
        } else { /* Has the user clicked OUTSIDE the lower banner? */
            resetLowerBanner()  //clear all button highlights
            theOpenMenu.removeFromParent()  //remove any open menu
            menuUp = "NONE" //set menuUp to "NONE" - everything is cleared
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
            println("PAUSED")
        } else {    //if the game is paused
            bibleEventTitle.removeFromParent()  //remove the bible event title
            bibleEventDescription.removeFromParent()    //remove the bible event text
            GAME_SPEED = PREV_GAME_SPEED    //restore game speed from before
            PAUSED = false  //no longer paused
            println("UNPAUSED")
        }
        
    }
    
    /* PAUSES ONLY */
    func pause() {
        
        if PAUSED == false {
            PREV_GAME_SPEED = GAME_SPEED
        }
        GAME_SPEED = 0.0
        PAUSED = true
        println("PAUSED")
        
    }
    
    /* UNPAUSES ONLY */
    func unpause() {
        
        bibleEventTitle.removeFromParent()  //remove the bible event title
        bibleEventDescription.removeFromParent()    //remove the bible event text
        GAME_SPEED = PREV_GAME_SPEED
        PAUSED = false
        println("UNPAUSED")
        
    }
    
    /* HANDLES ALL KEYPRESSES */
    override func keyUp(theEvent: NSEvent) {
        
        let key = theEvent.keyCode  //grab the key code of the key pressed
        
        if key == 49 { //SPACEBAR IS PRESSED, PAUSE/UNPAUSE GAME
            pauseUnPause()
        } else if key == 27 {   //MINUS KEY PRESSED
            GAME_SPEED /= 2.0   //divide game speed in half
        } else if key == 24 {   //PLUS KEY PRESSED
            GAME_SPEED *= 2.0   //multiply game speed by two
        } else if key == 34 {   //'I' KEY IS PRESSED
            if menuUp == "INVENTORY" {  //pretty self explanatory, shows the menu corresponding to the key pressed
                clearMenu()
            } else {
                openMenu("INVENTORY")
            }
        } else if key == 35 {   //'P' KEY PRESSED
            if menuUp == "PARTY" {
                clearMenu()
            } else {
                openMenu("PARTY")
            }
        } else if key == 45 {   //'N' KEY
            if menuUp == "NOTES" {
                clearMenu()
            } else {
                openMenu("NOTES")
            }
        } else if key == 40 {   //'K'
            if menuUp == "KNOWLEDGE" {
                clearMenu()
            } else {
                openMenu("KNOWLEDGE")
            }
        } else if key == 15 {   //'P'
            if menuUp == "PRAYER" {
                clearMenu()
            } else {
                openMenu("PRAYER")
            }
        } else if key == 17 {   //'T'
            if menuUp == "TRAVEL" {
                clearMenu()
            } else {
                openMenu("TRAVEL")
            }
        } else if key == 1 {    //'S'
            if menuUp == "SKILLS" {
                clearMenu()
            } else {
                openMenu("SKILLS")
            }
        /* CHARACTER MOVEMENT & STATE CHANGE (SITTING, ETC.) CODE HERE */
        } else if key == 89 && !PAUSED {   //'7' NUM PAD PRESSED - MOVING INTO UPPER LEFT SQUARE
            theGame.player.texture = SKTexture(imageNamed: "characterUPPERLEFT")    //displays char moving up-left
            if Int(theGame.player.currentGridLocation.x + 1) < theGame.currentLocation.grid[0].count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y)][Int(theGame.player.currentGridLocation.x + 1)].extraObject == "" { //if in bounds and no collision
                let moveUpperLeft = SKAction.moveByX(-64, y: 32, duration: 0.125)   //move gradually to new location
                theGame.player.runAction(moveUpperLeft) //runs the action defined above
                theGame.player.currentGridLocation.x += 1   //sets grid location (corresponding to matrix, not spritekit location)
                pickUpItems(theGame.player.currentGridLocation) //pick up any items in-square automatically
                orderCorrectly()    //change the Z order of the player depending on objects around them
            }
        } else if key == 91 && !PAUSED {   //'8' NUM PAD PRESSED - everything else is the same idea as above, just look at [imageNamed: "characterXXXX"] for movement direction
            theGame.player.texture = SKTexture(imageNamed: "characterUP")
            if Int(theGame.player.currentGridLocation.x + 1) < theGame.currentLocation.grid[0].count && Int(theGame.player.currentGridLocation.y + 1) < theGame.currentLocation.grid.count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y + 1)][Int(theGame.player.currentGridLocation.x + 1)].extraObject == "" {
                let moveUp = SKAction.moveByX(0, y: 64, duration: 0.125)
                theGame.player.runAction(moveUp)
                theGame.player.currentGridLocation.x += 1
                theGame.player.currentGridLocation.y += 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if key == 92 && !PAUSED {   //'9' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterUPPERRIGHT")
            if Int(theGame.player.currentGridLocation.y + 1) < theGame.currentLocation.grid.count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y + 1)][Int(theGame.player.currentGridLocation.x)].extraObject == "" {
                let moveUpperRight = SKAction.moveByX(64, y: 32, duration: 0.125)
                theGame.player.runAction(moveUpperRight)
                theGame.player.currentGridLocation.y += 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if key == 86 && !PAUSED {   //'4' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterLEFT")
            if Int(theGame.player.currentGridLocation.x + 1) < theGame.currentLocation.grid[0].count && Int(theGame.player.currentGridLocation.y - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y - 1)][Int(theGame.player.currentGridLocation.x + 1)].extraObject == "" {
                let moveLeft = SKAction.moveByX(-128, y: 0, duration: 0.125)
                theGame.player.runAction(moveLeft)
                theGame.player.currentGridLocation.y -= 1
                theGame.player.currentGridLocation.x += 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if key == 87 && !PAUSED {   //'5' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterSEATED") //make character sit for center key
        } else if key == 88 && !PAUSED {   //'6' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterRIGHT")
            if Int(theGame.player.currentGridLocation.x - 1) >= 0 && Int(theGame.player.currentGridLocation.y + 1) < theGame.currentLocation.grid.count && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y + 1)][Int(theGame.player.currentGridLocation.x - 1)].extraObject == "" {
                let moveRight = SKAction.moveByX(128, y: 0, duration: 0.125)
                theGame.player.runAction(moveRight)
                theGame.player.currentGridLocation.y += 1
                theGame.player.currentGridLocation.x -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if key == 83 && !PAUSED {   //'1' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterLOWERLEFT")
            if Int(theGame.player.currentGridLocation.y - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y - 1)][Int(theGame.player.currentGridLocation.x)].extraObject == "" {
                let moveLowerLeft = SKAction.moveByX(-64, y: -32, duration: 0.125)
                theGame.player.runAction(moveLowerLeft)
                theGame.player.currentGridLocation.y -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if key == 84 && !PAUSED {   //'2' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterDOWN")
            if Int(theGame.player.currentGridLocation.x - 1) >= 0 && Int(theGame.player.currentGridLocation.y - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y - 1)][Int(theGame.player.currentGridLocation.x - 1)].extraObject == "" {
                let moveDown = SKAction.moveByX(0, y: -64, duration: 0.125)
                theGame.player.runAction(moveDown)
                theGame.player.currentGridLocation.y -= 1
                theGame.player.currentGridLocation.x -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else if key == 85 && !PAUSED {   //'3' NUM PAD PRESSED
            theGame.player.texture = SKTexture(imageNamed: "characterLOWERRIGHT")
            if Int(theGame.player.currentGridLocation.x - 1) >= 0 && theGame.currentLocation.grid[Int(theGame.player.currentGridLocation.y)][Int(theGame.player.currentGridLocation.x - 1)].extraObject == "" {
                let moveLowerRight = SKAction.moveByX(64, y: -32, duration: 0.125)
                theGame.player.runAction(moveLowerRight)
                theGame.player.currentGridLocation.x -= 1
                pickUpItems(theGame.player.currentGridLocation)
                orderCorrectly()
            }
        } else {
            println(key)    //FOR DEBUGGING, PRINT ANY KEY CODE NOT YET CODED FOR
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
            //println("Found an item!")   //FOR DEBUGGING, PRINT THAT WE'VE FOUND AN ITEM
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
                square.position = twoDToIso(CGPoint(x: xx*64, y: yy*64))    //converts to iso coords
                square.zPosition = 0
                world.addChild(square)  //adds to the world
                if theGame.currentLocation.grid[xx][yy].contents.count > 0 {    //if there's an item to draw
                    theGame.currentLocation.grid[xx][yy].contents[0].position = CGPoint(x: 0, y: 0)  //puts it in the center of the iso square
                    square.addChild(theGame.currentLocation.grid[xx][yy].contents[0])    //adds to the square
                }
            }
        }
        
        /* draw player before objects for correct layering */
        theGame.player.position = twoDToIso(CGPoint(x: theGame.player.currentGridLocation.x*64 + 32, y: theGame.player.currentGridLocation.y*64 + 32))  //sets the player's position as the correct grid location
        theGame.player.zPosition = 0
        world.addChild(theGame.player)  //add the player to the world
        
        for x in 0...theGame.currentLocation.grid.count-1 {     //iterating through the x coords of the loc. grid
            for y in 0...theGame.currentLocation.grid[0].count-1 {  //iterating through the y coords of the loc. grid
                var xx = theGame.currentLocation.grid.count-x-1 //converts x to reverse order for drawing prettiness
                var yy = theGame.currentLocation.grid[0].count-y-1  //same for y
                if theGame.currentLocation.grid[xx][yy].extraObject != "" {     //if there's an extra object to draw in this square
                    var object = SKSpriteNode(imageNamed: theGame.currentLocation.grid[xx][yy].extraObject) //create the object as a sprite node based on its name stored in extraObject data member
                    var pos = twoDToIso(CGPoint(x: xx*64, y: yy*64))
                    object.position = CGPoint(x: pos.x, y: pos.y + object.size.height / 2 - 32)     //position puts bottom of sprite 32px above baseline for grid square
                    world.addChild(object) //adds to the square
                }
            }
        }
        
        dateLabel.fontSize = 14 //set date label font size
        dateLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:64+14 - 768 / 2)    //puts the date/time at bottom center of the screen, just above the button bar
        self.addChild(dateLabel)    //adds the date label to the scene (not the world, so it stays in place like the banner
        
    }
    
    /* EVERY FRAME DO THIS (60 times/sec) */
    var timeSpentReadingMarker : CFTimeInterval = 0.0
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        dateLabel.text = formatter.stringFromDate(theGame.gameDate) //grabs the date & time and puts it in the dateLabel
        
        if theGame.bibleEvents.count == theGame.nextEvent { //if the Bible has no more events to describe...
            exit(0) //exit the game completely
        }
        
        if theGame.bibleEvents[theGame.nextEvent].date.laterDate(theGame.gameDate) == theGame.gameDate {    //if we've hit or slightly passed a Bible Event...
            
            timeSpentReadingMarker = currentTime    //mark the current time to test how long the text has been up
            pause()  //pause the game
            
            bibleEventTitle = SKLabelNode(fontNamed:"Chalkduster")  //creates Bible Event title text w/ font Chalkduster
            bibleEventTitle.text = theGame.bibleEvents[theGame.nextEvent].title //set the title
            bibleEventTitle.fontSize = 18   //set the font size to be bigger than the main text of the Bible Event
            bibleEventTitle.position = CGPoint(x:CGRectGetMidX(self.frame), y:512 - 768 / 2)    //put it in the center
            self.addChild(bibleEventTitle)  //add it to the scene (not the world, so it stays in place like the banner)
            
            bibleEventDescription = MultiLineLabel(text: theGame.bibleEvents[theGame.nextEvent].description, fontName: "Chalkduster", fontsize: 12, wrap: 1024)  //set the main text (description)
            bibleEventDescription.position = CGPoint(x:CGRectGetMidX(self.frame), y:512 - 64 - 768 / 2)  //just below the title
            self.addChild(bibleEventDescription)
            
            theGame.nextEvent++ //get ready for next Bible Event
        
        }
        
        var dist = currentTime.distanceTo(Double(timeSpentReadingMarker))   //difference in time between current time and time marker for how long text has been up
        if dist < -15 && dist > (-15 - (1 / 60.0)) && theGame.nextEvent > 0 {   //if we've hit 15 seconds and this is not the first run
            bibleEventTitle.removeFromParent()  //remove the title
            bibleEventDescription.removeFromParent()    //remove the text
            unpause()  //unpause the game
        }
        
        theGame.gameDate = theGame.gameDate.dateByAddingTimeInterval(GAME_SPEED)    //increase game time by game speed amount, so 1.0 would be 60 sec game time per 1 sec real time, 2.0 would be 120 sec game time per 1 sec real time, 0.5 would be 30 sec game time per 1 sec real time, etc. etc.
        
    }
    
}
