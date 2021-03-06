//
//  AppDelegate.swift
//  Anointed The Game
//
//  Created by Jacob Jackson on 3/28/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//


import Cocoa
import SpriteKit

/* THIS CODE IS FROM APPLE, I DON'T KNOW WHAT IT'S ALL ABOUT BUT IT'S LOADING STUFF I GUESS */
extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

extension SKView {
    
    override public func rightMouseDown(theEvent: NSEvent) {
    
        self.scene!.rightMouseDown( theEvent )
    
    }
    
}

/* DOES ALL THE FANCY MAC APP STUFF */
@NSApplicationMain

/* SETS UP THE APP DELEGATE, AGAIN, FROM APPLE AND I DON'T KNOW WHAT IT'S ALL ABOUT EITHER */
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        window.toggleFullScreen(self)
        /* Pick a size for the scene */
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            
            UNIVERSE.theScene = scene
            
            self.skView!.presentScene(scene)    //show me the game!
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            //self.skView!.ignoresSiblingOrder = true   //commented out because the tiles didn't fit together right
            
            /* FOR TESTING AND DEBUGGING - THIS SHOWS FPS AND NODE COUNT IN THE LOWER RIGHT OF THE SCREEN */
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true
            
        }
    }
    
    /* CLOSE THE APP IF YOU CLOSE THE MAIN WINDOW */
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
