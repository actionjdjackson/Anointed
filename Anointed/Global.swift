//
//  Global.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

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

struct UNIVERSE {
    
    static let theGame = GameWorld()
    
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