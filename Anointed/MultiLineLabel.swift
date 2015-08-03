//
//  MultiLineLabel.swift
//  Anointed
//
//  Created by Jacob Jackson on 4/25/15.
//  Copyright (c) 2015 ThinkMac Innovations. All rights reserved.
//

import Foundation
import SpriteKit

class MultiLineLabel : SKNode {
    
    let fullText: String
    let wrapWidth: Int
    let fontSize: CGFloat
    let font: String
    
    init(text: String, fontName: String, fontsize: CGFloat, wrap: Int) {
        
        fullText = text
        wrapWidth = wrap
        font = fontName
        fontSize = fontsize
        
        super.init()
        
        var fullLength = CGFloat(count(fullText)) * fontSize    //calculates approximate pixel length of text (as one long line)
        var strLengthPerLine = Int(ceil(CGFloat(wrapWidth) / fontSize)) //calculates pixel length of each line based on wrapWidth
        var nLines = Int(ceil(fullLength / CGFloat(wrapWidth))) //calculates number of lines to use
        
        /* CUTS UP TEXT AND CREATES A MULTI-LINE LABEL. CURRENTLY HAS LOTS OF ISSUES WITH CUTTING IN THE MIDDLE OF WORDS, SHOULD FIX OR REPLACE */
        for i in 0...nLines-2 {
            var tempLabel = SKLabelNode(fontNamed: font)
            tempLabel.fontSize = fontSize
            tempLabel.text = fullText.substringWithRange(Range<String.Index>(start: advance(fullText.startIndex, i * strLengthPerLine), end: advance(fullText.endIndex, (count(fullText) - (i + 1) * strLengthPerLine) * -1)))
            tempLabel.text = tempLabel.text + "-"
            tempLabel.position.x = 0
            tempLabel.position.y = CGFloat(-1 * Int(i) * Int(fontSize + 5.0))
            self.addChild(tempLabel)
        }
        var tempLabel = SKLabelNode(fontNamed: font)
        tempLabel.fontSize = fontSize
        tempLabel.text = fullText.substringWithRange(Range<String.Index>(start: advance(fullText.startIndex, (nLines - 1) * strLengthPerLine), end: fullText.endIndex))
        tempLabel.position.x = 0
        tempLabel.position.y = CGFloat(-1 * Int(nLines - 1) * Int(fontSize + 5.0))
        self.addChild(tempLabel)
        
    }

    /* FROM APPLE. APPARENTLY NECESSARY IF I'M INHERITING FROM SKNode */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}