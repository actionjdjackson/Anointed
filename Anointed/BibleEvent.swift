//
//  BibleEvent.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

/* DEFINES A BIBLE EVENT WITH A DATE & TIME, TITLE, DESCRIPTION (MAIN TEXT), CITY, LOCATION, BUILDING, AND ROOM */
class BibleEvent {
    
    var title: String
    var description: String
    var city: City
    var location: Location
    var building: Building
    var room: Room
    var date: NSDate
    var soundFile : String
    
    /* INITIALIZATION */
    init( yr:Int, mo:Int, dy:Int, hr:Int, min:Int, sec:Int, ttl:String, desc:String, audioFile: String, c:City, l:Location, b:Building, r:Room ) {
        
        let hebrewCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew) //make a Hebrew calendar
        let dateComponents = NSDateComponents() //make a new NSDateComponents object
        dateComponents.year = yr    //year
        dateComponents.month = mo   //month
        dateComponents.day = dy //day
        dateComponents.hour = hr    //hour
        dateComponents.minute = min //minute
        dateComponents.second = sec //second
        date = hebrewCalendar!.dateFromComponents(dateComponents)!  //make new NSDate from the components and the Hebrew calendar

        title = ttl
        description = desc
        soundFile = audioFile
        city = c
        location = l
        building = b
        room = r
        
    }
    
}