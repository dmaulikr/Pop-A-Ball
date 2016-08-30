//
//  HomeScene.swift
//  Popping Bubbles
//
//  Created by Meitar Basson on 23/08/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit


// Add Made By
//Change title
// Add Rate Here


class HomeScene: SKScene {
    
    var background: SKSpriteNode!
    var title: SKSpriteNode!
    var playBtn: SKSpriteNode!
    var about: SKSpriteNode!
    var logo: SKSpriteNode!
    
    var highScore: SKLabelNode!
    
    var clickToRate: SKSpriteNode!
    var madeBy: SKSpriteNode!
    var moreBy: SKSpriteNode!
    
    var myMedals: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        setBack()
        setTitle()
        setBtns()
        setLogo()
        setHighScore()
        setMoreBy()
        setMadeBy()
    }
    
    func setHighScore() {
        if let high = NSUserDefaults.standardUserDefaults().valueForKey("High Score") {
            highScore = SKLabelNode(text: "High Score: \(high)")
        } else {
            highScore = SKLabelNode(text: "High Score: 0")
        }
        
        highScore.position = CGPointMake(self.size.width / 2, 200)
        highScore.zPosition = 3
        highScore.fontName = "Georgia-Bold"
        highScore.fontColor = UIColor(red: 44 / 255.0, green: 117 / 255.0, blue: 184 / 255.0, alpha: 1)
        highScore.fontSize = 32
        self.addChild(highScore)
    }
    
    func setBack() {
        background = SKSpriteNode(imageNamed: "background")
        background.position = CGPointMake(self.size.width / 2 , self.size.height / 2)
        background.zPosition = 1
        self.addChild(background)
    }
    
    func setTitle() {
        title = SKSpriteNode(imageNamed: "title")
        title.position = CGPointMake(self.size.width / 2 , self.size.height - 70)
        title.zPosition = 3
        self.addChild(title)
    }
    
    func setBtns() {
        playBtn = SKSpriteNode(imageNamed: "Play Btn")
        playBtn.position = CGPointMake(self.size.width / 2 , 140)
        playBtn.size = CGSize(width: 150, height: 30)
        playBtn.zPosition = 3
        self.addChild(playBtn)
        
        myMedals = SKSpriteNode(imageNamed: "myMedals")
        myMedals.position = CGPointMake(self.size.width / 2, 90)
        myMedals.size = CGSizeMake(150, 30)
        myMedals.zPosition = 3
        self.addChild(myMedals)
        
        about = SKSpriteNode(imageNamed: "About")
        about.position = CGPointMake(self.size.width / 2 , 40)
        about.size = CGSize(width: 150, height: 30)
        about.zPosition = 3
        self.addChild(about)
        
        clickToRate = SKSpriteNode(imageNamed: "Rate")
        clickToRate.position = CGPointMake(self.size.width / 2, self.size.height - 215)
        clickToRate.size = CGSizeMake(clickToRate.size.width * 0.8, clickToRate.size.height * 0.8)
        clickToRate.zPosition = 3
        self.addChild(clickToRate)
    }
    
    func setMoreBy() {
        moreBy = SKSpriteNode(imageNamed: "More")
        moreBy.position = CGPointMake(self.size.width / 2, self.size.height - 170)
        moreBy.zPosition = 3
        self.addChild(moreBy)
    }
    
    func setLogo() {
        logo = SKSpriteNode(imageNamed: "Logo")
        logo.position = CGPointMake(self.size.width / 2, self.size.height / 2 - 30)
        logo.zPosition = 3
        self.addChild(logo)
    }
    
    func setMadeBy() {
        madeBy = SKSpriteNode(imageNamed: "madeBy")
        madeBy.position = CGPointMake(self.size.width / 2 , self.size.height - 260)
        madeBy.size = CGSizeMake(madeBy.size.width * 0.65, madeBy.size.height * 0.65)
        madeBy.zPosition = 3
        self.addChild(madeBy)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if playBtn.containsPoint(location) {
                goToGameScene()
            } else if about.containsPoint(location) {
                goToAboutScene()
            } else if clickToRate.containsPoint(location) {
                rateBtnPressed()
            } else if moreBy.containsPoint(location) {
                moreByPressed()
            } else if myMedals.containsPoint(location) {
                goToMyMedalsScene()
            }
        }
    }
    
  
    func goToGameScene() {
        let gameScene: GameScene = GameScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.0)
        gameScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    func goToAboutScene() {
        let aboutScene: AboutScene = AboutScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.0)
        aboutScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(aboutScene, transition: transition)
    }
    
    func goToMyMedalsScene() {
        let medalsScene: myMedalsScene = myMedalsScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.0)
        medalsScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(medalsScene, transition: transition)
    }
    
    func rateBtnPressed() {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/app/id1146921207")!)
    }
    
    func moreByPressed() {
         UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/developer/meitar-basson/id1129766345")!)
    }
    
    
}
