//
//  Global.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* ALLOWS FOR EASY ENTERING OF HEBREW MONTHS THROUGHOUT THE APPLICATION */

struct HebrewMonths {
    static let NISSAN = 7
    static let IYAR = 8
    static let SIVAN = 9
    static let TAMMUZ = 10
    static let AV = 11
    static let ELUL = 12
    static let TISHRI = 1
    static let CHESHVAN = 2
    static let KISLEV = 3
    static let TEVET = 4
    static let SHEVAT = 5
    static let ADAR = 6
    //static let ADAR_B = 13
}

struct CONSTANTS {
    
    /* POSITIONAL/SIZE CONSTANTS USED IN DRAWING, ETC. */
    static let CENTER_OF_SCREEN_X = CGFloat(0.5)
    static let CENTER_OF_SCREEN_Y = CGFloat(0.5)
    static let LOWER_BANNER_X = CGFloat(-112)
    static let LOWER_BANNER_Y = CGFloat(-1050/2 + 32)
    static let LOWER_BANNER_Z = CGFloat(10.0)
    static let EXPERIENCE_BARS_X = CGFloat(400)
    static let EXPERIENCE_BARS_Y = CGFloat(-1050/2 + 32)
    static let EXPERIENCE_BARS_Z = CGFloat(10.0)
    static let OPEN_MENU_Y = CGFloat(-32 + 12)
    static let OPEN_MENU_Z = CGFloat(2.0)
    static let MENU_TITLE_FONT_SIZE = CGFloat(36)
    static let MENU_TITLE_X = CGFloat(0.0)
    static let MENU_TITLE_Y = CGFloat(CGRectGetMaxY(SKSpriteNode(imageNamed:"INVENTORYmenu").frame) / 2.0 + 128 - 32)
    static let SKILLS_BAR_BASE_X = CGFloat(-16)
    static let SKILLS_BAR_BASE_Y = CGFloat(-1050/2 + 32 + 16)
    static let SKILLS_BAR_BASE_Z = CGFloat(10.0)
    static let SKILL_POSITION_BASE_X = CGFloat(96.0 - CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.width) / 2.0)
    static let SKILL_POSITION_BASE_Y = CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.height) / 2.0 - 518.0
    static let GIFT_POSITION_BASE_Y = CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.height) / 2.0 - 128.0 - 48.0
    static let GIFT_POSITION_BASE_X = CGFloat(96.0 - CGFloat(SKSpriteNode(imageNamed:"INVENTORYmenu").frame.width) / 2.0) - 2.0
    static let GIFT_SKILLS_GRID_HEIGHT = 9
    static let SKILL_ICON_SIZE = CGFloat(32.0)
    static let INVENTORY_ITEM_BASE_X = CGFloat(88 - 234 + 32 + 8)
    static let INVENTORY_ITEM_BASE_Y = CGFloat(100 + 32)
    static let INVENTORY_ITEM_SIZE = CGFloat(32.0)
    static let INVENTORY_GRID_WIDTH = 10
    static let INVENTORY_GRID_HEIGHT = 12
    static let SKILLS_GRID_WIDTH = 10
    static let SKILLS_GRID_HEIGHT = 2
    static let LOWER_BANNER_TOP_EDGE = CGFloat(64 - 1050 / 2)
    static let PARTY_BUTTON_EDGE = CGFloat(85 - 1024 / 2)
    static let NOTES_BUTTON_EDGE = CGFloat(85 + 64 - 1024 / 2)
    static let KNOWLEDGE_BUTTON_EDGE = CGFloat(85 + 128 - 1024 / 2)
    static let PRAYER_BUTTON_EDGE = CGFloat(85 + 128 + 64 - 10 - 1024 / 2)
    static let TRAVEL_BUTTON_EDGE = CGFloat(85 + 256 - 10 - 1024 / 2)
    static let INVENTORY_BUTTON_EDGE = CGFloat(85 + 256 + 64 - 10 - 1024 / 2)
    static let SKILLS_BUTTON_EDGE = CGFloat(85 + 256 + 128 - 10 - 1024 / 2)
    static let SKILLS_BAR_EDGE = CGFloat(-32)
    static let TIMESTAMP_OFFSET_X = CGFloat(-128 - 32)
    static let TIMESTAMP_OFFSET_Y = CGFloat(64 + 14 - 1050 / 2)
    static let TIMESTAMP_OFFSET_Z = CGFloat(10.0)
    static let TIMESTAMP_FONT_SIZE = CGFloat(14)
    static let PROG_BAR_WIDTH = CGFloat(256.0)
    static let PLAYER_MOVE_TIME = 0.125
    static let SECONDS_IN_ONE_HOUR = 60.0 * 60.0
    static let KNOWLEDGE_MENU_SCROLL_OFFSET_X = -256 - 128 - 64 - 32 + 8 + 1
    static let KNOWLEDGE_MENU_SCROLL_OFFSET_Y = 256 - 64 - 8 + 4
    
}

struct UNIVERSE {
    
    static let theGame = GameWorld()
    
    static var theScene : GameScene = GameScene()
    
    static var alertCount : Int = 0
    static func alertText( text : String ) {
        let at = AlertText(alertText: text)
        at.position.y -= CGFloat(32 * alertCount)
        alertCount++
    }
    
}

struct FILE_OPERATIONS {

    static func getTextFromFile( filename : String ) -> String {
    
        let path = NSBundle.mainBundle().pathForResource( filename, ofType: "txt" )!    //grab the path of the text file
        return try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)    //grab the text and put into string and return
    
    }
    
}