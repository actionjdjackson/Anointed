//
//  GameScene.swift
//  Anointed The Game
//
//  Created by Jacob Jackson on 3/28/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import SpriteKit
import AVFoundation
import CoreFoundation

class GameScene : SKScene {
    
    /* VARIABLES AND CONSTANTS USED IN SCENE */
    var bibleEventTitle = SKLabelNode(fontNamed:"")
    var bibleEventDescription = SKMultiLineLabel(theText: "", theWidth: 40, fontsize: 12)
    var lowerBanner = SKSpriteNode(imageNamed:"LowerBannerBASE")    //load button bar into memory
    var experienceBars = SKSpriteNode(imageNamed:"ExperienceBarsBASE")  //load experience bar into memory
    var hgexpbar = SKShapeNode()    //make HG Experience Bar
    var expbar = SKShapeNode()  //make exp bar
    var combatexpbar = SKShapeNode()    //make combat exp bar
    var theOpenMenu = SKSpriteNode(imageNamed:"INVENTORYmenu")  //load inventory menu as default menu to open
    var menuUp = "NONE" //no menu up for starters
    let hebrew = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew) //defines hebrew calendar
    let formatter = NSDateFormatter()   //sets up a date formatter for displaying hebrew dates
    let dateLabel = SKLabelNode(fontNamed:"Courier New")    //creates date label with font Courier New (fixed width)
    var GAME_SPEED = 1.0    //default game speed is 60 game seconds per real second
    var PREV_GAME_SPEED = 1.0   //this is used for when pausing the game, and going back to previous game speed
    var PAUSED = false  //obviously, the game doesn't start out paused
    var world : SKShapeNode = SKShapeNode(rectOfSize: CGSize(width: 4096*2, height: 4096*2)) //sets up the world node
    var progBarFrame : SKSpriteNode = SKSpriteNode(imageNamed: "progressBarFrame")  //progress bar frame
    var progBar : SKSpriteNode = SKSpriteNode(imageNamed: "progressBar")    //progress bar
    var progBarCaption : SKLabelNode = SKLabelNode(text: "")    //empty progress bar caption
    //var progBarTime : Double = 0.0  //initially, progbar has no time value DEPRECATED
    var progBarDuration : Double = 0.0  //initially, progbar has no duration value
    var skillInUse : Int = -1   //no skill in use initially
    var giftSkills : [Skill] = []   //giftSkills array set to empty array
    var nodeEntered : String = ""
    
    /* KEYPRESS CONSTANTS */
    let ESCAPE = UInt16(53)
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
        
        let options: NSTrackingAreaOptions = [NSTrackingAreaOptions.MouseMoved, NSTrackingAreaOptions.ActiveInKeyWindow]    //set up options for mouse tracking
        let trackingArea = NSTrackingArea(rect:view.frame,options:options,owner:self,userInfo:nil)  //set up tracking area
        view.addTrackingArea(trackingArea)  //add tracking area to this view (allows for more interactivity with mouse clicks and such)
        
        srandom(UInt32(CFAbsoluteTimeGetCurrent())) //seed random with current time in seconds
        
        formatter.calendar = hebrew     //using the Hebrew calendar
        formatter.dateStyle = .FullStyle    //full date
        formatter.timeStyle = .MediumStyle  //basic timestamp
        
        world.fillColor = SKColor.blackColor()  //the world is a black background
        self.addChild(world)    //world node is added to the scene immediately
        self.anchorPoint = CGPoint(x: CONSTANTS.CENTER_OF_SCREEN_X, y: CONSTANTS.CENTER_OF_SCREEN_Y) //anchor the screen on center
        
        createMainMenu()
        
    }

    
    func createMainMenu() {
        
        let startScreenLabel : StartScreenLabel = StartScreenLabel()
        self.addChild(startScreenLabel)
        playBackgroundMusic("IntoYourArms.mp3")
        
    }
    
    
    /* EVERY FRAME... */
    override func didFinishUpdate() {
        
        self.centerOnNode(UNIVERSE.theGame.player)   //continually center on the player
        
    }
    
    /* centers the screen on a given SKNode, in our case the player (as above) */
    func centerOnNode( node: SKNode ) {
        
        if self.children.count > 2 {
            let cameraPositionInScene = node.scene?.convertPoint(node.position, fromNode: node.parent!) //convert point
        node.parent!.position = CGPointMake(node.parent!.position.x - cameraPositionInScene!.x, node.parent!.position.y - cameraPositionInScene!.y)   //translate to give parent node correct position
        }
        
    }
    
    /* MOUSE MOVEMENT CATCHER */
    override func mouseMoved(event: NSEvent) {
        // Get mouse position in scene coordinates
        let location = event.locationInNode(self)
        // Get node at mouse position
        let node = self.nodeAtPoint(location)
        // Send mouseMoved to that node
        node.mouseMoved(event)
    }
    
    /* RIGHT-CLICK CATCHER */
    override func rightMouseDown(theEvent: NSEvent) {
        
        // Get mouse position in scene coordinates
        let location = theEvent.locationInNode(self)
        // Get node at mouse position
        let node = self.nodeAtPoint(location)
        // Send rightMouseDown to that node
        node.rightMouseDown(theEvent)
        
    }
    
    /* RIGHT-CLICK RELEASE CATCHER */
    override func rightMouseUp(theEvent: NSEvent) {
        
        // Get mouse position in scene coordinates
        let location = theEvent.locationInNode(self)
        // Get node at mouse position
        let node = self.nodeAtPoint(location)
        // Send rightMouseUp to that node
        node.rightMouseUp(theEvent)
        
    }
    
    func updateExperienceBars() {
        
        hgexpbar.removeFromParent()
        hgexpbar = SKShapeNode(rectOfSize: CGSize(width: Int((Double(UNIVERSE.theGame.player.historyWithGodExperience) / Double(UNIVERSE.theGame.player.levelExp[UNIVERSE.theGame.player.level + 1]!)) * 200) + 3, height: 8), cornerRadius: 3)
        hgexpbar.fillColor = SKColor.yellowColor()
        hgexpbar.strokeColor = SKColor.clearColor()
        hgexpbar.position = CGPoint(x: 0, y: 64/2 - 4)
        experienceBars.addChild(hgexpbar)
        
        expbar.removeFromParent()
        expbar = SKShapeNode(rectOfSize: CGSize(width: Int((Double(UNIVERSE.theGame.player.experience) / Double(UNIVERSE.theGame.player.levelExp[UNIVERSE.theGame.player.level + 1]!)) * 200) + 3, height: 8), cornerRadius: 3)
        expbar.fillColor = SKColor.greenColor()
        expbar.strokeColor = SKColor.clearColor()
        expbar.position = CGPoint(x: 0, y: 64/2 - 32 + 5)
        experienceBars.addChild(expbar)
        
        //print(UNIVERSE.theGame.player.experience, UNIVERSE.theGame.player.historyWithGodExperience, UNIVERSE.theGame.player.levelExp[UNIVERSE.theGame.player.level + 1]!) //print experience levels and next level up exp level
        
    }
    
    /* CREATES THE LOWER BANNER WITH GAME BUTTONS, SKILLS, AND EXPERIENCE BARS */
    func setupLowerBanner() {
        
        lowerBanner.removeFromParent()  //just in case we're re-setting-up, remove the current banner
        lowerBanner = SKSpriteNode(imageNamed:"LowerBannerBASE")    //define the lowerBanner as basic button bar with nothing selected
        lowerBanner.name = "LOWERBANNER"
        lowerBanner.position = CGPoint( x: CONSTANTS.LOWER_BANNER_X, y: CONSTANTS.LOWER_BANNER_Y )   //put the button bar at correct location
        lowerBanner.zPosition = CONSTANTS.LOWER_BANNER_Z
        self.addChild(lowerBanner)  //add the banner to the current scene
        experienceBars.removeFromParent()   //just in case we're re-setting-up, remove the current exp bars
        experienceBars.position = CGPoint(x: CONSTANTS.EXPERIENCE_BARS_X, y: CONSTANTS.EXPERIENCE_BARS_Y) //put experience bars at the correct location
        experienceBars.zPosition = CONSTANTS.EXPERIENCE_BARS_Z
        self.addChild(experienceBars)   //add the experience bars (to the right of the button bar, as above)
        updateExperienceBars()
        
        
        if UNIVERSE.theGame.player.skills.count > 0 {    //if the player has any skills
            for n in 0...UNIVERSE.theGame.player.skills.count-1 {    //iterate through all skills
                if n >= CONSTANTS.SKILLS_GRID_WIDTH { //if the player has too many skills
                    fatalError("TOO MANY SKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")   //exit with error
                }
                let skill = SKSpriteNode(imageNamed: UNIVERSE.theGame.player.skills[n].sprite)   //grab the sprite for the current skill
                skill.size = CGSize(width: 32, height: 32)
                skill.position = CGPoint(x: CONSTANTS.SKILLS_BAR_BASE_X + CGFloat(n % CONSTANTS.SKILLS_GRID_WIDTH) * CONSTANTS.SKILL_ICON_SIZE, y: CONSTANTS.SKILLS_BAR_BASE_Y) //position in quickbar
                skill.zPosition = CONSTANTS.SKILLS_BAR_BASE_Z //set Z position for drawing on top of grid
                self.addChild(skill)    //add skill to scene
            }
        }
        
        grabGiftSkills()    //populate the giftSkills array (for convenience)
        
        if giftSkills.count > 0 {   //if there are any spiritual gift subskills
            for n in 0...giftSkills.count-1 {   //iterate through all subskills
                if n >= CONSTANTS.SKILLS_GRID_WIDTH { //if there are too many subskills
                    fatalError("TOO MANY SPIRITUAL GIFT SKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")    //exit with error
                }
                let skill = SKSpriteNode(imageNamed: giftSkills[n].sprite)  //grab the sprite for the current subskill
                skill.size = CGSize(width: 32, height: 32)
                skill.position = CGPoint(x: CONSTANTS.SKILLS_BAR_BASE_X + CGFloat(n % CONSTANTS.SKILLS_GRID_WIDTH) * CONSTANTS.SKILL_ICON_SIZE, y: CONSTANTS.SKILLS_BAR_BASE_Y - 32)    //position in quickbar
                skill.zPosition = CONSTANTS.SKILLS_BAR_BASE_Z //set Z position for drawing on top of grid
                self.addChild(skill)    //add subskill to scene
            }
        }
    
    }
    
    /* GRABS ALL GIFT SKILLS AND PUTS THEM INTO AN ARRAY STORED IN THE SCENE FOR EASY ACCESS **/
    func grabGiftSkills() {
        
        giftSkills = [] //initialize giftSkills to empty array
        if UNIVERSE.theGame.player.gifts.count > 0 {    //if the player has any spiritual gifts
            for gift in UNIVERSE.theGame.player.gifts {    //iterate through all spiritual gifts
                if gift.subSkills.count > 0 {   //if there are subskills
                    for subskill in gift.subSkills {   //iterate through all subskills
                        giftSkills.append(subskill)    //add subskill to giftSKills array
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
        for node in self.children {
            if node.name == "VISUALIZATION BACKGROUND" {
                node.removeFromParent()
            }
        }
        
        for node in theOpenMenu.children {
            if node is Scroll {
                let theScroll = node as! Scroll
                if theScroll.selected {
                    for child in theScroll.children {
                        if child.name == "OUTLINE" {
                            child.removeFromParent()
                        }
                    }
                }
            }
        }
        
        theOpenMenu.removeAllChildren()
        theOpenMenu.removeFromParent()  //remove the open menu if it's there
        menuUp = "NONE" //set menuUp to "NONE" - so we know there's no menu up at this time
        if soundPlayer != nil {
            soundPlayer.stop()
        }
        if backgroundMusicPlayer != nil {
            backgroundMusicPlayer.play()
        }
        
    }
    
    /* OPENS A MENU NAMED theMenu - HIGHLIGHTS THE BUTTON PRESSED AND DISPLAYS THE RESPECTIVE MENU DISPLAY */
    func openMenu(theMenu: String) {
        
        theOpenMenu.removeFromParent()  //removes the current menu
        activateLowerBanner("LowerBanner" + theMenu)    //highlights the button
        menuUp = theMenu    //keeping track of what menu is open currently
        theOpenMenu = SKSpriteNode(imageNamed: theMenu + "menu")    //sets up the menu image
        theOpenMenu.name = theMenu
        theOpenMenu.position = CGPoint( x: CGRectGetMidX(self.frame), y: CONSTANTS.OPEN_MENU_Y ) //places it just above the button bar, and centered on the scene's frame
        theOpenMenu.zPosition = CONSTANTS.OPEN_MENU_Z
        self.addChild(theOpenMenu)  //displays the menu
        let menuTitle = SKLabelNode(fontNamed: "Papyrus")   //sets up a label for the menu title
        menuTitle.text = theMenu.lowercaseString.capitalizedString  //makes the menu Thisway instead of THISWAY
        menuTitle.fontSize = CONSTANTS.MENU_TITLE_FONT_SIZE //sets the font size
        menuTitle.position = CGPoint(x: CONSTANTS.MENU_TITLE_X, y: CONSTANTS.MENU_TITLE_Y)    //positions at top center of menu
        theOpenMenu.addChild(menuTitle) //displays the label as a child of the current menu
        
        /* SPECIAL INSTRUCTIONS FOR INVENTORY MENU - ***INCOMPLETE*** */
        
        if theMenu == "INVENTORY" { //if we're working with the inventory menu
            if UNIVERSE.theGame.player.inventory.count > 0 { //if the player has any inventory items
                for n in 0...UNIVERSE.theGame.player.inventory.count-1   { //iterate through all inventory items
                    if n >= CONSTANTS.INVENTORY_GRID_WIDTH * CONSTANTS.INVENTORY_GRID_HEIGHT {  //if the player has too many items in the inventory
                        fatalError("TOO MANY ITEMS IN INVENTORY. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")   //exit with error
                    }
                    let item = UNIVERSE.theGame.player.inventory[n]  //grab an item
                    item.removeFromParent()
                    theOpenMenu.addChild(item)  //add item to the menu
                    item.size = CGSize(width: 32, height: 32)
                    item.position = CGPoint( x: CONSTANTS.INVENTORY_ITEM_BASE_X + CGFloat(n % CONSTANTS.INVENTORY_GRID_WIDTH) * CONSTANTS.INVENTORY_ITEM_SIZE, y: CONSTANTS.INVENTORY_ITEM_BASE_Y - CGFloat(n / CONSTANTS.INVENTORY_GRID_WIDTH) * CONSTANTS.INVENTORY_ITEM_SIZE )  //position appropriately in the inventory grid
                }
            }
        }
        
        /* SPECIAL INSTRUCTIONS FOR SKILLS MENU - ***INCOMPLETE*** */
        
        if theMenu == "SKILLS&CALLING" { //if we're working with the skills menu
            
            var subSkillTreeButton : ShowImageButton
            subSkillTreeButton = ShowImageButton(buttonText: "Gift-Skills Tree", image: "giftsAndSubskillsTree")
            subSkillTreeButton.position = CGPoint(x: 0, y: -theOpenMenu.position.y)
            subSkillTreeButton.zPosition = 5.0
            theOpenMenu.addChild(subSkillTreeButton)
            var officeCallingsButton : ShowImageButton
            officeCallingsButton = ShowImageButton(buttonText: "Office Callings", image: "officeCallings")
            officeCallingsButton.position = CGPoint(x: 0, y: -theOpenMenu.position.y - 32)
            officeCallingsButton.zPosition = 5.0
            theOpenMenu.addChild(officeCallingsButton)
            var naturalSkillsButton : ShowImageButton
            naturalSkillsButton = ShowImageButton(buttonText: "Natural Skills Tree", image: "naturalSkills")
            naturalSkillsButton.position = CGPoint(x: 0, y: -theOpenMenu.position.y - 64)
            naturalSkillsButton.zPosition = 5.0
            theOpenMenu.addChild(naturalSkillsButton)
                
            if UNIVERSE.theGame.player.skills.count > 0 {    //if the player has any skills
                for n in 0...UNIVERSE.theGame.player.skills.count-1 {    //iterate through all skills
                    if n >= CONSTANTS.SKILLS_GRID_WIDTH * CONSTANTS.SKILLS_GRID_HEIGHT {    //if the player has too many skills to display on the skills menu
                        fatalError("TOO MANY SKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")   //exit with error
                    }
                    let skill = UNIVERSE.theGame.player.skills[n]    //grab a skill
                    skill.size = CGSize(width: 32, height: 32)
                    skill.position = CGPoint(x: CONSTANTS.SKILL_POSITION_BASE_X + CGFloat(n % CONSTANTS.SKILLS_GRID_WIDTH) * CONSTANTS.SKILL_ICON_SIZE, y: CONSTANTS.SKILL_POSITION_BASE_Y - CGFloat(Int(n / CONSTANTS.SKILLS_GRID_WIDTH)) * CONSTANTS.SKILL_ICON_SIZE) //position skill on bottom (natural skills) row
                    theOpenMenu.addChild(skill) //add skill to the menu
                }
            }
            
            if UNIVERSE.theGame.player.gifts.count > 0 {    //if the player has any spiritual gifts
                for n in 0...UNIVERSE.theGame.player.gifts.count-1 {    //iterate through all gifts
                    if n >= CONSTANTS.SKILLS_GRID_WIDTH { //if the player has too many spiritual gifts
                        fatalError("TOO MANY GIFTS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")    //exit with error
                    }
                    let gift = UNIVERSE.theGame.player.gifts[n] //grab a gift
                    gift.size = CGSize(width: 32, height: 32)
                    gift.position = CGPoint(x: CONSTANTS.GIFT_POSITION_BASE_X + CGFloat(n % CONSTANTS.SKILLS_GRID_WIDTH) * CONSTANTS.SKILL_ICON_SIZE, y: CONSTANTS.GIFT_POSITION_BASE_Y - CGFloat(Int(n / CONSTANTS.SKILLS_GRID_WIDTH)) * CONSTANTS.SKILL_ICON_SIZE)    //position gift on top (spiritual gifts) row
                    theOpenMenu.addChild(gift)  //add gift to the menu
                    
                    if gift.subSkills.count > 0 {   //if the gift has subskills
                        for m in 0...gift.subSkills.count-1 {   //iterate through all subskills
                            if m >= CONSTANTS.GIFT_SKILLS_GRID_HEIGHT {   //if the player has too many gift skills for this spiritual gift
                                fatalError("TOO MANY GIFT SUBSKILLS. IMPLEMENT OVERFILL BLOCKING FUNCTION SOON.")   //exit with error
                            }
                            let skill = gift.subSkills[m]   //grab a subskill
                            skill.size = CGSize(width: 32, height: 32)
                            skill.position = CGPoint(x: CONSTANTS.GIFT_POSITION_BASE_X + CGFloat(n % CONSTANTS.SKILLS_GRID_WIDTH) * CONSTANTS.SKILL_ICON_SIZE, y: CONSTANTS.GIFT_POSITION_BASE_Y - CGFloat((m + 1) % CONSTANTS.GIFT_SKILLS_GRID_HEIGHT) * CONSTANTS.SKILL_ICON_SIZE)    //position below the corresponding spiritual gift, in sequence to bottom of column
                            
                            theOpenMenu.addChild(skill) //add subskill to the menu
                        }
                    }
                }
            }
            
            /* SPECIAL INSTRUCTIONS FOR KNOWLEDGE MENU - ***INCOMPLETE*** */
        } else if theMenu == "KNOWLEDGE" { //if we're working with the knowledge menu...
            
            var allScrolls : [Scroll] = []   //scroll array declared
            
            for item in UNIVERSE.theGame.player.inventory { //iterate through all inventory items
                
                if item is Scroll {  //if item n is a scroll...
                    
                    let aScroll : Scroll = item as! Scroll   //grab the scroll as a scroll
                    aScroll.removeFromParent()
                    theOpenMenu.addChild(aScroll)   //add to the open menu
                    aScroll.position = CGPoint(x: CONSTANTS.KNOWLEDGE_MENU_SCROLL_OFFSET_X + (allScrolls.count % 2) * 32, y: CONSTANTS.KNOWLEDGE_MENU_SCROLL_OFFSET_Y - (allScrolls.count / 2) * 32 ) //position scroll
                    allScrolls.append(aScroll)  //add to scroll list
                    
                }
                
            }
            
            let visualizeButton = VisualizeKnowledgeButton()
            visualizeButton.position = CGPoint(x: 0, y: -256)
            theOpenMenu.addChild(visualizeButton)
          
            /* SPECIAL INSTRUCTIONS FOR PRAYER MENU - ***INCOMPLETE*** */
        } else if theMenu == "PRAYER" {
    
            let skillsPrayerFocus : PrayerFocusButton = PrayerFocusButton(focusArea: "Pray Over Skills")
            skillsPrayerFocus.position = CGPoint(x: 0, y: 0)
            theOpenMenu.addChild(skillsPrayerFocus)
            let giftsPrayerFocus : PrayerFocusButton = PrayerFocusButton(focusArea: "Pray For Gifts")
            giftsPrayerFocus.position = CGPoint(x: 0, y: -48)
            theOpenMenu.addChild(giftsPrayerFocus)
            let healthPrayerFocus : PrayerFocusButton = PrayerFocusButton(focusArea: "Pray For Health")
            healthPrayerFocus.position = CGPoint(x: 0, y: -96)
            theOpenMenu.addChild(healthPrayerFocus)
            let experiencePrayerFocus : PrayerFocusButton = PrayerFocusButton(focusArea: "Pray For Experience")
            experiencePrayerFocus.position = CGPoint(x: 0, y: -144)
            theOpenMenu.addChild(experiencePrayerFocus)
            
            /* SPECIAL INSTRUCTIONS FOR NOTES MENU ***INCOMPLETE*** */
        } else if theMenu == "NOTES" {
            
            
            /* SPECIAL INSTRUCTIONS FOR TRAVEL MENU ***INCOMPLETE*** */
        } else if theMenu == "TRAVEL" {
            
            let sailboat = SKSpriteNode(imageNamed: "sailboat")
            sailboat.position = CGPoint.zero
            sailboat.position.x -= 256
            theOpenMenu.addChild(sailboat)
            playSound("waves.aiff")
            sailboat.runAction(SKAction.moveBy(CGVector.init(dx: 512, dy: 0), duration: 5.0))
            sailboat.runAction(SKAction.fadeOutWithDuration(5.0), completion: {
                UNIVERSE.theGame.player.currentGridLocation = CGPoint(x: 5,y: 5)
                UNIVERSE.theGame.currentLocation = UNIVERSE.theGame.cities[1]
                self.createLocation()
                self.clearMenu()
            })
            
        }
    
    }
    
    /* HANDLES ALL MOUSE CLICKS */
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        if self.children.count < 3 {
            for child in self.children {
                if child is StartScreenLabel {
                    child.removeFromParent()
                    self.createLocation()    //creates the current location in spritekit
                    
                    self.orderCorrectly()
                    
                    self.setupLowerBanner()  //creates the game function buttons and experience bars on a lower banner
                    
                    playBackgroundMusic("BackgroundMusicB.mp3") //start background music
                }
            }
        }
        
        let location = theEvent.locationInNode(self)    //grabs the location where the user has clicked
        
        if backgroundMusicPlayer != nil {
            backgroundMusicPlayer.volume = 0.5
        }
        
        /* Has the user clicked a menu button on the lower banner? */
        if location.y <= CONSTANTS.LOWER_BANNER_TOP_EDGE {
            if location.x <= CONSTANTS.PARTY_BUTTON_EDGE {    //if they clicked the party button...
                if menuUp == "PARTY" {  //if it's already up,
                    clearMenu() // clear it
                } else if skillInUse < 0 {    // otherwise,
                    clearMenu()
                    openMenu("PARTY")   //open the party menu
                }
            } else if location.x <= CONSTANTS.NOTES_BUTTON_EDGE {    //same thing here and for all menu button clicks
                if menuUp == "NOTES" {
                    clearMenu()
                } else if skillInUse < 0 {
                    clearMenu()
                    openMenu("NOTES")
                }
            } else if location.x <= CONSTANTS.KNOWLEDGE_BUTTON_EDGE {
                if menuUp == "KNOWLEDGE" {
                    clearMenu()
                } else if skillInUse < 0 {
                    clearMenu()
                    openMenu("KNOWLEDGE")
                }
            } else if location.x <= CONSTANTS.PRAYER_BUTTON_EDGE {
                if menuUp == "PRAYER" {
                    clearMenu()
                } else if skillInUse < 0 {
                    clearMenu()
                    openMenu("PRAYER")
                }
            } else if location.x <= CONSTANTS.TRAVEL_BUTTON_EDGE {
                if menuUp == "TRAVEL" {
                    clearMenu()
                } else if skillInUse < 0 {
                    clearMenu()
                    openMenu("TRAVEL")
                }
            } else if location.x <= CONSTANTS.INVENTORY_BUTTON_EDGE {
                if menuUp == "INVENTORY" {
                    clearMenu()
                } else if skillInUse < 0 {
                    clearMenu()
                    openMenu("INVENTORY")
                }
            } else if location.x <= CONSTANTS.SKILLS_BUTTON_EDGE {
                if menuUp == "SKILLS&CALLING" {
                    clearMenu()
                } else if skillInUse < 0 {
                    clearMenu()
                    openMenu("SKILLS&CALLING")
                }
                
                /* DETECTS CLICKS ON THE SKILLS BAR FOR REGULAR SKILLS */
            } else if location.x >= CONSTANTS.SKILLS_BAR_EDGE && UNIVERSE.theGame.player.skills.count > 0 && location.y >= CONSTANTS.SKILLS_BAR_BASE_Y - 16 && skillInUse < 0 {    //if we're beyond the skills bar edge and the player has at least 1 skill
                var skillNo = Int((location.x+32) / 32) //calculate skill # based on mouse click x location
                if skillNo < 0 { skillNo = 0 }  //if the skill is negative, make it the first skill (0)
                if skillNo > UNIVERSE.theGame.player.skills.count-1 { return }   //if we're out of bounds when considering available skills, just return
                
                var i : Int = 0 //initialize i
                for subskill in UNIVERSE.theGame.player.skills[skillNo].subskills { //for every subskill in current natural skill
                    
                    let subskillMenu : MenuItem = MenuItem(theText: subskill.name!) //make a menu for the subskill
                    subskillMenu.name = String(skillNo) + " " + subskill.name!  //set the name to "[skillno] [skillname]"
                    subskillMenu.position = CGPoint(x: location.x+100, y: 0)  //put at bottom of screen initially
                    subskillMenu.position.y += CGFloat(i * 32)  //move up by 32px with each successive subskill menu
                    subskillMenu.zPosition = 100    //put on top of everything
                    lowerBanner.addChild(subskillMenu) //add to scene
                    i++ //increment i
                    
                }
                let cancelMenu : MenuItem = MenuItem(theText: "Cancel") //make a cancel menu last
                cancelMenu.name = "Cancel"  //name = Cancel
                cancelMenu.position = CGPoint(x: location.x+100, y: 0)    //start at bottom of screen
                cancelMenu.position.y += CGFloat(i * 32)    //but above last subskill menu
                cancelMenu.zPosition = 100  //put on top of everything
                lowerBanner.addChild(cancelMenu)   //add to scene
                
                /* DETECTS CLICKS ON THE SKILLS BAR FOR SPIRITUAL GIFT SKILLS */
            } else if location.x >= CONSTANTS.SKILLS_BAR_EDGE && giftSkills.count > 0 && location.y >= CONSTANTS.SKILLS_BAR_BASE_Y - 48 && location.y <= CONSTANTS.SKILLS_BAR_BASE_Y - 16 && skillInUse < 0 {   //if we've clicked a skill in the spiritual gifts skill bar (the bottom row)
                var skillNo = Int((location.x+32) / 32) //calculate skill # based on mouse click x location
                if skillNo < 0 { skillNo = 0 }  //if it's negative, make it the first skill (0)
                if skillNo > giftSkills.count-1 { return }  //if we're out of bounds when considering available gift skills, just return
                if giftSkills[skillNo].canUse() && giftSkills[skillNo].passive == false {   //if the skill is usable right now & not passive
                    if skillInUse < 0 { //and if skill in use is nothing (-1 typically) [if we're not currently working on another skill function]
                        skillInUse = skillNo + 10   //set skill in use to the clicked skill (plus 10 because it's the bottom row)
                        makeProgressBarFor( giftSkills[skillNo].hoursToComplete, caption: giftSkills[skillNo].title, completion: {
                            
                            var hasTarget = false
                            for npc in UNIVERSE.theGame.currentLocation.people {
                                if npc.selected {
                                    self.giftSkills[skillNo].useOnNPC(npc)
                                    hasTarget = true
                                    break
                                }
                            }
                            for animal in UNIVERSE.theGame.currentLocation.animals {
                                if animal.selected {
                                    self.giftSkills[skillNo].useOnAnimal(animal)
                                    hasTarget = true
                                    break
                                }
                            }
                            if hasTarget == false {
                                self.giftSkills[skillNo].use()
                            }
                            
                            self.removeProgressBar()
                            self.skillInUse = -1
                            
                        } )//make a progress bar with a duration based on a negative logarithmic curve from initial "hoursToComplete" value on down to a lower and lower number, so the higher your level in this skill, the less time it will take to complete the skill function
                    }
                }
                
            } else {    //if we've clicked anywhere that's not part of the active UI
                
                if UNIVERSE.theGame.meditating {
                    //do nothing
                } else {
                    clearMenu() //clear open menu
                }
                
            }
            
        } else { /* Has the user clicked OUTSIDE the lower banner? */
            
            if UNIVERSE.theGame.meditating {
                //do nothing
            } else {
                clearMenu() //clear open menu
            }

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
        
        if PAUSED == false {    //if not already paused
            PREV_GAME_SPEED = GAME_SPEED    //record previous game speed
        }
        GAME_SPEED = 0.0    //set game speed to zero (pause game)
        PAUSED = true   //we are now paused
        
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
        
        if key == SPACEBAR && !UNIVERSE.theGame.meditating { //SPACEBAR IS PRESSED, PAUSE/UNPAUSE GAME
            pauseUnPause()
        } else if key == MINUS && !UNIVERSE.theGame.meditating {   //MINUS KEY PRESSED
            GAME_SPEED /= 2.0   //divide game speed in half
        } else if key == PLUS && !UNIVERSE.theGame.meditating {   //PLUS KEY PRESSED
            GAME_SPEED *= 2.0   //multiply game speed by two
        } else if key == I && !UNIVERSE.theGame.meditating {   //'I' KEY IS PRESSED
            if menuUp == "INVENTORY" {  //pretty self explanatory, shows the menu corresponding to the key pressed
                clearMenu()
            } else {
                openMenu("INVENTORY")
            }
        } else if key == P && !UNIVERSE.theGame.meditating {   //'P' KEY PRESSED
            if menuUp == "PARTY" {
                clearMenu()
            } else {
                openMenu("PARTY")
            }
        } else if key == N && !UNIVERSE.theGame.meditating {   //'N' KEY
            if menuUp == "NOTES" {
                clearMenu()
            } else {
                openMenu("NOTES")
            }
        } else if key == K && !UNIVERSE.theGame.meditating {   //'K'
            if menuUp == "KNOWLEDGE" {
                clearMenu()
            } else {
                openMenu("KNOWLEDGE")
            }
        } else if key == R && !UNIVERSE.theGame.meditating {   //'R'
            if menuUp == "PRAYER" {
                clearMenu()
            } else {
                openMenu("PRAYER")
            }
        } else if key == T && !UNIVERSE.theGame.meditating {   //'T'
            if menuUp == "TRAVEL" {
                clearMenu()
            } else {
                openMenu("TRAVEL")
            }
        } else if key == L && !UNIVERSE.theGame.meditating {    //'L'
            if menuUp == "SKILLS&CALLING" {
                clearMenu()
            } else {
                openMenu("SKILLS&CALLING")
            }
            
        } else if key == ESCAPE && !UNIVERSE.theGame.meditating { //'esc'
            clearMenu()
        
        /* CHARACTER MOVEMENT & STATE CHANGE (SITTING, ETC.) CODE HERE */
        } else if ( key == NUMPAD7 || key == Q ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'7' NUM PAD PRESSED - MOVING INTO UPPER LEFT SQUARE
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterUPPERLEFT")    //displays char moving up-left
            if Int(UNIVERSE.theGame.player.currentGridLocation.x + 1) < UNIVERSE.theGame.currentLocation.grid[0].count && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y)][Int(UNIVERSE.theGame.player.currentGridLocation.x + 1)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y)][Int(UNIVERSE.theGame.player.currentGridLocation.x + 1)].npcList.count == 0 { //if in bounds and no collision
                playSound("WalkCycle.aiff") //play walking sound
                let moveUpperLeft = SKAction.moveByX(-64, y: 32, duration: CONSTANTS.PLAYER_MOVE_TIME)   //move gradually to new location
                UNIVERSE.theGame.player.runAction(moveUpperLeft) //runs the action defined above
                UNIVERSE.theGame.player.currentGridLocation.x += 1   //sets grid location (corresponding to matrix, not spritekit location)
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation) //pick up any items in-square automatically
                orderCorrectly()    //change the Z order of the player depending on objects around them
            }
            
        } else if ( key == NUMPAD8 || key == W ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'8' NUM PAD PRESSED - everything else is the same idea as above, just look at [imageNamed:"characterXXXX"] for movement direction
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterUP")
            if Int(UNIVERSE.theGame.player.currentGridLocation.x + 1) < UNIVERSE.theGame.currentLocation.grid[0].count && Int(UNIVERSE.theGame.player.currentGridLocation.y + 1) < UNIVERSE.theGame.currentLocation.grid.count && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y + 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x + 1)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y + 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x + 1)].npcList.count == 0 {
                playSound("WalkCycle.aiff") //play walking sound
                let moveUp = SKAction.moveByX(0, y: 64, duration: CONSTANTS.PLAYER_MOVE_TIME)
                UNIVERSE.theGame.player.runAction(moveUp)
                UNIVERSE.theGame.player.currentGridLocation.x += 1
                UNIVERSE.theGame.player.currentGridLocation.y += 1
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation)
                orderCorrectly()
            }
            
        } else if ( key == NUMPAD9 || key == E ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'9' NUM PAD PRESSED
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterUPPERRIGHT")
            if Int(UNIVERSE.theGame.player.currentGridLocation.y + 1) < UNIVERSE.theGame.currentLocation.grid.count && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y + 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y + 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x)].npcList.count == 0 {
                playSound("WalkCycle.aiff") //play walking sound
                let moveUpperRight = SKAction.moveByX(64, y: 32, duration: CONSTANTS.PLAYER_MOVE_TIME)
                UNIVERSE.theGame.player.runAction(moveUpperRight)
                UNIVERSE.theGame.player.currentGridLocation.y += 1
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation)
                orderCorrectly()
                
                
            }
                /************** GAH! ****************
                
            } else if Int(UNIVERSE.theGame.player.currentGridLocation.y + 1) == UNIVERSE.theGame.currentLocation.grid.count {
                UNIVERSE.theGame.currentLocation = UNIVERSE.theGame.currentCity.cityLocations[0][1]
                UNIVERSE.theGame.player.currentGridLocation = CGPoint( x: UNIVERSE.theGame.player.currentGridLocation.x, y: 0 )
                createLocation()
                orderCorrectly()
            }
                ***********************************/
            
        } else if ( key == NUMPAD4 || key == A ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'4' NUM PAD PRESSED
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterLEFT")
            if Int(UNIVERSE.theGame.player.currentGridLocation.x + 1) < UNIVERSE.theGame.currentLocation.grid[0].count && Int(UNIVERSE.theGame.player.currentGridLocation.y - 1) >= 0 && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y - 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x + 1)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y - 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x + 1)].npcList.count == 0 {
                playSound("WalkCycle.aiff") //play walking sound
                let moveLeft = SKAction.moveByX(-128, y: 0, duration: CONSTANTS.PLAYER_MOVE_TIME)
                UNIVERSE.theGame.player.runAction(moveLeft)
                UNIVERSE.theGame.player.currentGridLocation.y -= 1
                UNIVERSE.theGame.player.currentGridLocation.x += 1
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation)
                orderCorrectly()
            }
            
        } else if ( key == NUMPAD5 || key == S ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'5' NUM PAD PRESSED
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterSEATED") //make character sit for center key
            
        } else if ( key == NUMPAD6 || key == D ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'6' NUM PAD PRESSED
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterRIGHT")
            if Int(UNIVERSE.theGame.player.currentGridLocation.x - 1) >= 0 && Int(UNIVERSE.theGame.player.currentGridLocation.y + 1) < UNIVERSE.theGame.currentLocation.grid.count && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y + 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x - 1)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y + 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x - 1)].npcList.count == 0 {
                playSound("WalkCycle.aiff") //play walking sound
                let moveRight = SKAction.moveByX(128, y: 0, duration: CONSTANTS.PLAYER_MOVE_TIME)
                UNIVERSE.theGame.player.runAction(moveRight)
                UNIVERSE.theGame.player.currentGridLocation.y += 1
                UNIVERSE.theGame.player.currentGridLocation.x -= 1
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation)
                orderCorrectly()
            }
            
        } else if ( key == NUMPAD1 || key == Z ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'1' NUM PAD PRESSED
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterLOWERLEFT")
            if Int(UNIVERSE.theGame.player.currentGridLocation.y - 1) >= 0 && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y - 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y - 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x)].npcList.count == 0 {
                playSound("WalkCycle.aiff") //play walking sound
                let moveLowerLeft = SKAction.moveByX(-64, y: -32, duration: CONSTANTS.PLAYER_MOVE_TIME)
                UNIVERSE.theGame.player.runAction(moveLowerLeft)
                UNIVERSE.theGame.player.currentGridLocation.y -= 1
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation)
                orderCorrectly()
            }
            
        } else if ( key == NUMPAD2 || key == X ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'2' NUM PAD PRESSED
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterDOWN")
            if Int(UNIVERSE.theGame.player.currentGridLocation.x - 1) >= 0 && Int(UNIVERSE.theGame.player.currentGridLocation.y - 1) >= 0 && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y - 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x - 1)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y - 1)][Int(UNIVERSE.theGame.player.currentGridLocation.x - 1)].npcList.count == 0 {
                playSound("WalkCycle.aiff") //play walking sound
                let moveDown = SKAction.moveByX(0, y: -64, duration: CONSTANTS.PLAYER_MOVE_TIME)
                UNIVERSE.theGame.player.runAction(moveDown)
                UNIVERSE.theGame.player.currentGridLocation.y -= 1
                UNIVERSE.theGame.player.currentGridLocation.x -= 1
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation)
                orderCorrectly()
            }
            
        } else if ( key == NUMPAD3 || key == C ) && !PAUSED && !UNIVERSE.theGame.meditating {   //'3' NUM PAD PRESSED
            UNIVERSE.theGame.player.texture = SKTexture(imageNamed: "characterLOWERRIGHT")
            if Int(UNIVERSE.theGame.player.currentGridLocation.x - 1) >= 0 && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y)][Int(UNIVERSE.theGame.player.currentGridLocation.x - 1)].extraObject == "" && UNIVERSE.theGame.currentLocation.grid[Int(UNIVERSE.theGame.player.currentGridLocation.y)][Int(UNIVERSE.theGame.player.currentGridLocation.x - 1)].npcList.count == 0 {
                playSound("WalkCycle.aiff") //play walking sound
                let moveLowerRight = SKAction.moveByX(64, y: -32, duration: CONSTANTS.PLAYER_MOVE_TIME)
                UNIVERSE.theGame.player.runAction(moveLowerRight)
                UNIVERSE.theGame.player.currentGridLocation.x -= 1
                pickUpItems(UNIVERSE.theGame.player.currentGridLocation)
                orderCorrectly()
            }
            
        } else {
            print(key)    //FOR DEBUGGING, PRINT ANY KEY CODE NOT YET USED
        }
        
    }
    
    /* CHANGES THE Z POSITION OF THE CHARACTER TO KEEP THEM IN FRONT OF OR BEHIND OTHER OBJECTS LIKE TREES DEPENDING ON THEIR LOCATION */
    func orderCorrectly() {
        
        var xcoord = Int(UNIVERSE.theGame.player.currentGridLocation.x + 1)  //looking at the square just above the player
        var ycoord = Int(UNIVERSE.theGame.player.currentGridLocation.y + 1)  //  "     "   "   "     "     "     "   "
        if xcoord >= 0 && xcoord < UNIVERSE.theGame.currentLocation.grid[0].count && ycoord >= 0 && ycoord < UNIVERSE.theGame.currentLocation.grid.count {
            if UNIVERSE.theGame.currentLocation.grid[ycoord][xcoord].extraObject != "" || UNIVERSE.theGame.currentLocation.grid[ycoord-1][xcoord].extraObject != "" || UNIVERSE.theGame.currentLocation.grid[ycoord][xcoord-1].extraObject != "" {     //check that square and the two adjacent squares (L and R) for objects
                UNIVERSE.theGame.player.zPosition = 1    //player should be drawn in front of the object
            } else {
                UNIVERSE.theGame.player.zPosition = 0    //otherwise player should be drawn behind the object
            }
        }
        
        xcoord = Int(UNIVERSE.theGame.player.currentGridLocation.x - 1)  //looking at square just below the player
        ycoord = Int(UNIVERSE.theGame.player.currentGridLocation.y - 1)  //  "       "   "   "       "   "   "
        if xcoord >= 0 && xcoord < UNIVERSE.theGame.currentLocation.grid[0].count && ycoord >= 0 && ycoord < UNIVERSE.theGame.currentLocation.grid.count {
            if UNIVERSE.theGame.currentLocation.grid[ycoord][xcoord].extraObject != "" || UNIVERSE.theGame.currentLocation.grid[ycoord+1][xcoord].extraObject != "" || UNIVERSE.theGame.currentLocation.grid[ycoord][xcoord+1].extraObject != "" {     //check that square and two adjacent squares (L and R) for objects
                UNIVERSE.theGame.player.zPosition = 0    //player should be drawn behind the object
            } else {
                UNIVERSE.theGame.player.zPosition = 1    //otherwise player should be drawn in front of object
            }
        }
        
        for animal in UNIVERSE.theGame.currentLocation.animals {
            
            animal.zPosition = 0.5
            
        }
        
    }
    
    /* HANDLES PICKING UP ITEMS IN A PARTICULAR LOCATION ON THE GRID */
    func pickUpItems(pt: CGPoint) {
        
        let x = Int(pt.x)   //make the CGPoint into two integer coordinates for the grid
        let y = Int(pt.y)   //as above
        if UNIVERSE.theGame.currentLocation.grid[y][x].contents.count > 0 {  //if there's something to pick up
            UNIVERSE.theGame.player.inventory.append(UNIVERSE.theGame.currentLocation.grid[y][x].contents[0]) //add to player inventory
            UNIVERSE.theGame.currentLocation.grid[y][x].contents[0].removeFromParent()   //remove from the scene
            UNIVERSE.theGame.currentLocation.grid[y][x].contents.removeAtIndex(0)    //remove from the grid square entirely
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
    
    /* GOOD FOR MOUSE CLICKS GOING FROM ISO VIEW ON THE SCENE INTO A GRID SQUARE 2D COORD I.E. WHAT SQUARE DID I CLICK? */
    func getTileCoordinates(pt: CGPoint) -> CGPoint {
        
        var tempPt = CGPoint(x: 0, y: 0)
        let tileHeight = CGFloat(64.0)
        tempPt.x = floor(pt.x / tileHeight)
        tempPt.y = floor(pt.y / tileHeight)
        return(tempPt)
        
    }
    
    /* CREATES THE CURRENT LOCATION THE PLAYER IS IN ON THE SCENE */
    func createLocation() {
        
        world.removeAllChildren()
        
        for x in 0...UNIVERSE.theGame.currentLocation.grid.count-1 {     //iterating through the x coords of the loc. grid
            for y in 0...UNIVERSE.theGame.currentLocation.grid[0].count-1 {  //iterating through the y coords of the loc. grid
                let xx = UNIVERSE.theGame.currentLocation.grid.count-x-1 //converts x to reverse order for drawing prettiness
                let yy = UNIVERSE.theGame.currentLocation.grid[0].count-y-1  //same for y
                let square = SKSpriteNode(imageNamed:UNIVERSE.theGame.currentLocation.grid[xx][yy].texture)  //grabs the tex
                square.position = twoDToIso(CGPoint(x: xx * 64, y: yy * 64))    //converts to iso coords
                square.zPosition = 0    //draw square underneath player and extra objects
                world.addChild(square)  //adds to the world
                if UNIVERSE.theGame.currentLocation.grid[xx][yy].contents.count > 0 {    //if there's an item to draw
                    UNIVERSE.theGame.currentLocation.grid[xx][yy].contents[0].position = CGPoint.zero  //puts it in the center of the iso square
                    square.addChild(UNIVERSE.theGame.currentLocation.grid[xx][yy].contents[0])    //adds to the square
                }
                if UNIVERSE.theGame.currentLocation.grid[xx][yy].npcList.count > 0 { //if there's an npc to draw
                    UNIVERSE.theGame.currentLocation.grid[xx][yy].npcList[0].position = CGPoint(x: 0, y: 32)    //puts it in the center of the iso square
                    UNIVERSE.theGame.currentLocation.grid[xx][yy].npcList[0].zPosition = 1.0 //put in front of other stuff
                    square.addChild(UNIVERSE.theGame.currentLocation.grid[xx][yy].npcList[0])    //adds it to the square
                }
                if UNIVERSE.theGame.currentLocation.grid[xx][yy].animalList.count > 0 { //if there's an animal to draw
                    UNIVERSE.theGame.currentLocation.grid[xx][yy].animalList[0].position = CGPoint.zero //puts it in the center of the iso square
                    UNIVERSE.theGame.currentLocation.grid[xx][yy].animalList[0].zPosition = 0.25 //put on top of all terrain
                    square.addChild(UNIVERSE.theGame.currentLocation.grid[xx][yy].animalList[0]) //adds it to the square
                }
            }
        }
        
        /* draw player before objects for correct layering */
        UNIVERSE.theGame.player.position = twoDToIso(CGPoint(x: UNIVERSE.theGame.player.currentGridLocation.x * 64 + 32, y: UNIVERSE.theGame.player.currentGridLocation.y * 64 + 32))  //sets the player's position as the correct grid location
        UNIVERSE.theGame.player.zPosition = 0
        world.addChild(UNIVERSE.theGame.player)  //add the player to the world
        
        if UNIVERSE.theGame.currentLocation.visited == false {
            UNIVERSE.theGame.player.experience += 1000
            UNIVERSE.alertText("Explored new location, +1000 experience")
            UNIVERSE.theGame.currentLocation.visited = true
        }
        
        for x in 0...UNIVERSE.theGame.currentLocation.grid.count-1 {     //iterating through the x coords of the loc. grid
            for y in 0...UNIVERSE.theGame.currentLocation.grid[0].count-1 {  //iterating through the y coords of the loc. grid
                let xx = UNIVERSE.theGame.currentLocation.grid.count-x-1 //converts x to reverse order for drawing prettiness
                let yy = UNIVERSE.theGame.currentLocation.grid[0].count-y-1  //same for y
                if UNIVERSE.theGame.currentLocation.grid[xx][yy].extraObject != "" {     //if there's an extra object to draw in this square
                    let object = SKSpriteNode(imageNamed: UNIVERSE.theGame.currentLocation.grid[xx][yy].extraObject) //create the object as a sprite node based on its name stored in extraObject data member
                    let pos = twoDToIso(CGPoint(x: xx * 64, y: yy * 64))
                    object.position = CGPoint(x: pos.x, y: pos.y + object.size.height / 2)     //position puts bottom of sprite at baseline for grid square
                    object.zPosition = 0.5  //draw the extra objects in front of the squares but behind the player when player is in front of the object on the grid
                    world.addChild(object) //adds to the square
                }
            }
        }
        
        if !self.children.contains(dateLabel) {
            
            0/* set up the date label and add it to the scene */
            dateLabel.color = SKColor.blackColor()
            dateLabel.fontSize = CONSTANTS.TIMESTAMP_FONT_SIZE //set date label font size
            dateLabel.position = CGPoint(x:CGRectGetMidX(self.frame) + CONSTANTS.TIMESTAMP_OFFSET_X, y: CONSTANTS.TIMESTAMP_OFFSET_Y)    //puts the date/time at bottom center of the screen, just above the button bar
            dateLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            dateLabel.zPosition = CONSTANTS.TIMESTAMP_OFFSET_Z
            self.addChild(dateLabel)    //adds the date label to the scene (not the world, so it stays in place like the banner
        
        }
        
    }
    
    /* CHECKS FOR BIBLE EVENTS AND READS SCRIPTURE TO THE PLAYER AS THE EVENTS OCCUR */
    var timeSpentReadingMarker : CFTimeInterval = 0.0
    
    func updateBibleEvents( time: CFTimeInterval ) {
        
       /* if UNIVERSE.theGame.bibleEvents.count == UNIVERSE.theGame.nextEvent { //if the Bible has no more events to describe...
            exit(0) //exit the game completely
        }
        
        if UNIVERSE.theGame.bibleEvents[UNIVERSE.theGame.nextEvent].date.laterDate(UNIVERSE.theGame.gameDate) == UNIVERSE.theGame.gameDate {    //if we've hit or slightly passed a Bible Event...
            
            playSound(UNIVERSE.theGame.bibleEvents[UNIVERSE.theGame.nextEvent].soundFile) //play audio bible clip
            UNIVERSE.theGame.nextEvent++ //increment bible events
            
        } */
        
    }
    
    /* MAKES A PROGRESS BAR FOR SKILLS OR GIFTS IN PROGRESS */
    func makeProgressBarFor( time: Double, caption: String, completion: () -> Void ) {
        
        progBarCaption = SKLabelNode(text: caption) //make caption
        progBarCaption.zPosition = 5.0  //put the caption in front of the frame and prog bar
        progBarCaption.position = CGPointZero   //center the caption
        progBarCaption.fontSize = 14    //font size
        progBarCaption.fontName = "Arial Bold"  //font
        progBarFrame.position = CGPointZero //center the frame
        progBarFrame.zPosition = 3.0    //put the frame in back
        progBar.position = CGPointZero  //center the progbar
        progBar.zPosition = 4.0 //place the progbar between the frame and the caption
        progBarDuration = time  //set the duration to the time given when makeProgressBarFor was called
        progBar.size = CGSizeMake(1, progBar.size.height)   //make the progbar invisible for starters (zero width)
        self.addChild(progBarFrame) //add frame to scene
        self.addChild(progBarCaption)   //add caption to scene
        self.addChild(progBar)  //add progbar to scene
        let progBarScale = SKAction.resizeToWidth(CONSTANTS.PROG_BAR_WIDTH, duration: progBarDuration)
        progBar.runAction(progBarScale, completion: {
            self.removeProgressBar()
            completion()
        })
        
    }
    
    /* REMOVES THE PROGRESS BAR FROM THE SCENE, ACTIVATES THE SKILL OR GIFT BEING WAITED FOR */
    func removeProgressBar() {
        
        progBarFrame.removeFromParent() //remove the frame
        progBar.removeFromParent()  //remove the bar
        progBarCaption.removeFromParent()   //remove the caption
        //progBarTime = 0.0   //reset time position DEPRECATED
        progBarDuration = 0.0   //reset duration
        progBarCaption = SKLabelNode(text: "")  //reset caption
        
    }
    
    /* EVERY FRAME DO THIS (60 times/sec) */
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        UNIVERSE.currentTimeGlobal = currentTime
        
        if UNIVERSE.theGame.player.currentPrayerFocus.contains("Pray Over Skills") {
            
            if Int(currentTime) % (100) == 0 {
            
                UNIVERSE.theGame.player.skills[random() % UNIVERSE.theGame.player.skills.count].levelUp()
                
            }
            
        }
        
        if UNIVERSE.theGame.player.currentPrayerFocus.contains("Pray For Health") {
            
            if Int(currentTime) % (100) == 0 {
                
                UNIVERSE.theGame.player.physicalHealth = 100 / UNIVERSE.theGame.player.currentPrayerFocus.count
                
            }
            
        }
        
        if UNIVERSE.theGame.player.currentPrayerFocus.contains("Pray For Gifts") {
            
        }
        
        if UNIVERSE.theGame.player.currentPrayerFocus.contains("Pray For Experience") {
                
            UNIVERSE.theGame.player.experience += Int(100 / UNIVERSE.theGame.player.currentPrayerFocus.count)
            
        }
        
        for animal in UNIVERSE.theGame.currentLocation.animals {  //for each animal
            
            animal.updateAI(currentTime)    //update the AI
            
        }
        
        for npc in UNIVERSE.theGame.currentLocation.people {    //for each npc
            
            npc.update(currentTime) //update the AI/quests/etc
            
        }
        
        for skill in giftSkills {
            
            skill.applyPassiveTraits()
            
        }
        
        updateExperienceBars()
        
        //orderCorrectly()
        
        dateLabel.text = formatter.stringFromDate(UNIVERSE.theGame.gameDate) //grabs the date & time and puts it in the dateLabel
        
        updateBibleEvents( currentTime )
        
        UNIVERSE.theGame.gameDate = UNIVERSE.theGame.gameDate.dateByAddingTimeInterval(GAME_SPEED)    //increase game time by game speed amount, so 1.0 would be 60 sec game time per 1 sec real time, 2.0 would be 120 sec game time per 1 sec real time, 0.5 would be 30 sec game time per 1 sec real time, etc. etc.
        
    }
    
}

/* SET UP AND PLAY BACKGROUND MUSIC */
var backgroundMusicPlayer: AVAudioPlayer!
var soundPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {    //sets up an audio player to play background music
    
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    if (url == nil) {
        print("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    do {
        backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: url!)
    } catch let error1 as NSError {
        error = error1
        backgroundMusicPlayer = nil
    }
    if backgroundMusicPlayer == nil {
        print("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1    //loop continuously
    backgroundMusicPlayer.prepareToPlay()   //load into memory
    backgroundMusicPlayer.volume = 0.5
    backgroundMusicPlayer.play()    //play song
    
}

func unMuteBackgroundMusic() {
    
    backgroundMusicPlayer.volume = 0.5
    
}

func muteBackgroundMusic() {
    
    backgroundMusicPlayer.volume = 0.05
    
}

/* GET SOUND LENGTH */
func getSoundLength(filename: String) -> NSTimeInterval {
    
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    if (url == nil) {
        print("Could not find file: \(filename)")
        return NSTimeInterval(0)
    }
    
    var error: NSError? = nil
    do {
        soundPlayer = try AVAudioPlayer(contentsOfURL: url!)
    } catch let error1 as NSError {
        error = error1
        soundPlayer = nil
    }
    if soundPlayer == nil {
        print("Could not create audio player: \(error!)")
        return NSTimeInterval(0)
    }
    
    return soundPlayer.duration
    
}

/* SET UP AND PLAY A GIVEN SOUND */
func playSound(filename: String) {    //sets up an audio player to play sound effects and scripture readings
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    if (url == nil) {
        print("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    do {
        soundPlayer = try AVAudioPlayer(contentsOfURL: url!)
    } catch let error1 as NSError {
        error = error1
        soundPlayer = nil
    }
    if soundPlayer == nil {
        print("Could not create audio player: \(error!)")
        return
    }

    soundPlayer.numberOfLoops = 0   //play once
    soundPlayer.prepareToPlay() //load into memory
    soundPlayer.play()  //play sound
}