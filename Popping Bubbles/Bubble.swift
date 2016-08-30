//
//  Bubble.swift
//  Popping Bubbles
//
//  Created by Meitar Basson on 21/08/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class Bubble: SKSpriteNode {
    
    private var _color: String!
    private var _label: ColorLabel!
    
    private var _yPos: CGFloat = 0
    
    var circleColor: String {
        get {
            return _color
        } set {
            _color = newValue
        }
    }
    
    var label: ColorLabel {
        get {
            return _label
        } set {
            _label = newValue
        }
    }
    
    convenience init(yPos: CGFloat) {
        self.init(imageNamed: "")
        self.physicsBody?.mass = 0.1
         _yPos = yPos
        setBubbleColor(yPos)
        setLabel()
        self.addChild(_label)
        self.size = CGSizeMake(73 * 1.4, 69 * 1.4)
        self.movement(2)
    }
    
    func setBubbleColor(yPos: CGFloat) {
        if _label == nil {
            _label = ColorLabel()
        }
        let randomColor = Int(arc4random_uniform(10))
        if randomColor == 0 {
            _color = "Blue"
        } else if randomColor == 1 {
            _color = "Red"
        } else if randomColor == 2 {
            _color = "Yellow"
        } else if randomColor == 3 {
            _color = "Orange"
        } else if randomColor == 4 {
            _color = "Grey"
        } else if randomColor == 5 {
            _color = "Green"
        } else if randomColor == 6 {
            _color = "Pink"
        } else if randomColor == 7 {
            _color = "Purple"
        } else if randomColor == 8 {
            _color = "Light Blue"
        } else if randomColor == 9 {
            _color = "Brown"
        }
        
        self.texture = SKTexture(imageNamed: "\(_color) Circle")
        setBubblePosition(yPos)
    }
    
    func setBubblePosition(Y_Pos: CGFloat) {
        let x: CGFloat = 200
        self.position = CGPointMake(x, Y_Pos)
        self.zPosition = 9
    }
    
    
    func movement(speed: CGFloat) {
        let action = SKAction.moveByX(speed, y: 0, duration: 0.02)
        let moveAction = SKAction.repeatActionForever(action)
        self.runAction(moveAction)
    }
    
    func setLabel() {
        _label.setLabelPosition(0, yPos: -5)
        _label.setLabel()
    }
    
    override func update() {
        if self.position.x > 830 {
            self.removeAllChildren()
            _label.getColor()
            _label.setLabelPosition(0, yPos: -5)
            if _label.parent == nil {
              self.addChild(_label)
            }
            self.setBubbleColor(_yPos)
            self.position.x = 200
        }
    }
    
    func checkIfClickCorrect() -> Bool {
        if self.circleColor == self.label.colorName {
            return true
        }
        return false
    }
}
