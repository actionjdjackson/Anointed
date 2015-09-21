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
    
    var bibleEvents : [BibleEvent]
    var cities : [City]
    var nextEvent : Int
    var gameDate : NSDate
    var currentCity : City
    var currentLocation : Location
    var player : GameCharacter
    var knowledgeBase : [String : Knowledge] = [:]
    var understandingBase : [String : Understanding] = [:]
    var wisdomBase : [String : Wisdom] = [:]
    var skillTree: [[Skill]]
    var miraclesTree: [Skill]
    var healingTree: [Skill]
    var wisdomTree : [Skill]
    var knowledgeTree : [Skill]
    var faithTree : [Skill]
    var discernmentTree : [Skill]
    var tonguesTree : [Skill]
    var interpretationTree : [Skill]
    var encouragementTree : [Skill]
    var serviceTree : [Skill]
    var teachingTree : [Skill]
    var givingTree : [Skill]
    var leadershipTree : [Skill]
    var mercyTree : [Skill]
    var celibacyTree : [Skill]
    var hospitalityTree : [Skill]
    var missionaryTree : [Skill]
    
    init() {
        
        /* SET UP THE KNOWLEDGE BASE OF THE GAME (knowledge, wisdom, and understanding) */
        
        let godsOmnipotence = Knowledge(ttl: "God is Omnipotent", desc: "God can do anything. He made you, so He can do whatever He wants, whenever He wants.", scrip: "Psalm 139:13-18")
        let godsOmnipresence = Knowledge(ttl: "God is Omnipresent", desc: "God is everywhere. You cannot escape Him, no matter where you go.", scrip: "Psalm 139:7-12")
        let godsOmniscience = Knowledge(ttl: "God is Omniscient", desc: "God knows everything. He knows your thoughts, your heart, and everything about you.", scrip: "Psalm 139:1-6")
        let yahwehIsGod = Knowledge(ttl: "God's Name is Yahweh", desc: "God's name is Yahweh, which means I AM THAT I AM.", scrip: "Exodus 3:14")
        
        let godForgivesSinners = Knowledge(ttl: "God Forgives Sinners", desc: "With God there is forgiveness, that He may be feared. He is not random or evil in His actions, but He desires to save.", scrip: "Psalm 130:3-4")
        
        knowledgeBase["Psalm 139:13-18"] = godsOmnipotence
        knowledgeBase["Psalm 139:7-12"] = godsOmnipresence
        knowledgeBase["Psalm 139:1-6"] = godsOmniscience
        knowledgeBase["Exodus 3:14"] = yahwehIsGod
        knowledgeBase["Psalm 130:3-4"] = godForgivesSinners
        
        let iShouldFearGod = Understanding(knowledgeElements: [godsOmnipotence, godsOmnipresence, godsOmniscience], ttl: "I should fear God", desc: "Because God is omnipotent, omnipresent, and omniscient, I should fear Him.", scrip: "Psalm 139:23-24")
        
        understandingBase["Psalm 139:23-24"] = iShouldFearGod
        
        let fearOfTheLord = Wisdom(understandingElements: [iShouldFearGod], knowledgeElements: [yahwehIsGod, godForgivesSinners], ttl: "The Fear of Yahweh", desc: "Because I know who God is (Yahweh - 'HE IS THAT HE IS') and that I should fear Him, and also that He forgives sinners, I do fear Him. This is the beginning of wisdom.", scrip: "Proverbs 9:10")
        
        wisdomBase["Proverbs 9:10"] = fearOfTheLord
        
        /* SET UP THE PLAYER CHARACTER */
        
        player = GameCharacter()    //set up a default character
        
        
        /* CREATE & ADD SKILLS & GIFTS */
        
        /* MAKE SKILLS */
        var tentmakingSkill : Tentmaking    //create tentmaking skill
        tentmakingSkill = Tentmaking(user: player)
        
        /* GIVE SOME SKILLS TO PLAYER */
        player.skills.append(tentmakingSkill)   //player (for now) has the tentmaking skill
        
        
        /* MAKE GIFT SUBSKILLS */
        var winemakingSkill : Winemaking    //create winemaking skill (will be a subset of miracles gift)
        winemakingSkill = Winemaking(user: player)
        var physicalHealingSkill : PhysicalHealing //create physical healing skill (will be a subset of healings gift)
        physicalHealingSkill = PhysicalHealing(user: player)
        var personalProphecySkill : PersonalProphecy    // etc. etc. etc.
        personalProphecySkill = PersonalProphecy(user: player)
        var wordOfKnowledgeSkill : WordOfKnowledge
        wordOfKnowledgeSkill = WordOfKnowledge(user: player)
        var wordOfWisdomSkill : WordOfWisdom
        wordOfWisdomSkill = WordOfWisdom(user: player)
        var assuranceSkill : Assurance
        assuranceSkill = Assurance(user: player)
        var originDiscernmentSkill : OriginDiscernment
        originDiscernmentSkill = OriginDiscernment(user: player)
        var prayerInTheSpiritSkill : PrayerInTheSpirit
        prayerInTheSpiritSkill = PrayerInTheSpirit(user: player)
        var interpretationSkill : Interpretation
        interpretationSkill = Interpretation(user: player)
        
        var personalEncouragementSkill : PersonalEncouragement
        personalEncouragementSkill = PersonalEncouragement(user: player)
        var servanthoodSkill : Servanthood
        servanthoodSkill = Servanthood(user: player)
        var oneOnOneTeachingSkill : OneOnOneTeaching
        oneOnOneTeachingSkill = OneOnOneTeaching(user: player)
        var cheerfulGivingSkill : CheerfulGiving
        cheerfulGivingSkill = CheerfulGiving(user: player)
        var partyLeadershipSkill : PartyLeadership
        partyLeadershipSkill = PartyLeadership(user: player)
        var feedingThePoorSkill : FeedingThePoor
        feedingThePoorSkill = FeedingThePoor(user: player)
        var celibateSkill : Celibate
        celibateSkill = Celibate(user: player)
        var hospitalitySkill : Hospitality
        hospitalitySkill = Hospitality(user: player)
        var missionarySkill : Missionary
        missionarySkill = Missionary(user: player)
        
        /* MAKE ALL THE GIFTS */
        let miraclesGift = SpiritualGift(giftName: "The Gift of Miracles", giftDesc: "A spritual gift that allows the player miraculous powers to alter nature, provide signs and wonders for unbelievers, and support the faith and confidence of believers.", giftUser: player, giftSprite: "miracles", giftSkills: [winemakingSkill])
        let prophecyGift = SpiritualGift(giftName: "The Gift of Prophecy", giftDesc: "A spiritual gift that allows the player to speak a message from God, including the ability to predict future events", giftUser: player, giftSprite: "prophecy", giftSkills: [personalProphecySkill])
        let healingsGift = SpiritualGift(giftName: "The Gifts of Healings", giftDesc: "A set of spiritual gifts for spiritual, emotional, mental, and physical healing of others or self", giftUser: player, giftSprite: "healings", giftSkills: [physicalHealingSkill])
        let wisdomGift = SpiritualGift(giftName: "The Gift of the Word of Wisdom", giftDesc: "A spiritual gift that allows the player to give a special message of wisdom into a person's life or situation", giftUser: player, giftSprite: "wisdom", giftSkills: [wordOfWisdomSkill])
        let knowledgeGift = SpiritualGift(giftName: "The Gift of the Word of Knowledge", giftDesc: "A spiritual gift that allows the player to give a special message of knowledge into a person's life for situation", giftUser: player, giftSprite: "knowledge", giftSkills: [wordOfKnowledgeSkill])
        let faithGift = SpiritualGift(giftName: "The Gift of Faith", giftDesc: "Gives the player great faith to carry out big things for God in the church, and comfort other believers & carry them", giftUser: player, giftSprite: "faith", giftSkills: [assuranceSkill])
        let discernmentGift = SpiritualGift(giftName: "The Gift of the Discerning of Spirits", giftDesc: "A spiritual gift that allows the player to discern wether a message, person, or spiritual being is from God or from Satan", giftUser: player, giftSprite: "discernment", giftSkills: [originDiscernmentSkill])
        let tonguesGift = SpiritualGift(giftName: "The Gift of Tongues", giftDesc: "Allows the player to speak in other languages he or she has never learned. Includes angelic or heavenly languages as well", giftUser: player, giftSprite: "tongues", giftSkills: [prayerInTheSpiritSkill])
        let interpretationGift = SpiritualGift(giftName: "The Gift of the Interpretation of Tongues", giftDesc: "Allows the player to interpret a language he or she has never learned. Used in conjunction with the gift of tongues in other believers", giftUser: player, giftSprite: "interpretation", giftSkills: [interpretationSkill])
        
        let encouragementGift = SpiritualGift(giftName: "The Gift of Encouragement", giftDesc: "A spiritual gift that allows the player to build up (encourage) another believer in their faith, increasing their resistance to temptation and their HG experience points.", giftUser: player, giftSprite: "encouragement", giftSkills: [personalEncouragementSkill])
        var serviceGift = SpiritualGift(giftName: "The Gift of Service", giftDesc: "A spiritual gift that gives the player an aptitude for serving others in various ways.", giftUser: player, giftSprite: "service", giftSkills: [servanthoodSkill])
        var teachingGift = SpiritualGift(giftName: "The Gift of Teaching", giftDesc: "A spiritual gift that gives the player a special ability to teach others.", giftUser: player, giftSprite: "teaching", giftSkills: [oneOnOneTeachingSkill])
        var givingGift = SpiritualGift(giftName: "The Gift of Giving", giftDesc: "A spritual gift that allows the player to have a knack for giving to others generously and appropriately according to their needs or wants.", giftUser: player, giftSprite: "giving", giftSkills: [cheerfulGivingSkill])
        var leadershipGift = SpiritualGift(giftName: "The Gift of Leadership", giftDesc: "A spiritual gift allowing the player to lead with zeal and diligence, and people naturally follow them.", giftUser: player, giftSprite: "leadership", giftSkills: [partyLeadershipSkill])
        var mercyGift = SpiritualGift(giftName: "The Gift of Mercy", giftDesc: "A spiritual gift giving the player the ability to do acts of mercy, to help others in need with cheerfulness.", giftUser: player, giftSprite: "mercy", giftSkills: [feedingThePoorSkill])
        var celibacyGift = SpiritualGift(giftName: "The Gift of Celibacy", giftDesc: "A gift that allows the player to remain unmarried and sexually abstinent that he or she may focus more deeply on serving God and others.", giftUser: player, giftSprite: "celibacy", giftSkills: [celibateSkill])
        var hospitalityGift = SpiritualGift(giftName: "The Gift of Hospitality:", giftDesc: "A gift that allows the player to invite people into his or her home for food, entertainment, and conversation, oftentimes leading to an opportunity to share the gospel.", giftUser: player, giftSprite: "hospitality", giftSkills: [hospitalitySkill])
        var missionaryGift = SpiritualGift(giftName: "The Missionary Gift", giftDesc: "A gift giving the player special abilities in traveling abroad to spread the Gospel and further the Kingdom of God", giftUser: player, giftSprite: "missionary", giftSkills: [missionarySkill])
        
        /* GIVE SOME GIFTS TO THE PLAYER */
        player.spiritualGifts.append(miraclesGift)
        player.spiritualGifts.append(prophecyGift)
        player.spiritualGifts.append(healingsGift)
        player.spiritualGifts.append(wisdomGift)
        player.spiritualGifts.append(knowledgeGift)
        player.spiritualGifts.append(faithGift)
        player.spiritualGifts.append(discernmentGift)
        player.spiritualGifts.append(tonguesGift)
        player.spiritualGifts.append(interpretationGift)
        player.spiritualGifts.append(encouragementGift)
        
        /* CREATE SKILL TREES */
        skillTree = [[tentmakingSkill]]
        miraclesTree = [winemakingSkill]
        healingTree = [physicalHealingSkill]
        wisdomTree = [wordOfWisdomSkill]
        knowledgeTree = [wordOfKnowledgeSkill]
        faithTree = [assuranceSkill]
        discernmentTree = [originDiscernmentSkill]
        tonguesTree = [prayerInTheSpiritSkill]
        interpretationTree = [interpretationSkill]
        encouragementTree = [personalEncouragementSkill]
        serviceTree = [servanthoodSkill]
        teachingTree = [oneOnOneTeachingSkill]
        givingTree = [cheerfulGivingSkill]
        leadershipTree = [partyLeadershipSkill]
        mercyTree = [feedingThePoorSkill]
        celibacyTree = [celibateSkill]
        hospitalityTree = [hospitalitySkill]
        missionaryTree = [missionarySkill]
        
        
        /* set up the initial game date as the probable day of Jesus' birth, at around 8 am */
        let hebrewCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)
        let gameDateComponents = NSDateComponents()
        gameDateComponents.year = 3755
        gameDateComponents.month = HebrewMonths.TISHRI
        gameDateComponents.day = 15
        gameDateComponents.hour = 8
        gameDateComponents.minute = 0
        gameDateComponents.second = 0
        gameDate = hebrewCalendar!.dateFromComponents(gameDateComponents)!
        
        /* sets up items for inventory of player */
        let wood2 = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, spriteName: "wood")
        let cord2 = Item(ttl: "Cord", desc: "1 Unit of Cord", sx: 1, sy: 1, spriteName: "cord")
        let cloth2 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        
        let wood3 = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, spriteName: "wood")
        let cord3 = Item(ttl: "Cord", desc: "1 Unit of Cord", sx: 1, sy: 1, spriteName: "cord")
        let cloth3 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        
        let wood4 = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, spriteName: "wood")
        let cord4 = Item(ttl: "Cord", desc: "1 Unit of Cord", sx: 1, sy: 1, spriteName: "cord")
        let cloth4 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        
        let wood5 = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, spriteName: "wood")
        let cord5 = Item(ttl: "Cord", desc: "1 Unit of Cord", sx: 1, sy: 1, spriteName: "cord")
        let cloth5 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        
        let water = Item(ttl: "Water", desc: "A skin filled with water", sx: 1, sy: 1, spriteName: "waterskin")
        
        //gives player lots of inventory items for making tents
        player.inventory.append(wood2)
        player.inventory.append(cord2)
        player.inventory.append(cloth2)
        player.inventory.append(wood3)
        player.inventory.append(cord3)
        player.inventory.append(cloth3)
        player.inventory.append(wood4)
        player.inventory.append(cord4)
        player.inventory.append(cloth4)
        player.inventory.append(wood5)
        player.inventory.append(cord5)
        player.inventory.append(cloth5)
        
        //makes all the items in the game
        let psalm139Scroll = Scroll( ttl: "Psalm 139 Scroll", desc: "A copy of the 139th Psalm, in Hebrew, originally written by King David. In fairly good condition, and fully readable. Must know how to read Hebrew to use this scroll.", textFile: "Psalm 139", lang: "Hebrew", scrollSize: 1, knowl: [godsOmniscience, godsOmnipresence, godsOmnipotence] )
        let wood1 = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, spriteName: "wood")
        let cord1 = Item(ttl: "Cord", desc: "1 Unit of Cord", sx: 1, sy: 1, spriteName: "cord")
        let cloth1 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        let cloth6 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        
        /* SETS UP ALL NPCS */
        var allNPCs : [NonPlayingCharacter] = []
        let Timothy = NonPlayingCharacter( convo: Conversation(knowledge: ["Do you know what God's name is?" : yahwehIsGod], understanding: [:], wisdom: [:], items: ["What will you take for that skin of water you're holding?" : water], info: ["Have you heard anything about Jesus of Nazareth?" : "I know that Jesus has been made Lord of all, and we saw Him resurrected a few days ago.", "What is your name?" : "My name is Timothy, servant of the Most High God."] ) )
        allNPCs.append( Timothy )
        
        /* SETS UP ALL ANIMALS */
        var allAnimals : [Animal] = []
        let sheep1 = Animal(name: "Sheep", desc: "A White Sheep", sheetName: "whiteSheep", gridLoc: CGPoint(x: random() % 30, y: random() % 30), bounds: [30, 30])
        allAnimals.append( sheep1 )
        let sheep2 = Animal(name: "Sheep", desc: "A White Sheep", sheetName: "whiteSheep", gridLoc: CGPoint(x: random() % 30, y: random() % 30), bounds: [30, 30])
        allAnimals.append( sheep2 )
        let sheep3 = Animal(name: "Sheep", desc: "A White Sheep", sheetName: "whiteSheep", gridLoc: CGPoint(x: random() % 30, y: random() % 30), bounds: [30, 30])
        allAnimals.append( sheep3 )
        let sheep4 = Animal(name: "Sheep", desc: "A White Sheep", sheetName: "whiteSheep", gridLoc: CGPoint(x: random() % 30, y: random() % 30), bounds: [30, 30])
        allAnimals.append( sheep4 )
        let sheep5 = Animal(name: "Sheep", desc: "A White Sheep", sheetName: "whiteSheep", gridLoc: CGPoint(x: random() % 30, y: random() % 30), bounds: [30, 30])
        allAnimals.append( sheep5 )
        
        //defines the different types of grid squares
        var allGridSquares : [GridSquare] = []
        var genericGridSquares : [GridSquare] = []
        var uniqueGridSquares : [GridSquare] = []
        var specialGridSquares : [GridSquare] = []
        
        let emptyGrassSquare = GridSquare(tex: "grass", hasItems: [], obj: "", npc:[], animal: [])
        allGridSquares.append(emptyGrassSquare)
        genericGridSquares.append(emptyGrassSquare)
        
        let emptyBrickSquare = GridSquare(tex: "brick", hasItems: [], obj: "", npc:[], animal: [])
        allGridSquares.append(emptyBrickSquare)
        genericGridSquares.append(emptyBrickSquare)
        
        let grassWithSheep1 = GridSquare(tex: "grass", hasItems: [], obj: "", npc: [], animal: [sheep1])
        allGridSquares.append(grassWithSheep1)
        uniqueGridSquares.append(grassWithSheep1)
        let grassWithSheep2 = GridSquare(tex: "grass", hasItems: [], obj: "", npc: [], animal: [sheep2])
        allGridSquares.append(grassWithSheep2)
        uniqueGridSquares.append(grassWithSheep2)
        let grassWithSheep3 = GridSquare(tex: "grass", hasItems: [], obj: "", npc: [], animal: [sheep3])
        allGridSquares.append(grassWithSheep3)
        uniqueGridSquares.append(grassWithSheep3)
        let grassWithSheep4 = GridSquare(tex: "grass", hasItems: [], obj: "", npc: [], animal: [sheep4])
        allGridSquares.append(grassWithSheep4)
        uniqueGridSquares.append(grassWithSheep4)
        let grassWithSheep5 = GridSquare(tex: "grass", hasItems: [], obj: "", npc: [], animal: [sheep5])
        allGridSquares.append(grassWithSheep5)
        uniqueGridSquares.append(grassWithSheep5)
        
        let grassWithTimothy = GridSquare(tex: "grass", hasItems: [], obj: "", npc: [Timothy], animal: [])
        allGridSquares.append(grassWithTimothy)
        uniqueGridSquares.append(grassWithTimothy)
        
        let grassWithWood = GridSquare(tex: "grass", hasItems: [wood1], obj: "", npc:[], animal: [])
        allGridSquares.append(grassWithWood)
        uniqueGridSquares.append(grassWithWood)
        let grassWithCord = GridSquare(tex: "grass", hasItems: [cord1], obj: "", npc:[], animal: [])
        allGridSquares.append(grassWithCord)
        uniqueGridSquares.append(grassWithCord)
        let grassWithCloth = GridSquare(tex: "grass", hasItems: [cloth1], obj: "", npc:[], animal: [])
        allGridSquares.append(grassWithCloth)
        uniqueGridSquares.append(grassWithCloth)
        let grassWithCloth2 = GridSquare(tex: "grass", hasItems: [cloth6], obj: "", npc:[], animal: [])
        allGridSquares.append(grassWithCloth2)
        uniqueGridSquares.append(grassWithCloth2)
        let grassWithPsalm139Scroll = GridSquare(tex: "grass", hasItems: [psalm139Scroll], obj: "", npc:[], animal: [])
        allGridSquares.append(grassWithPsalm139Scroll)
        uniqueGridSquares.append(grassWithPsalm139Scroll)
        
        let grassWithTree = GridSquare(tex: "grass", hasItems: [], obj: "tree", npc:[], animal: [])
        allGridSquares.append(grassWithTree)
        specialGridSquares.append(grassWithTree)
        let grassWithOtherTree = GridSquare(tex: "grass", hasItems: [], obj: "tree2", npc:[], animal: [])
        allGridSquares.append(grassWithOtherTree)
        specialGridSquares.append(grassWithOtherTree)
        let grassWithAnotherTree = GridSquare(tex: "grass", hasItems: [], obj: "tree3", npc:[], animal: [])
        allGridSquares.append(grassWithAnotherTree)
        specialGridSquares.append(grassWithAnotherTree)
        let grassWithGrassyRock = GridSquare(tex: "grass", hasItems: [], obj: "grassyrock", npc:[], animal: [])
        allGridSquares.append(grassWithGrassyRock)
        specialGridSquares.append(grassWithGrassyRock)
        let grassWithStonePillars = GridSquare(tex: "grass", hasItems: [], obj: "stonepillarrough", npc:[], animal: [])
        allGridSquares.append(grassWithStonePillars)
        specialGridSquares.append(grassWithStonePillars)
        
        let blankGrid : [[GridSquare]] = [[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare]]
        
        var tempGrid = blankGrid
        
        let time = UInt32(NSDate().timeIntervalSinceReferenceDate)
        srandom(time)
        
        for i in 0...tempGrid.count-1 {
            for j in 0...tempGrid[0].count-1 {
                
                let r = random() % 100
                if r <= 95 {
                    tempGrid[i][j] = genericGridSquares[random() % 2]
                } else if r <= 97 {
                    tempGrid[i][j] = specialGridSquares[random() % specialGridSquares.count]
                } else if r <= 100 && uniqueGridSquares.count > 0 {
                    let randomUnique = random() % uniqueGridSquares.count
                    tempGrid[i][j] = uniqueGridSquares[randomUnique]
                    uniqueGridSquares.removeAtIndex(randomUnique)
                    if tempGrid[i][j].animalList.count > 0 {
                        tempGrid[i][j].animalList[0].gridLocation.x = CGFloat(j)
                        tempGrid[i][j].animalList[0].gridLocation.y = CGFloat(i)
                    }
                    
                }
                
            }
        }
        
        /* THIS IS A TEMPORARY GRID OF ISO SQUARES FOR DEBUGGING ONLY */
        /*var tempGrid = [[grassWithPsalm139Scroll, emptyGrassSquare, grassWithCloth2, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithWood, emptyBrickSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, grassWithTree, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithStonePillars, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyBrickSquare, emptyBrickSquare, emptyGrassSquare, grassWithTimothy, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[grassWithOtherTree, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyBrickSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithCord],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithOtherTree, emptyGrassSquare, emptyGrassSquare, grassWithCloth],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[grassWithGrassyRock, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, grassWithAnotherTree, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare],[emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare, emptyGrassSquare]]*/
        
        /* SETS UP JERUSALEM'S LOCATIONS AND BUILDINGS AND ROOMS ***UNDER CONSTRUCTION*** */
        let TheAltar = Room(ttl: "The Altar", gridSquares: [[]])
        let TheTemple = Building(ttl: "The Temple", r: [[TheAltar]])
        let SouthofTemple = Location(n:"The South Entrance to the Temple", d:"The glorious Jewish Temple, the Home of Yahweh, God of Israel", g:[[]], a:[], npc:[])
        let Jerusalem = City(locations: [[SouthofTemple]])
        
        //sets up nil room and nil building as empty objects for placeholders
        let nilRoom = Room(ttl: "Default Nil Room", gridSquares: [[]])
        let nilBuilding = Building(ttl: "Default Nil Building", r: [[]])
        
        /* SETS UP BETHELEHEM'S LOCATIONS AND BUILDINGS AND ROOMS ***UNDER CONSTRUCTION***  */
        let CaveStable = Location(n:"Cave Stable", d:"A small stable inside a cave, near an Inn", g:tempGrid, a:[sheep1, sheep2, sheep3, sheep4, sheep5], npc:[Timothy]) //uses temporary grid defined above as the "Cave Stable" location where Jesus is born
        let ShepherdsFields = Location(n:"The Shepherds' Fields", d:"The fields just outside Bethelehem, where shepherds kept their flocks by night", g:[[]], a:[], npc:[])
        let BethlehemSynagogueMainRoom = Room(ttl: "Bethlehem Synagogue Main Room", gridSquares: [[]])
        let BethlehemSynagogue = Building(ttl: "Bethlehem Synagogue", r:[[BethlehemSynagogueMainRoom]])
        let BethlehemSquare = Location(n:"Bethlehem Town Square", d:"Bethlehem Town Square", g:[[]], a:[], npc:[])
        let Bethlehem = City(locations: [[CaveStable, ShepherdsFields, BethlehemSquare]])
        
        /* SETS THE CURRENT CITY AND LOCATION WHERE THE GAME STARTS */
        currentCity = Bethlehem
        currentLocation = CaveStable
        
        /* CITIES ARRAY AND WORLD MAP FOR WORLD TRAVEL VIEW (TO BE IMPLEMENTED LATER) */
        cities = [Jerusalem, Bethlehem]
        var worldMap = WorldMap()
        
        /* ALL BIBLE EVENTS ARE RECORDED HERE, COMING FROM THE CLASB NLT TRANSLATION, WITH A LOT OF GUESSING TIMEWISE */
        bibleEvents = [
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 15, hr: 21, min: 0, sec: 0, ttl: "Jesus Is Born in Bethlehem", desc: "At that time the Roman emperor, Augustus, decreed that a census should be taken throughout the Roman Empire. (This was the first census taken when Quirinius was governor of Syria.) All returned to their own ancestral towns to register for this census. And because Joseph was a descendant of King David, he had to go to Bethlehem in Judea, David’s ancient home. He traveled there from the village of Nazareth in Galilee. He took with him Mary, his fiancée, who was now obviously pregnant. And while they were there, the time came for her baby to be born. She gave birth to her first child, a son. She wrapped him snugly in strips of cloth and laid him in a manger, because there was no lodging available for them.", audioFile: "Luke2;1-7.mp3", c: Bethlehem, l: CaveStable, b: nilBuilding, r: nilRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 15, hr: 21, min: 30, sec: 0, ttl: "Shepherds Visit Jesus", desc: "That night there were shepherds staying in the fields nearby, guarding their flocks of sheep. Suddenly, an angel of the Lord appeared among them, and the radiance of the Lord’s glory surrounded them. They were terrified, but the angel reassured them. “Don’t be afraid!” he said. “I bring you good news that will bring great joy to all people. The Savior—yes, the Messiah, the Lord—has been born today in Bethlehem, the city of David! And you will recognize him by this sign: You will find a baby wrapped snugly in strips of cloth, lying in a manger.” Suddenly, the angel was joined by a vast host of others—the armies of heaven—praising God and saying, “Glory to God in highest heaven, and peace on earth to those with whom God is pleased.” When the angels had returned to heaven, the shepherds said to each other, “Let’s go to Bethlehem! Let’s see this thing that has happened, which the Lord has told us about.” They hurried to the village and found Mary and Joseph. And there was the baby, lying in the manger. After seeing him, the shepherds told everyone what had happened and what the angel had said to them about this child. All who heard the shepherds’ story were astonished, but Mary kept all these things in her heart and thought about them often. The shepherds went back to their flocks, glorifying and praising God for all they had heard and seen. It was just as the angel had told them.", audioFile: "Luke2;8-20.mp3", c: Bethlehem, l: ShepherdsFields, b: nilBuilding, r: nilRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 23, hr: 8, min: 0, sec: 0, ttl: "Jesus is Circumcised", desc: "Eight days later, when the baby was circumcised, he was named Jesus, the name given him by the angel even before he was conceived.", audioFile: "Luke2;21.mp3", c: Bethlehem, l: BethlehemSquare, b: BethlehemSynagogue, r: BethlehemSynagogueMainRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.CHESHVAN, dy: 25, hr: 8, min: 0, sec: 0, ttl: "Mary and Joseph Bring Jesus to the Temple", desc: "Then it was time for their purification offering, as required by the law of Moses after the birth of a child; so his parents took him to Jerusalem to present him to the Lord. The law of the Lord says, “If a woman’s first child is a boy, he must be dedicated to the Lord.” So they offered the sacrifice required in the law of the Lord—“either a pair of turtledoves or two young pigeons.”", audioFile: "Luke2;22-24.mp3", c: Jerusalem, l: SouthofTemple, b: TheTemple, r: TheAltar)
                        ]
        nextEvent = 0   //start with first BibleEvent
        
    }
}