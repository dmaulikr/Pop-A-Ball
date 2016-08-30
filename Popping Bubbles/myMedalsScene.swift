//
//  myMedalsScene.swift
//  Popping Bubbles
//
//  Created by Meitar Basson on 28/08/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class myMedalsScene: SKScene {
    
    var background: SKSpriteNode!
    var homeBtn: SKSpriteNode!
    var title: SKSpriteNode!
    
    var gold: SKSpriteNode!
    var silver: SKSpriteNode!
    var bronze: SKSpriteNode!
    
    var goldLabel: SKLabelNode!
    var silverLabel: SKLabelNode!
    var bronzeLabel: SKLabelNode!
    
    
    
    override func didMoveToView(view: SKView) {
       setBack()
        setBtns()
        setTitle()
        setMedals()
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
    
    func setMedals() {
        if let score = NSUserDefaults.standardUserDefaults().valueForKey("High Score") as? Int {
            if score < 50 {
                bronze = SKSpriteNode(imageNamed: "noMedals")
                silver = SKSpriteNode(imageNamed: "noMedals")
                gold = SKSpriteNode(imageNamed: "noMedals")
                
                bronzeLabel = SKLabelNode(text: "Reach 50 points to unlock!")
                silverLabel = SKLabelNode(text: "Reach 100 points to unlock!")
                goldLabel = SKLabelNode(text: "Reach 150 points to unlock!")
            }
            if score >= 50 && score < 100 {
                
                bronze = SKSpriteNode(imageNamed: "bronze")
                silver = SKSpriteNode(imageNamed: "noMedals")
                gold = SKSpriteNode(imageNamed: "noMedals")
                
                bronzeLabel = SKLabelNode(text: "Medal Unlocked!")
                silverLabel = SKLabelNode(text: "Reach 100 points to unlock!")
                goldLabel = SKLabelNode(text: "Reach 150 points to unlock!")
            }
            if score >= 100 && score < 150 {
                silver = SKSpriteNode(imageNamed: "silver")
                gold = SKSpriteNode(imageNamed: "noMedals")
                
                bronzeLabel = SKLabelNode(text: "Medal Unlocked!")
                silverLabel = SKLabelNode(text: "Medal Unlocked!")
                goldLabel = SKLabelNode(text: "Reach 150 points to unlock!")
            }
            if score >= 150 {
                gold = SKSpriteNode(imageNamed: "gold")
                
                bronzeLabel = SKLabelNode(text: "Medal Unlocked!")
                silverLabel = SKLabelNode(text: "Medal Unlocked!")
                goldLabel = SKLabelNode(text: "Medal Unlocked!")
            }
        }
        
        bronze.position = CGPointMake(self.size.width / 2 - 150, self.size.height / 2 + 170)
        silver.position = CGPointMake(self.size.width / 2 - 150, self.size.height / 2)
        gold.position = CGPointMake(self.size.width / 2 - 150, self.size.height / 2 - 170)
        
        bronze.zPosition = 5
        silver.zPosition = 5
        gold.zPosition = 5
        
        bronze.size = CGSizeMake(bronze.size.width * 0.65, bronze.size.height * 0.65)
        silver.size = CGSizeMake(silver.size.width * 0.65, silver.size.height * 0.65)
        gold.size = CGSizeMake(gold.size.width * 0.65, gold.size.height * 0.65)
        
        bronzeLabel.position = CGPointMake(self.size.width / 2 + 50, self.size.height / 2 + 170)
        silverLabel.position = CGPointMake(self.size.width / 2 + 50, self.size.height / 2)
        goldLabel.position = CGPointMake(self.size.width / 2 + 50, self.size.height / 2 - 170)
        
        bronzeLabel.zPosition = 4
        silverLabel.zPosition = 4
        goldLabel.zPosition = 4
        
        bronzeLabel.fontSize = 22
        silverLabel.fontSize = 22
        goldLabel.fontSize = 22
        
        self.addChild(bronze)
        self.addChild(silver)
        self.addChild(gold)
        
        self.addChild(bronzeLabel)
        self.addChild(silverLabel)
        self.addChild(goldLabel)
        
        
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
