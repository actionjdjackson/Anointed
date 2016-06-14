//
//  GameWorld.swift
//  Anointed
//
//  Created by Jacob Jackson on 3/20/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

/* THE GAME WORLD CLASS KEEPS TRACK OF ALL THE CITIES, LOCATIONS, BUILDINGS, ROOMS, THE PLAYER (GAME CHARACTER), THEIR GIFTS AND SKILLS, THE IN-GAME DATE AND TIME, AND ALL BIBLE EVENTS. IT WILL CONTAIN ALL "LEVEL" DATA AS DEFINED IN TEXT FILES OR JUST HARD-CODED INTO THIS FILE, DEPENDING ON WETHER OR NOT I WANT TO MAKE A LEVEL EDITOR, WHICH I PROBABLY WILL. ***IN PROGRESS*** */
class GameWorld {
    
    //var bibleEvents : [BibleEvent]
    var cities : [Location]
    //var nextEvent : Int
    var gameDate : NSDate
    //var currentCity : City
    var currentLocation : Location
    var player : GameCharacter
    var knowledgeBase : [String : Knowledge] = [:]
    var understandingBase : [String : Understanding] = [:]
    var wisdomBase : [String : Wisdom] = [:]
    var skillTree: [Skill]
    var miraclesTree: [Skill]
    var healingTree: [Skill]
    var wisdomTree : [Skill]
    var knowledgeTree : [Skill]
    var faithTree : [Skill]
    var discernmentTree : [Skill]
    var tonguesTree : [Skill]
    //var interpretationTree : [Skill]
    var encouragementTree : [Skill]
    var serviceTree : [Skill]
    var teachingTree : [Skill]
    var givingTree : [Skill]
    var leadershipTree : [Skill]
    var mercyTree : [Skill]
    var celibacyTree : [Skill]
    var hospitalityTree : [Skill]
    var missionaryTree : [Skill]
    var meditating : Bool
    
    init() {
        
        meditating = false
        
        /* SET UP THE PLAYER CHARACTER */
        player = GameCharacter()    //set up a default character
        
        
        /*** CREATE & ADD SKILLS & GIFTS ***/
        
        /* MAKE SKILLS & SUBSKILLS */
        
        let makeSmallTent : MakeSmallTent = MakeSmallTent(user: player)
        let makeMediumTent : MakeMediumTent = MakeMediumTent(user: player)
        let makeLargeTent : MakeLargeTent = MakeLargeTent(user: player)
        let tentmakingSkill : Tentmaking = Tentmaking(user: player, subsk: [makeSmallTent, makeMediumTent, makeLargeTent]) //make tentmaking skill
        
        let makeChair : MakeChair = MakeChair(user: player)
        let makeBench : MakeBench = MakeBench(user: player)
        let makeTable : MakeTable = MakeTable(user: player)
        let makeBoat : MakeBoat = MakeBoat(user: player)
        let carpentrySkill : Carpentry = Carpentry(user: player, subsk: [makeChair, makeBench, makeTable, makeBoat]) //make carpentry skill
        
        let philosophySkill : Philosophy = Philosophy(user: player, subsk: [])
        
        let seafaringSkill : Seafaring = Seafaring(user: player, subsk: [])
        
        let makeNet : MakeNet = MakeNet(user: player)
        let fishingSkill : Fishing = Fishing(user: player, subsk: [makeNet])
        
        let makeCampfire : MakeCampfire = MakeCampfire(user: player)
        let cookingSkill : Cooking = Cooking(user: player, subsk: [makeCampfire])
        
        let musicmakingSkill : Musicmaking = Musicmaking(user: player)
        
        let makeSash : MakeSash = MakeSash(user: player)
        let makeTunic : MakeTunic = MakeTunic(user: player)
        let makeToga : MakeToga = MakeToga(user: player)
        let makeRobe : MakeRobe = MakeRobe(user: player)
        let tailoringSkill : Tailoring = Tailoring(user: player, subsk: [makeSash, makeTunic, makeToga, makeRobe])
        
        let makeCharcoalSketch : MakeCharcoalSketch = MakeCharcoalSketch(user: player)
        let makePainting : MakePainting = MakePainting(user: player)
        let makeMosaic : MakeMosaic = MakeMosaic(user: player)
        let artmakingSkill : Artmaking = Artmaking(user: player, subsk: [makeCharcoalSketch, makePainting, makeMosaic])
        
        let makeBracelet : MakeBracelet = MakeBracelet(user: player)
        let makeNecklace : MakeNecklace = MakeNecklace(user: player)
        let makeRing : MakeRing = MakeRing(user: player)
        let makeEarring : MakeEarring = MakeEarring(user: player)
        let jewelrymakingSkill : Jewelrymaking = Jewelrymaking(user: player, subsk: [makeBracelet, makeNecklace, makeRing, makeEarring])
        
        let makePoultice : MakePoultice = MakePoultice(user: player)
        let makeTonic : MakeTonic = MakeTonic(user: player)
        let makeSplint : MakeSplint = MakeSplint(user: player)
        let medicineSkill : Medicine = Medicine(user: player, subsk: [makePoultice, makeTonic, makeSplint])
        
        let makeSpear : MakeSpear = MakeSpear(user: player)
        let makeBowAndArrow : MakeBowAndArrow = MakeBowAndArrow(user: player)
        let makeKnife : MakeKnife = MakeKnife(user: player)
        let makeShortsword : MakeShortSword = MakeShortSword(user: player)
        let weaponmakingSkill: Weaponmaking = Weaponmaking(user: player, subsk: [makeSpear, makeBowAndArrow, makeKnife, makeShortsword])
        
        let makeLockbox : MakeLockbox = MakeLockbox(user: player)
        let bankingSkill : Banking = Banking(user: player, subsk: [makeLockbox])
        
        let scribeSkill : Scribe = Scribe(user: player, subsk: [])
        
        /* GIVE SOME SKILLS TO PLAYER */
        player.skills.append(tentmakingSkill)   //player (for now) has the tentmaking skill thru the jewelrymaking skill
        player.skills.append(carpentrySkill)
        player.skills.append(medicineSkill)
        player.skills.append(weaponmakingSkill)
        player.skills.append(fishingSkill)
        player.skills.append(cookingSkill)
        player.skills.append(bankingSkill)
        player.skills.append(tailoringSkill)
        player.skills.append(artmakingSkill)
        player.skills.append(jewelrymakingSkill)
        
        /* MAKE SKILL TREE */
        skillTree = [tentmakingSkill, carpentrySkill, philosophySkill, seafaringSkill, fishingSkill, cookingSkill, musicmakingSkill, tailoringSkill, artmakingSkill, jewelrymakingSkill, medicineSkill, weaponmakingSkill, bankingSkill, scribeSkill]
        
        /* MAKE GIFT SUBSKILLS */
        var winemakingSkill : Winemaking    //create winemaking skill (will be a subset of miracles gift)
        winemakingSkill = Winemaking(user: player)
        var blindingLightSkill : BlindingLight
        blindingLightSkill = BlindingLight(user: player)
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
        //var interpretationSkill : Interpretation
        //interpretationSkill = Interpretation(user: player)
        
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
        let miraclesGift = SpiritualGift(giftName: "The Gift of Miracles", giftDesc: "A spritual gift that allows the player miraculous powers to alter nature, provide signs and wonders for unbelievers, and support the faith and confidence of believers.", giftUser: player, giftSprite: "miracles", giftSkills: [winemakingSkill, blindingLightSkill])
        let prophecyGift = SpiritualGift(giftName: "The Gift of Prophecy", giftDesc: "A spiritual gift that allows the player to speak a message from God, including the ability to predict future events", giftUser: player, giftSprite: "prophecy", giftSkills: [personalProphecySkill])
        let healingsGift = SpiritualGift(giftName: "The Gifts of Healings", giftDesc: "A set of spiritual gifts for spiritual, emotional, mental, and physical healing of others or self", giftUser: player, giftSprite: "healings", giftSkills: [physicalHealingSkill])
        let wisdomGift = SpiritualGift(giftName: "The Gift of the Word of Wisdom", giftDesc: "A spiritual gift that allows the player to give a special message of wisdom into a person's life or situation", giftUser: player, giftSprite: "wisdom", giftSkills: [wordOfWisdomSkill])
        let knowledgeGift = SpiritualGift(giftName: "The Gift of the Word of Knowledge", giftDesc: "A spiritual gift that allows the player to give a special message of knowledge into a person's life for situation", giftUser: player, giftSprite: "knowledge", giftSkills: [wordOfKnowledgeSkill])
        let faithGift = SpiritualGift(giftName: "The Gift of Faith", giftDesc: "Gives the player great faith to carry out big things for God in the church, and comfort other believers & carry them", giftUser: player, giftSprite: "faith", giftSkills: [assuranceSkill])
        let discernmentGift = SpiritualGift(giftName: "The Gift of the Discerning of Spirits", giftDesc: "A spiritual gift that allows the player to discern wether a message, person, or spiritual being is from God or from Satan", giftUser: player, giftSprite: "discernment", giftSkills: [originDiscernmentSkill])
        let tonguesGift = SpiritualGift(giftName: "The Gift of Tongues", giftDesc: "Allows the player to speak in other languages he or she has never learned. Includes angelic or heavenly languages as well", giftUser: player, giftSprite: "tongues", giftSkills: [prayerInTheSpiritSkill])
        //let interpretationGift = SpiritualGift(giftName: "The Gift of the Interpretation of Tongues", giftDesc: "Allows the player to interpret a language he or she has never learned. Used in conjunction with the gift of tongues in other believers", giftUser: player, giftSprite: "interpretation", giftSkills: [interpretationSkill])
        
        let encouragementGift = CreationalGift(giftName: "The Gift of Encouragement", giftDesc: "A spiritual gift that allows the player to build up (encourage) another believer in their faith, increasing their resistance to temptation and their HG experience points.", giftUser: player, giftSprite: "encouragement", giftSkills: [personalEncouragementSkill])
        var serviceGift = CreationalGift(giftName: "The Gift of Service", giftDesc: "A spiritual gift that gives the player an aptitude for serving others in various ways.", giftUser: player, giftSprite: "service", giftSkills: [servanthoodSkill])
        var teachingGift = CreationalGift(giftName: "The Gift of Teaching", giftDesc: "A spiritual gift that gives the player a special ability to teach others.", giftUser: player, giftSprite: "teaching", giftSkills: [oneOnOneTeachingSkill])
        var givingGift = CreationalGift(giftName: "The Gift of Giving", giftDesc: "A spritual gift that allows the player to have a knack for giving to others generously and appropriately according to their needs or wants.", giftUser: player, giftSprite: "giving", giftSkills: [cheerfulGivingSkill])
        var leadershipGift = CreationalGift(giftName: "The Gift of Leadership", giftDesc: "A spiritual gift allowing the player to lead with zeal and diligence, and people naturally follow them.", giftUser: player, giftSprite: "leadership", giftSkills: [partyLeadershipSkill])
        var mercyGift = CreationalGift(giftName: "The Gift of Mercy", giftDesc: "A spiritual gift giving the player the ability to do acts of mercy, to help others in need with cheerfulness.", giftUser: player, giftSprite: "mercy", giftSkills: [feedingThePoorSkill])
        var celibacyGift = CreationalGift(giftName: "The Gift of Celibacy", giftDesc: "A gift that allows the player to remain unmarried and sexually abstinent that he or she may focus more deeply on serving God and others.", giftUser: player, giftSprite: "celibacy", giftSkills: [celibateSkill])
        var hospitalityGift = CreationalGift(giftName: "The Gift of Hospitality:", giftDesc: "A gift that allows the player to invite people into his or her home for food, entertainment, and conversation, oftentimes leading to an opportunity to share the gospel.", giftUser: player, giftSprite: "hospitality", giftSkills: [hospitalitySkill])
        var missionaryGift = CreationalGift(giftName: "The Missionary Gift", giftDesc: "A gift giving the player special abilities in traveling abroad to spread the Gospel and further the Kingdom of God", giftUser: player, giftSprite: "missionary", giftSkills: [missionarySkill])
        
        /* GIVE SOME GIFTS TO THE PLAYER */
        player.gifts.append(miraclesGift)
        player.gifts.append(prophecyGift)
        player.gifts.append(healingsGift)
        player.gifts.append(wisdomGift)
        player.gifts.append(knowledgeGift)
        player.gifts.append(faithGift)
        player.gifts.append(discernmentGift)
        player.gifts.append(tonguesGift)
        //player.gifts.append(interpretationGift)
        player.gifts.append(encouragementGift)
        
        /* CREATE GIFT SKILL TREES */
        miraclesTree = [winemakingSkill, blindingLightSkill]
        healingTree = [physicalHealingSkill]
        wisdomTree = [wordOfWisdomSkill]
        knowledgeTree = [wordOfKnowledgeSkill]
        faithTree = [assuranceSkill]
        discernmentTree = [originDiscernmentSkill]
        tonguesTree = [prayerInTheSpiritSkill]
        //interpretationTree = [interpretationSkill]
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
        
        /* SET UP THE KNOWLEDGE BASE OF THE GAME (knowledge, wisdom, and understanding) */
        
        let godsOmnipotence = Knowledge(ttl: "God is Omnipotent", desc: "God can do anything. He made you, so He can do whatever He wants, whenever He wants.", scrip: "Psalm 139:13-18")
        let godsOmnipresence = Knowledge(ttl: "God is Omnipresent", desc: "God is everywhere. You cannot escape Him, no matter where you go.", scrip: "Psalm 139:7-12")
        let godsOmniscience = Knowledge(ttl: "God is Omniscient", desc: "God knows everything. He knows your thoughts, your heart, and everything about you.", scrip: "Psalm 139:1-6")
        let yahwehIsGod = Knowledge(ttl: "God's Name is Yahweh", desc: "God's name is Yahweh, which means I AM THAT I AM.", scrip: "Exodus 3:14")
        
        let sinnersAreGodsEnemies = Knowledge(ttl: "Sinners Are God's Enemies", desc: "David desires that God would deal with His enemies - the wicked.", scrip: "Psalm 139:19-22")
        
        let godForgivesSinners = Knowledge(ttl: "God Forgives Sinners", desc: "With God there is forgiveness, that He may be feared. He is not random or evil in His actions, but He desires to save.", scrip: "Psalm 130:3-4")
        
        knowledgeBase["Psalm 139:19-22"] = sinnersAreGodsEnemies
        knowledgeBase["Psalm 139:13-18"] = godsOmnipotence
        knowledgeBase["Psalm 139:7-12"] = godsOmnipresence
        knowledgeBase["Psalm 139:1-6"] = godsOmniscience
        knowledgeBase["Exodus 3:14"] = yahwehIsGod
        knowledgeBase["Psalm 130:3-4"] = godForgivesSinners
        
        let iShouldFearGod = Understanding(knowledgeElements: [godsOmnipotence, godsOmnipresence, godsOmniscience], ttl: "I should fear God", desc: "Because God is omnipotent, omnipresent, and omniscient, I should fear Him like David did. But do I fear Him? Do I really know Him like David did?", scrip: "Psalm 139:23-24")
        
        understandingBase["Psalm 139:23-24"] = iShouldFearGod
        
        let fearOfTheLord = Wisdom(understandingElements: [iShouldFearGod], knowledgeElements: [yahwehIsGod, godForgivesSinners], ttl: "The Fear of Yahweh", desc: "Because I know who God is (Yahweh - 'HE IS THAT HE IS') and that I should fear Him, and also that He forgives sinners, I do fear Him. This is the beginning of wisdom.", scrip: "Proverbs 9:10")
        
        wisdomBase["Proverbs 9:10"] = fearOfTheLord
        
        /* MAKES ALL THE ITEMS IN THE GAME */
        let psalm139Scroll = Scroll( ttl: "Psalm 139 Scroll", desc: "A copy of the 139th Psalm, in Hebrew, originally written by King David. In fairly good condition, and fully readable. Must know how to read Hebrew to use this scroll.", textFile: "Psalm 139", lang: "Hebrew", scrollSize: 1, knowl: [godsOmniscience, godsOmnipresence, godsOmnipotence, sinnersAreGodsEnemies], under: [iShouldFearGod], wisd: [] )
        let wood1 = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, spriteName: "wood")
        let wood6 = Item(ttl: "Wood", desc: "1 Unit of Wood", sx: 1, sy: 1, spriteName: "wood")
        let cord1 = Item(ttl: "Cord", desc: "1 Unit of Cord", sx: 1, sy: 1, spriteName: "cord")
        let cloth1 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        let cloth6 = Item(ttl: "Cloth", desc: "1 Unit of Cloth", sx: 1, sy: 1, spriteName: "cloth")
        
        /* SETS UP ALL NPCS */
        var allNPCs : [NonPlayingCharacter] = []
        let Timothy = NonPlayingCharacter( convo: Conversation(knowledge: ["Do you know what God's name is?" : yahwehIsGod], understanding: [:], wisdom: [:], items: ["What will you take for that skin of water you're holding?" : water], info: ["Have you heard anything about Jesus of Nazareth?" : "I know that Jesus has been made Lord of all, and we saw Him resurrected a few days ago.", "What is your name?" : "My name is Timothy, servant of the Most High God."] ), theQuests: [Quest(questTitle: "Go On An Adventure", desc: "A basic quest, find the Psalm 139 Scroll and study it thoroughly.", items: [psalm139Scroll], knowledge: [], understanding: [iShouldFearGod], wisdom: [], rewards: [wood6], exp: 1000, limit: -1)] )
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
        
        //let emptyDesertSquare = GridSquare(tex: "grass", hasItems: [], obj: "", npc:[], animal: [])
        //allGridSquares.append(emptyDesertSquare)
        //genericGridSquares.append(emptyDesertSquare)
        
        //let emptyBrickSquare = GridSquare(tex: "brick", hasItems: [], obj: "", npc:[], animal: [])
        //allGridSquares.append(emptyBrickSquare)
        //genericGridSquares.append(emptyBrickSquare)
        
        /* GENERIC (MOST COMMON) GRID SQUARES */
        let emptyDesertSquare = GridSquare(tex: "desert", hasItems: [], obj: "", npc: [], animal: [])
        allGridSquares.append(emptyDesertSquare)
        genericGridSquares.append(emptyDesertSquare)
        let desertWithRocks = GridSquare(tex: "desertwithrocks", hasItems: [], obj: "", npc: [], animal: [])
        allGridSquares.append(desertWithRocks)
        genericGridSquares.append(desertWithRocks)
        
        /* UNIQUE (LEAST COMMON) GRID SQUARES, ANIMALS */
        let desertWithSheep1 = GridSquare(tex: "desert", hasItems: [], obj: "", npc: [], animal: [sheep1])
        allGridSquares.append(desertWithSheep1)
        uniqueGridSquares.append(desertWithSheep1)
        let desertWithSheep2 = GridSquare(tex: "desert", hasItems: [], obj: "", npc: [], animal: [sheep2])
        allGridSquares.append(desertWithSheep2)
        uniqueGridSquares.append(desertWithSheep2)
        let desertWithSheep3 = GridSquare(tex: "desert", hasItems: [], obj: "", npc: [], animal: [sheep3])
        allGridSquares.append(desertWithSheep3)
        uniqueGridSquares.append(desertWithSheep3)
        let desertWithSheep4 = GridSquare(tex: "desert", hasItems: [], obj: "", npc: [], animal: [sheep4])
        allGridSquares.append(desertWithSheep4)
        uniqueGridSquares.append(desertWithSheep4)
        let desertWithSheep5 = GridSquare(tex: "desert", hasItems: [], obj: "", npc: [], animal: [sheep5])
        allGridSquares.append(desertWithSheep5)
        uniqueGridSquares.append(desertWithSheep5)
        
        /* UNIQUE (LEAST COMMON) GRID SQUARES, NPCs */
        let desertWithTimothy = GridSquare(tex: "desert", hasItems: [], obj: "", npc: [Timothy], animal: [])
        allGridSquares.append(desertWithTimothy)
        uniqueGridSquares.append(desertWithTimothy)
        
        /* UNIQUE (LEAST COMMON) GRID SQUARES, ITEMS */
        let desertWithWood = GridSquare(tex: "desert", hasItems: [wood1], obj: "", npc:[], animal: [])
        allGridSquares.append(desertWithWood)
        uniqueGridSquares.append(desertWithWood)
        let desertWithCord = GridSquare(tex: "desert", hasItems: [cord1], obj: "", npc:[], animal: [])
        allGridSquares.append(desertWithCord)
        uniqueGridSquares.append(desertWithCord)
        let desertWithCloth = GridSquare(tex: "desert", hasItems: [cloth1], obj: "", npc:[], animal: [])
        allGridSquares.append(desertWithCloth)
        uniqueGridSquares.append(desertWithCloth)
        let desertWithCloth2 = GridSquare(tex: "desert", hasItems: [cloth6], obj: "", npc:[], animal: [])
        allGridSquares.append(desertWithCloth2)
        uniqueGridSquares.append(desertWithCloth2)
        let desertWithPsalm139Scroll = GridSquare(tex: "desert", hasItems: [psalm139Scroll], obj: "", npc:[], animal: [])
        allGridSquares.append(desertWithPsalm139Scroll)
        uniqueGridSquares.append(desertWithPsalm139Scroll)
        
        /* SPECIAL (LESS COMMON) GRID SQUARES */
        let desertWithTree = GridSquare(tex: "desert", hasItems: [], obj: "tree", npc:[], animal: [])
        allGridSquares.append(desertWithTree)
        specialGridSquares.append(desertWithTree)
        let desertWithOtherTree = GridSquare(tex: "desert", hasItems: [], obj: "tree2", npc:[], animal: [])
        allGridSquares.append(desertWithOtherTree)
        specialGridSquares.append(desertWithOtherTree)
        let desertWithAnotherTree = GridSquare(tex: "desert", hasItems: [], obj: "tree3", npc:[], animal: [])
        allGridSquares.append(desertWithAnotherTree)
        specialGridSquares.append(desertWithAnotherTree)
        let desertWithGrassyRock = GridSquare(tex: "desert", hasItems: [], obj: "grassyrock", npc:[], animal: [])
        allGridSquares.append(desertWithGrassyRock)
        specialGridSquares.append(desertWithGrassyRock)
        let desertWithStonePillars = GridSquare(tex: "desert", hasItems: [], obj: "stonepillarrough", npc:[], animal: [])
        allGridSquares.append(desertWithStonePillars)
        specialGridSquares.append(desertWithStonePillars)
        let desertWithBush = GridSquare(tex: "desert", hasItems: [], obj: "bush", npc: [], animal: [])
        allGridSquares.append(desertWithBush)
        specialGridSquares.append(desertWithBush)
        let desertWithBush2 = GridSquare(tex: "desert", hasItems: [], obj: "bush2", npc: [], animal: [])
        allGridSquares.append(desertWithBush2)
        specialGridSquares.append(desertWithBush2)
        let desertWithSmallTent = GridSquare(tex: "desert", hasItems: [], obj: "smallTent", npc: [], animal: [])
        allGridSquares.append(desertWithSmallTent)
        specialGridSquares.append(desertWithSmallTent)
        let desertWithSmallTent2 = GridSquare(tex: "desert", hasItems: [], obj: "smallTent2", npc: [], animal: [])
        allGridSquares.append(desertWithSmallTent2)
        specialGridSquares.append(desertWithSmallTent2)
        
        /* BLANK GRID (ALL EMPTY DESERT SQUARES) */
        let blankGrid : [[GridSquare]] = [[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare],[emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare, emptyDesertSquare]]
        
        
        /* MAKE A DOUBLE OF THE GRID SQUARES AVAILABLE FOR PLACEMENT */
        var allGridSquares2 = allGridSquares
        var genericGridSquares2 = genericGridSquares
        var uniqueGridSquares2 = uniqueGridSquares
        var specialGridSquares2 = specialGridSquares
        /*************************************************************/
        
        var tempGrid = blankGrid
        /* MAKE A DOUBLE OF THE TEMP GRID */
        var tempGrid2 = blankGrid
        /**********************************/
        
        
        /* RANDOMLY DISTRIBUTE THE DIFFERENT GRID SQUARES [JERUSALEM] */
        var time = UInt32(NSDate().timeIntervalSinceReferenceDate)
        srandom(time)
        
        for i in 0...tempGrid.count-1 {
            for j in 0...tempGrid[0].count-1 {
                
                let r = random() % 100
                if r <= 93 {
                    tempGrid[i][j] = genericGridSquares[random() % genericGridSquares.count]
                } else if r <= 95 {
                    tempGrid[i][j] = specialGridSquares[random() % specialGridSquares.count]
                } else if r <= 99 && uniqueGridSquares.count > 0 {
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
        
        
        
        /* MAKE NEW LOCATION TO SWITCH TO [BETHLEHEM] (RANDOMLY DISTRIBUTE THE DIFFERENT GRID SQUARES AGAIN) */
        time = UInt32(NSDate().timeIntervalSinceReferenceDate)
        srandom(time)
        
        for i in 0...tempGrid2.count-1 {
            for j in 0...tempGrid2[0].count-1 {
                
                let r = random() % 100
                if r <= 93 {
                    tempGrid2[i][j] = genericGridSquares2[random() % genericGridSquares2.count]
                } else if r <= 95 {
                    tempGrid2[i][j] = specialGridSquares2[random() % specialGridSquares2.count]
                } /* else if r <= 100 && uniqueGridSquares2.count > 0 {
                    let randomUnique = random() % uniqueGridSquares2.count
                    tempGrid2[i][j] = uniqueGridSquares2[randomUnique]
                    uniqueGridSquares2.removeAtIndex(randomUnique)
                    if tempGrid2[i][j].animalList.count > 0 {
                        tempGrid2[i][j].animalList[0].gridLocation.x = CGFloat(j)
                        tempGrid2[i][j].animalList[0].gridLocation.y = CGFloat(i)
                    }
                    
                } */
                
            }
        }
        /**********************************/
        
        
        
        /* SETS UP JERUSALEM'S LOCATIONS AND BUILDINGS AND ROOMS ***UNDER CONSTRUCTION*** */
        //let TheAltar = Room(ttl: "The Altar", gridSquares: [[]])
        //let TheTemple = Building(ttl: "The Temple", r: [[TheAltar]])
        //let SouthofTemple = Location(n:"The South Entrance to the Temple", d:"The glorious Jewish Temple, the Home of Yahweh, God of Israel", g:[[]], a:[], npc:[])
        //let Jerusalem = City(locations: [[SouthofTemple]])
        
        //sets up nil room and nil building as empty objects for placeholders
        //let nilRoom = Room(ttl: "Default Nil Room", gridSquares: [[]])
        //let nilBuilding = Building(ttl: "Default Nil Building", r: [[]])
        
        /* SETS UP BETHELEHEM'S LOCATIONS AND BUILDINGS AND ROOMS ***UNDER CONSTRUCTION***  */
        let Jerusalem = Location(n:"Jerusalem", d:"The capital city of Judea", g:tempGrid, a:[sheep1, sheep2, sheep3, sheep4, sheep5], npc:[Timothy]) //uses temporary grid defined above as the "Cave Stable" location where Jesus is born
        let Bethlehem = Location(n:"Bethlehem", d:"The birthplace of Jesus", g:tempGrid2, a:[], npc:[])
        //let BethlehemSynagogueMainRoom = Room(ttl: "Bethlehem Synagogue Main Room", gridSquares: [[]])
        //let BethlehemSynagogue = Building(ttl: "Bethlehem Synagogue", r:[[BethlehemSynagogueMainRoom]])
        //let BethlehemSquare = Location(n:"Bethlehem Town Square", d:"Bethlehem Town Square", g:[[]], a:[], npc:[])
        //let Bethlehem = City(locations: [[CaveStable, ShepherdsFields, BethlehemSquare]])
        
        /* SETS THE CURRENT CITY AND LOCATION WHERE THE GAME STARTS */
        //currentCity = Bethlehem
        currentLocation = Jerusalem
        
        /* CITIES ARRAY AND WORLD MAP FOR WORLD TRAVEL VIEW (TO BE IMPLEMENTED LATER) */
        cities = [Jerusalem, Bethlehem]
        var worldMap = WorldMap()
        
        /* ALL BIBLE EVENTS ARE RECORDED HERE, COMING FROM THE CLASB NLT TRANSLATION, WITH A LOT OF GUESSING TIMEWISE */
        /* bibleEvents = [
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 15, hr: 21, min: 0, sec: 0, ttl: "Jesus Is Born in Bethlehem", desc: "At that time the Roman emperor, Augustus, decreed that a census should be taken throughout the Roman Empire. (This was the first census taken when Quirinius was governor of Syria.) All returned to their own ancestral towns to register for this census. And because Joseph was a descendant of King David, he had to go to Bethlehem in Judea, David’s ancient home. He traveled there from the village of Nazareth in Galilee. He took with him Mary, his fiancée, who was now obviously pregnant. And while they were there, the time came for her baby to be born. She gave birth to her first child, a son. She wrapped him snugly in strips of cloth and laid him in a manger, because there was no lodging available for them.", audioFile: "Luke2;1-7.mp3", c: Bethlehem, l: CaveStable, b: nilBuilding, r: nilRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 15, hr: 21, min: 30, sec: 0, ttl: "Shepherds Visit Jesus", desc: "That night there were shepherds staying in the fields nearby, guarding their flocks of sheep. Suddenly, an angel of the Lord appeared among them, and the radiance of the Lord’s glory surrounded them. They were terrified, but the angel reassured them. “Don’t be afraid!” he said. “I bring you good news that will bring great joy to all people. The Savior—yes, the Messiah, the Lord—has been born today in Bethlehem, the city of David! And you will recognize him by this sign: You will find a baby wrapped snugly in strips of cloth, lying in a manger.” Suddenly, the angel was joined by a vast host of others—the armies of heaven—praising God and saying, “Glory to God in highest heaven, and peace on earth to those with whom God is pleased.” When the angels had returned to heaven, the shepherds said to each other, “Let’s go to Bethlehem! Let’s see this thing that has happened, which the Lord has told us about.” They hurried to the village and found Mary and Joseph. And there was the baby, lying in the manger. After seeing him, the shepherds told everyone what had happened and what the angel had said to them about this child. All who heard the shepherds’ story were astonished, but Mary kept all these things in her heart and thought about them often. The shepherds went back to their flocks, glorifying and praising God for all they had heard and seen. It was just as the angel had told them.", audioFile: "Luke2;8-20.mp3", c: Bethlehem, l: ShepherdsFields, b: nilBuilding, r: nilRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.TISHRI, dy: 23, hr: 8, min: 0, sec: 0, ttl: "Jesus is Circumcised", desc: "Eight days later, when the baby was circumcised, he was named Jesus, the name given him by the angel even before he was conceived.", audioFile: "Luke2;21.mp3", c: Bethlehem, l: BethlehemSquare, b: BethlehemSynagogue, r: BethlehemSynagogueMainRoom),
            BibleEvent(yr: 3755, mo: HebrewMonths.CHESHVAN, dy: 25, hr: 8, min: 0, sec: 0, ttl: "Mary and Joseph Bring Jesus to the Temple", desc: "Then it was time for their purification offering, as required by the law of Moses after the birth of a child; so his parents took him to Jerusalem to present him to the Lord. The law of the Lord says, “If a woman’s first child is a boy, he must be dedicated to the Lord.” So they offered the sacrifice required in the law of the Lord—“either a pair of turtledoves or two young pigeons.”", audioFile: "Luke2;22-24.mp3", c: Jerusalem, l: SouthofTemple, b: TheTemple, r: TheAltar)
                        ]
        nextEvent = 0   //start with first BibleEvent */
        
    }
}