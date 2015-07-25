//
//  GameWorld.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* THE GAME WORLD CLASS KEEPS TRACK OF ALL THE CITIES, LOCATIONS, BUILDINGS, ROOMS, THE PLAYER (GAME CHARACTER), THE IN-GAME DATE AND TIME, AND ALL BIBLE EVENTS. IT WILL CONTAIN ALL "LEVEL" DATA AS DEFINED IN TEXT FILES OR JUST HARD-CODED INTO THIS FILE, DEPENDING ON WETHER OR NOT I WANT TO MAKE A LEVEL EDITOR, WHICH I PROBABLY WILL. ***IN PROGRESS*** */
class GameWorld {
    
    var bibleEvents: [BibleEvent]
    var cities: [City]
    var nextEvent: Int
    var gameDate: NSDate
    var currentCity: City
    var currentLocation: Location
    var player: GameCharacter
    var knowledgeBase: [Knowledge]
    var understandingBase: [Understanding]
    var wisdomBase: [Wisdom]
    var skillTree: [[Skill]]
    var miraclesTree: [Skill]
    
    init() {
        
        /* set up the knowledge base of the game (knowledge, wisdom, and understanding) */
        let godsOmnipotence = Knowledge(ttl: "God is Omnipotent", desc: "God can do anything. He made me, He can do whatever He wants, whenever He wants.", scrip: "Psalm 139")
        let godsOmnipresence = Knowledge(ttl: "God is Omnipresent", desc: "God is everywhere. You cannot escape Him, no matter where you go.", scrip: "Psalm 139:7-12")
        let godsOmniscience = Knowledge(ttl: "God is Omniscient", desc: "God knows everything. He knows your thoughts, your heart, and everything about you.", scrip: "Psalm 139:1-4")
        let yahwehIsGod = Knowledge(ttl: "God's Name is Yahweh", desc: "God's name is Yahweh, which means I AM THAT I AM.", scrip: "Exodus 3:14")
        
        knowledgeBase = [godsOmnipotence, godsOmnipresence, godsOmniscience, yahwehIsGod]
        
        let iShouldFearGod = Understanding(knowledgeElements: [godsOmnipotence, godsOmnipresence, godsOmniscience], ttl: "I should fear God", desc: "Because God is omnipotent, omnipresent, and omniscient, I should fear Him.", scrip: "Psalm 139:23-24")
        
        understandingBase = [iShouldFearGod]
        
        let fearOfTheLord = Wisdom(understandingElements: [iShouldFearGod], knowledgeElements: [yahwehIsGod], ttl: "The Fear of Yahweh", desc: "Because I know who God is (Yahweh) and that I should fear Him, I choose to fear Him. This is the beginning of wisdom.", scrip: "Proverbs 9:10")
        
        wisdomBase = [fearOfTheLord]
        
        player = GameCharacter()    //set up a default character
        
        /* CREATE & ADD SKILLS & GIFTS */
        var tentmakingSkill : Tentmaking    //create tentmaking skill
        tentmakingSkill = Tentmaking(user: player)
        
        player.skills.append(tentmakingSkill)   //player (for now) has the tentmaking skill
        
        var winemakingSkill : Winemaking    //create winemaking skill (will be a subset of miracles gift)
        winemakingSkill = Winemaking(user: player)
        
        var miraclesGift : SpiritualGift    //create miracles gift
        miraclesGift = SpiritualGift(giftName: "The Gift of Miracles", giftDesc: "A spritual gift that allows the player miraculous powers to alter nature, provide signs and wonders for unbelievers, and support the faith and confidence of believers.", giftUser: player, giftSprite: "miracles", giftSkills: [winemakingSkill])
        
        player.spiritualGifts.append(miraclesGift)  //player (for now) has the gift of miracles
        
        /* CREATE SKILL TREES */
        skillTree = [[tentmakingSkill]]
        miraclesTree = [winemakingSkill]
        
        
        /* set up the initial game date as the day of Jesus' birth, at around 8 am */
        let hebrewCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)
        let gameDateComponents = NSDateComponents()
        gameDateComponents.year = 3755
        gameDateComponents.month = HebrewMonths.TISHRI
        gameDateComponents.day = 15
        gameDateComponents.hour = 8
        gameDateComponents.minute = 0
        gameDateComponents.second = 0
        gameDate = hebrewCalendar!.dateFromComponents(gameDateComponents)!
        
        //sets up nil room and nil building as empty objects for placeholders
        var nilRoom = Room(ttl: "Default Nil Room", gridSquares: [[]])
        var nilBuilding = Building(ttl: "Default Nil Building", r: [[]])
        
        //makes all the items in the game
        var psalm139Scroll = Scroll(ttl: "Psalm 139 Scroll", desc: "A copy of the 139th Psalm, in Hebrew, originally written by King David. In fairly good condition, and fully readable. Must know how to read Hebrew to use this scroll.", textFile: "Psalm139", lang: "Hebrew", scrollSize: 1)
        var wood = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, iconName: "wood")
        var cord = Item(ttl: "Cord", desc: "1 Unit of Cord", sx: 1, sy: 1, iconName: "cord")
        var cloth = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, iconName: "cloth")
        
        //defines the different types of grid squares
        var emptyGrassSquare = GridSquare(tex: "grass", hasItems: [], obj: "")
        var emptyBrickSquare = GridSquare(tex: "brick", hasItems: [], obj: "")
        var grassWithWood = GridSquare(tex: "grass", hasItems: [wood], obj: "")
        var grassWithCord = GridSquare(tex: "grass", hasItems: [cord], obj: "")
        var grassWithCloth = GridSquare(tex: "grass", hasItems: [cloth], obj: "")
        var grassWithPsalm139Scroll = GridSquare(tex: "grass", hasItems: [psalm139Scroll], obj: "")
        var grassWithTree = GridSquare(tex: "grass", hasItems: [], obj: "tree")
        var grassWithOtherTree = GridSquare(tex: "grass", hasItems: [], obj: "tree2")
        var grassWithAnotherTree = GridSquare(tex: "grass", hasItems: [], obj: "tree3")
        var grassWithGrassyRock = GridSquare(tex: "grass", hasItems: [], obj: "grassyrock")
        var grassWithStonePillars = GridSquare(tex: "grass", hasItems: [], obj: "stonepillarrough")
        
        /* THIS IS A TEMPORARY GRID OF ISO SQUARES FOR DEBUGGING ONLY */
        var tempGrid = [[grassWithPsalm139Scroll, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithWood, emptyBrickSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, grassWithTree, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithStonePillars, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyBrickSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[grassWithOtherTree, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithCord],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithOtherTree, emptyGrassSquare, emptyGrassSquare, grassWithCloth],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[grassWithGrassyRock, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithAnotherTree, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare]]
        
        /* SETS UP JERUSALEM'S LOCATIONS AND BUILDINGS AND ROOMS ***UNDER CONSTRUCTION*** */
        var TheAltar = Room(ttl: "The Altar", gridSquares: [[]])
        var TheTemple = Building(ttl: "The Temple", r: [[TheAltar]])
        var SouthofTemple = Location(n:"The South Entrance to the Temple", d:"The glorious Jewish Temple, the Home of Yahweh, God of Israel", g:[[]], a:[])
        var Jerusalem = City(locations: [[SouthofTemple]])
        
        /* SETS UP BETHELEHEM'S LOCATIONS AND BUILDINGS AND ROOMS ***UNDER CONSTRUCTION***  */
        var sheep1 = Animal(name: "Sheep", desc: "A White Sheep", sheetName: "whiteSheep")
        var CaveStable = Location(n:"Cave Stable", d:"A small stable inside a cave, near an Inn", g:tempGrid, a:[sheep1]) //uses temporary grid defined above as the "Cave Stable" location where Jesus is born
        var ShepherdsFields = Location(n:"The Shepherds' Fields", d:"The fields just outside Bethelehem, where shepherds kept their flocks by night", g:[[]], a:[])
        var BethlehemSynagogueMainRoom = Room(ttl: "Bethlehem Synagogue Main Room", gridSquares: [[]])
        var BethlehemSynagogue = Building(ttl: "Bethlehem Synagogue", r:[[BethlehemSynagogueMainRoom]])
        var BethlehemSquare = Location(n:"Bethlehem Town Square", d:"Bethlehem Town Square", g:[[]], a:[])
        var Bethlehem = City(locations: [[CaveStable, ShepherdsFields, BethlehemSquare]])
        
        /* SETS THE CURRENT CITY AND LOCATION WHERE THE GAME STARTS */
        currentCity = Bethlehem
        currentLocation = CaveStable
        
        /* CITIES ARRAY AND WORLD MAP FOR WORLD TRAVEL VIEW (TO BE IMPLEMENTED LATER) */
        cities = [Jerusalem, Bethlehem]
        var worldMap = WorldMap()
        
        /* ALL BIBLE EVENTS ARE RECORDED HERE, COMING FROM THE CLASB NLT TRANSLATION, WITH A LOT OF GUESSING */
        bibleEvents = [
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 15, hr: 21, min: 0, sec: 0, ttl: "Jesus Is Born in Bethlehem", desc: "At that time the Roman emperor, Augustus, decreed that a census should be taken throughout the Roman Empire. (This was the first census taken when Quirinius was governor of Syria.) All returned to their own ancestral towns to register for this census. And because Joseph was a descendant of King David, he had to go to Bethlehem in Judea, David’s ancient home. He traveled there from the village of Nazareth in Galilee. He took with him Mary, his fiancée, who was now obviously pregnant. And while they were there, the time came for her baby to be born. She gave birth to her first child, a son. She wrapped him snugly in strips of cloth and laid him in a manger, because there was no lodging available for them.", c: Bethlehem, l: CaveStable, b: nilBuilding, r: nilRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 15, hr: 21, min: 30, sec: 0, ttl: "Shepherds Visit Jesus", desc: "That night there were shepherds staying in the fields nearby, guarding their flocks of sheep. Suddenly, an angel of the Lord appeared among them, and the radiance of the Lord’s glory surrounded them. They were terrified, but the angel reassured them. “Don’t be afraid!” he said. “I bring you good news that will bring great joy to all people. The Savior—yes, the Messiah, the Lord—has been born today in Bethlehem, the city of David! And you will recognize him by this sign: You will find a baby wrapped snugly in strips of cloth, lying in a manger.” Suddenly, the angel was joined by a vast host of others—the armies of heaven—praising God and saying, “Glory to God in highest heaven, and peace on earth to those with whom God is pleased.” When the angels had returned to heaven, the shepherds said to each other, “Let’s go to Bethlehem! Let’s see this thing that has happened, which the Lord has told us about.” They hurried to the village and found Mary and Joseph. And there was the baby, lying in the manger. After seeing him, the shepherds told everyone what had happened and what the angel had said to them about this child. All who heard the shepherds’ story were astonished, but Mary kept all these things in her heart and thought about them often. The shepherds went back to their flocks, glorifying and praising God for all they had heard and seen. It was just as the angel had told them.", c: Bethlehem, l: ShepherdsFields, b: nilBuilding, r: nilRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 23, hr: 8, min: 0, sec: 0, ttl: "Jesus is Circumcised", desc: "Eight days later, when the baby was circumcised, he was named Jesus, the name given him by the angel even before he was conceived.", c: Bethlehem, l: BethlehemSquare, b: BethlehemSynagogue, r: BethlehemSynagogueMainRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.CHESHVAN, dy: 25, hr: 8, min: 0, sec: 0, ttl: "Mary and Joseph Bring Jesus to the Temple", desc: "Then it was time for their purification offering, as required by the law of Moses after the birth of a child; so his parents took him to Jerusalem to present him to the Lord. The law of the Lord says, “If a woman’s first child is a boy, he must be dedicated to the Lord.” So they offered the sacrifice required in the law of the Lord—“either a pair of turtledoves or two young pigeons.”", c: Jerusalem, l: SouthofTemple, b: TheTemple, r: TheAltar)
                        ]
        nextEvent = 0   //start with first BibleEvent
        
    }

    /* NO LONGER USED - FOR INPUTTING DATA AT THE CONSOLE */
    /*func input() -> String {
        var keyboard = NSFileHandle.fileHandleWithStandardInput()
        var inputData = keyboard.availableData
        return NSString(data: inputData, encoding:NSUTF8StringEncoding)! as String
    }*/
    
}