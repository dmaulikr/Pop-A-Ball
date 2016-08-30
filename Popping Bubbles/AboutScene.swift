//
//  AboutScene.swift
//  Popping Bubbles
//
//  Created by Meitar Basson on 23/08/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

/// Need to add about!

class AboutScene: SKScene {
    
    var background: SKSpriteNode!
    var homeBtn: SKSpriteNode!
    var title: SKSpriteNode!
    var text: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        setBack()
        setBtns()
        setTitle()
        setText()
    }
    
    func setText() {
        text = SKSpriteNode(imageNamed: "aboutText")
        text.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        text.zPosition = 2
        self.addChild(text)
    }
    
    func setBack() {
        background = SKSpriteNode(imageNamed: "background")
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        background.zPosition = 1
        self.addChild(background)
    }
    
    func setBtns() {
        homeBtn = SKSpriteNode(imageNamed: "Home")
        homeBtn.position = CGPointMake(self.size.width / 2, 50)
        homeBtn.size = CGSize(width: 150, height: 30)
        homeBtn.zPosition = 2
        self.addChild(homeBtn)
    }
    
    func setTitle() {
        title = SKSpriteNode(imageNamed: "title")
        title.position = CGPointMake(self.size.width / 2, self.size.height - 70)
        title.zPosition = 2
        self.addChild(title)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if homeBtn.containsPoint(location) {
                goToHomeScene()
            }
        }
    }
    
    func goToHomeScene() {
        let homeScene: HomeScene = HomeScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.0)
        homeScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(homeScene, transition: transition)
    }
}
