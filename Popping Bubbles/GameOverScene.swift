//
//  GameOverScene.swift
//  Popping Bubbles
//
//  Created by Meitar Basson on 23/08/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var background: SKSpriteNode!
    var playAgainBtn: SKSpriteNode!
    var homeBtn: SKSpriteNode!
    var gameOver: SKSpriteNode!
    var title: SKSpriteNode!
    
    var score: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        lostSound()
        NSNotificationCenter.defaultCenter().postNotificationName("showInterAdKey", object: nil)
        setBack()
        setTitle()
        setBtns()
        setScore()
        setGameOver()
    }
    
    func setBtns() {
        playAgainBtn = SKSpriteNode(imageNamed: "playAgain")
        playAgainBtn.position = CGPointMake(self.size.width / 2 , 160)
        playAgainBtn.size = CGSize(width: 150, height: 30)
        playAgainBtn.zPosition = 2
        self.addChild(playAgainBtn)
        
        homeBtn = SKSpriteNode(imageNamed: "Home")
        homeBtn.position = CGPointMake(self.size.width / 2 , 100)
        homeBtn.size = CGSize(width: 150, height: 30)
        homeBtn.zPosition = 2
        self.addChild(homeBtn)
    }
    
    func setBack() {
        background = SKSpriteNode(imageNamed: "background")
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        background.zPosition = 1
        self.addChild(background)
    }
    
    func setTitle() {
        title = SKSpriteNode(imageNamed: "title")
        title.position = CGPointMake(self.size.width / 2, self.size.height - 70)
        title.zPosition = 2
        self.addChild(title)
    }
    
    func setScore() {
        if let lScore = NSUserDefaults.standardUserDefaults().valueForKey("lastScore") {
            score = SKLabelNode(text: "Last score was: \(lScore)")
            score.position = CGPointMake(self.size.width / 2, title.position.y - 100)
            score.fontName = "Georgia-Bold"
            score.fontSize = 28
            score.zPosition = 6
            self.addChild(score)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if homeBtn.containsPoint(location) {
                goToHomeScene()
            } else if playAgainBtn.containsPoint(location) {
                playAgain()
            }
        }
    }
    
    func setGameOver() {
        gameOver = SKSpriteNode(imageNamed: "Game Over")
        gameOver.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        gameOver.zPosition = 3
        self.addChild(gameOver)
    }
    
    func goToHomeScene() {
        let homeScene: HomeScene = HomeScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.0)
        homeScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(homeScene, transition: transition)
    }
    
    func playAgain() {
        let playAgain: GameScene = GameScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.0)
        playAgain.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(playAgain, transition: transition)
    }
    
    func lostSound() {
        self.runAction(SKAction.playSoundFileNamed("lostSound.wav", waitForCompletion: true))
    }
}
