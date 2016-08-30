//
//  GameScene.swift
//  Popping Bubbles
//
//  Created by Meitar Basson on 21/08/2016.
//  Copyright (c) 2016 meitar. All rights reserved.
//


import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var background: SKSpriteNode!
    var title: SKSpriteNode!
    
    var score = 0
    var speedOfBubble: CGFloat = 2
    var bubbles = [Bubble]()
    var heartsArr = [SKSpriteNode]()
    
    var scoreLabel: SKLabelNode!
    
    var firstUpdate = false
    var secondUpdate = false
    var thirdUpdate = false
    var forthUpdate = false
    var fifthUpdate = false
    
    var countNotMatch = 0
    
    var heartToChange = 0
    
    var backToPosition = true
    
    var musicPlayer: AVAudioPlayer!

    
    
    override func didMoveToView(view: SKView) {
        playLevelMusic()
        /* Setup your scene here */
        setBackground()
        setTitle()
        setBubblesArr()
        setScoreLabel()
        setHearts()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            for x in 0...2 {
                if bubbles[x].containsPoint(location) {
                    if bubbles[x].checkIfClickCorrect() {
                        score += 1
                        bubbleSound()
                        if let high = NSUserDefaults.standardUserDefaults().valueForKey("High Score") as? Int {
                            if score > high {
                                NSUserDefaults.standardUserDefaults().setValue(score, forKey: "High Score")
                                NSUserDefaults.standardUserDefaults().synchronize()
                            }
                        } else {
                            NSUserDefaults.standardUserDefaults().setValue(score, forKey: "High Score")
                            NSUserDefaults.standardUserDefaults().synchronize()
                        }
                    
                    } else {
                        missSound()
                        heartsArr[heartToChange].texture = SKTexture(imageNamed: "Broken Heart")
                        heartToChange += 1
                    }
                    for x in 0...2 {
                        bubbles[x].label.getColor()
                        bubbles[x].setBubbleColor(bubbles[x].position.y)
                        bubbles[x].position.x = 200
                    }
                    checkForOneCorrect()
                }
            }
        }
    }
   
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        // Lose life
        if bubbles[0].position.x > 810 && backToPosition {
            missSound()
            heartsArr[heartToChange].texture = SKTexture(imageNamed: "Broken Heart")
            heartToChange += 1
            backToPosition = false
        }
        
        if bubbles[0].position.x < 300 {
            backToPosition = true
        }
        
        scoreLabel.text = "Score: \(score)"
        
        if heartToChange == heartsArr.count {
            gameOver()
        }
        
        for bubble in bubbles {
            bubble.update()
        }
        
        checkForOneCorrect()
        
        if score > 5 && !firstUpdate{
            firstUpdate = true
            speedOfBubble += 0.4
            for x in 0...bubbles.count - 1 {
                bubbles[x].removeAllActions()
                movement(speedOfBubble, x: x)
            }
        } else if score > 10 && !secondUpdate {
            secondUpdate = true
            speedOfBubble += 0.6
            for x in 0...bubbles.count - 1 {
                bubbles[x].removeAllActions()
                movement(speedOfBubble, x: x)
            }
        } else if score > 20 && !thirdUpdate {
            thirdUpdate = true
            speedOfBubble += 0.8
            for x in 0...bubbles.count - 1 {
                bubbles[x].removeAllActions()
                movement(speedOfBubble, x: x)
            }
        }else if score > 35 && !forthUpdate {
            forthUpdate = true
            speedOfBubble += 1
            for x in 0...bubbles.count - 1 {
                bubbles[x].removeAllActions()
                movement(speedOfBubble, x: x)
            }
        }else if score > 50 && !fifthUpdate {
            fifthUpdate = true
            speedOfBubble += 1.3
            for x in 0...bubbles.count - 1 {
                bubbles[x].removeAllActions()
                movement(speedOfBubble, x: x)
            }
        }
        
    }
    
    func setScoreLabel() {
        scoreLabel = SKLabelNode()
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontName = "American Typewriter"
        scoreLabel.fontSize = 32
        scoreLabel.position = CGPointMake(self.size.width / 2, self.size.height - 180)
        scoreLabel.zPosition = 3
        self.addChild(scoreLabel)
    }
    
    func setBackground() {
        background = SKSpriteNode(imageNamed: "background")
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2 )
        background.zPosition = 1
        self.addChild(background)
    }
    
    func setTitle() {
        title = SKSpriteNode(imageNamed: "title")
        title.position = CGPointMake(self.size.width / 2, self.size.height - 70)
        title.zPosition = 2
        self.addChild(title)
    }
    
    func setBubblesArr() {
        for x in 0...2 {
            bubbles.append(Bubble(yPos: 400 - CGFloat(x) * 150))
            self.addChild(bubbles[x])
        }
        checkForOneCorrect()
    }
    
    func movement(speed: CGFloat, x: Int) {
        let action = SKAction.moveByX(speed, y: 0, duration: 0.02)
        let moveAction = SKAction.repeatActionForever(action)
        bubbles[x].runAction(moveAction)
    }
    
    func setHearts() {
        for x in 0...2 {
            heartsArr.append(SKSpriteNode(imageNamed: "Heart"))
            heartsArr[x].position = CGPointMake(self.size.width / 2  + 100 - 100 * CGFloat(x), self.size.height - 240)
            heartsArr[x].size = CGSizeMake(36,30)
            heartsArr[x].zPosition = 5
            self.addChild(heartsArr[x])
        }
    }
    
    func checkForOneCorrect() {
        countNotMatch = 0
        for x in 0...bubbles.count - 1 {
            if bubbles[x].label.colorName != bubbles[x].circleColor {
                countNotMatch += 1
            }
        }
        
        // Case no match
        if countNotMatch == bubbles.count {
            let random = Int(arc4random_uniform(UInt32(bubbles.count)))
            bubbles[random].circleColor = bubbles[random].label.colorName
            bubbles[random].texture = SKTexture(imageNamed: "\(bubbles[random].label.colorName) Circle")
        }
    }
    
    
    func gameOver() {
        NSUserDefaults.standardUserDefaults().setValue(score, forKey: "lastScore")
        NSUserDefaults.standardUserDefaults().synchronize()
        let gameOver: GameOverScene = GameOverScene(size: self.size)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.0)
        gameOver.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(gameOver, transition: transition)
    }
    
    func playLevelMusic() {
        let levelMusicURL = NSBundle.mainBundle().URLForResource("gameMusic", withExtension: "aiff")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: levelMusicURL)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch {
        }
    }
    
    func bubbleSound() {
        self.runAction(SKAction.playSoundFileNamed("bubblesPop.wav", waitForCompletion: true))
    }
    
    func missSound() {
        self.runAction(SKAction.playSoundFileNamed("missSound.wav", waitForCompletion: true))
    }
    
}
