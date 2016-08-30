//
//  ColorLabel.swift
//  Popping Bubbles
//
//  Created by Meitar Basson on 21/08/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class ColorLabel: SKLabelNode {
    
    private var _colorName: String!
    
    var colorName: String {
        get {
            return _colorName
        } set {
            _colorName = newValue
        }
    }

    func setLabel() {
        getColor()
    }
    
    func setLabelPosition(xPos: CGFloat, yPos: CGFloat) {
        self.position = CGPointMake(xPos, yPos)
        self.zPosition = 10
    }
    
    func getColor() {
        let randomColor = Int(arc4random_uniform(10))
        if randomColor == 0 {
            _colorName = "Blue"
        } else if randomColor == 1 {
            _colorName = "Red"
        } else if randomColor == 2 {
            _colorName = "Yellow"
        } else if randomColor == 3 {
            _colorName = "Orange"
        } else if randomColor == 4 {
            _colorName = "Grey"
        } else if randomColor == 5 {
            _colorName = "Green"
        } else if randomColor == 6 {
            _colorName = "Pink"
        } else if randomColor == 7 {
            _colorName = "Purple"
        } else if randomColor == 8 {
            _colorName = "Light Blue"
        } else if randomColor == 9 {
            _colorName = "Brown"
        }
        self.fontColor = UIColor.blackColor()
        self.fontName = "Bold"
        self.fontSize = 17
        self.text = _colorName
    }
    
}
