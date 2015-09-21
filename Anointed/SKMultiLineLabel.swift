import SpriteKit

class SKMultiLineLabel: SKNode {
    
    var pixelLength : CGFloat = 0.0
    
    init( theText : String, theWidth : Int, fontsize : CGFloat) {
        
        let fontSize : CGFloat = fontsize
        
        super.init()
        
        let tmp = theText        // parse through the string and put each words into an array.
        let separators = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        let words = tmp.componentsSeparatedByCharactersInSet(separators)
        
        let len = tmp.characters.count
        let width = theWidth; // specify your own width to fit the device screen
        
        // get the number of labelnode we need.
        let totLines = len/width+1
        pixelLength = CGFloat(totLines) * CGFloat(20)
        var cnt = 0; // used to parse through the words array
        
        // here is the for loop that create all the SKLabelNode that we need to
        // display the string.
        for ( var i = 0; i < totLines; ++i ) {
            
            var lenPerLine = 0
            var lineStr = ""
            
            while lenPerLine < width {
                
                if cnt > words.count-1 {
                
                    break
                
                } else {
                    
                    lineStr = NSString(format: "%@ %@", lineStr, words[cnt]) as String
                    lenPerLine = lineStr.characters.count
                    cnt++
                    
                }
                
            }
            
            // creation of the SKLabelNode itself
            let _multiLineLabel = SKLabelNode(fontNamed: "Arial")
            _multiLineLabel.text = lineStr;
            // name each label node so you can animate it if u wish
            // the rest of the code should be self-explanatory
            _multiLineLabel.name = NSString(format: "line%d", i) as String
            _multiLineLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            _multiLineLabel.fontSize = fontSize;
            _multiLineLabel.fontColor = SKColor.whiteColor()
            let Top = -20 * CGFloat(i)
            _multiLineLabel.position = CGPointMake( self.frame.width / 2 , Top )
            self.addChild(_multiLineLabel)
            
        }
        
    }
    
    internal func highlightInColor( color: SKColor ) {
    
        for child in self.children {
            
            let label = child as! SKLabelNode
            label.fontColor = color
            
        }
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}