//
//  BibleEvent.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation

class BibleEvent {
    
    var title: String
    var description: String
    var city: City
    var location: Location
    var building: Building
    var room: Room
    var date: NSDate
    
    init( yr:Int, mo:Int, dy:Int, hr:Int, min:Int, sec:Int, ttl:String, desc:String, c:City, l:Location, b:Building, r:Room ) {
        
        let hebrewCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)
        let dateComponents = NSDateComponents()
        dateComponents.year = yr
        dateComponents.month = mo
        dateComponents.day = dy
        dateComponents.hour = hr
        dateComponents.minute = min
        dateComponents.second = sec
        //dateComponents.timeZone = NSTimeZone(name: "Central Time (US & Canada)")
        date = hebrewCalendar!.dateFromComponents(dateComponents)!

        title = ttl
        description = desc
        city = c
        location = l
        building = b
        room = r
    }
    
}