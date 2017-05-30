
//
//  GameplayScene.swift
//  Air Defender
//
//  Created by Rus Razvan on 15/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit
import Darwin

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    // spaceship variables
    var spaceShip = Spaceship()
    
    var noOfTouches = 0


    // game stage variables
    var isEndGame = false
    var isGamePaused = true
    var alreadyTouching = false
    
    // score variables
    var scoreTimer = Timer()
    var score = 0
    var scoreSpeed = 0.5
    var scoreLabel = SKLabelNode()
    
    // obstacles variables
    var spawnObstacleTimer = Timer()
    var comets = [Comet]()
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        initialize()
        CometManager.instance.reset()
    }

    // initialize all needed things
    func initialize() {
        physicsWorld.contactDelegate = self
        //scene?.isPaused = false
        
        createSpaceship()
        createLabels()
        
        changeBackground()
    }
    
    
    // verifying if the ship is in the screen
    func verifyShip() {
        spaceShip.verifyPosition()
    }
    
    
    func verifyComets() {
        for comet in comets {
            if comet.position.y < -749 {
                comet.removeFromParent()
            }
        }
    }
    
    
    func pauseComets() {
        for comet in comets {
            comet.gameIsPause()
        }
    }
    
    func startComet() {
        for comet in comets {
            comet.gameIsUnpaused()
        }
    }
    
    /// update frame function
    override func update(_ currentTime: TimeInterval) {
        verifyShip()
    }
    
    ///////////////////////////////
    ///////////////////////////////
    ///// Touches functions ///////
    ///////////////////////////////
    ///////////////////////////////
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        noOfTouches += 1
        if !isEndGame && !alreadyTouching {
            isGamePaused = false
            alreadyTouching = true
            
            scoreTimer.invalidate()
            scoreTimer = Timer.scheduledTimer(timeInterval: TimeInterval(scoreSpeed), target: self, selector: #selector(GameplayScene.incrementScore), userInfo: nil, repeats: true)
            
            startComet()
            
            spawnObstacleTimer.invalidate()
            spawnObstacleTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(GameplayScene.spawnObstacles), userInfo: nil, repeats: false)
            
        }else if isEndGame {
            let scene = MainMenuScene(fileNamed: "MainMenuScene")
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            
            // Present the scene
            view?.presentScene(scene)
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        noOfTouches -= 1
        if noOfTouches == 0 {
            pauseComets()
            isGamePaused = true
            alreadyTouching = false
            scoreTimer.invalidate()
            scoreTimer = Timer.scheduledTimer(timeInterval: TimeInterval(scoreSpeed*GameManager.instance.pauseMultiplier), target: self, selector: #selector(GameplayScene.incrementScore), userInfo: nil, repeats: true)
            //scene?.isPaused = true
            spawnObstacleTimer.invalidate()
            spawnObstacleTimer = Timer.scheduledTimer(timeInterval: TimeInterval(CometManager.instance.getCometSpawnRate()*GameManager.instance.pauseMultiplier), target: self, selector: #selector(GameplayScene.spawnObstacles), userInfo: nil, repeats: false)
            spaceShip.removeAllActions()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // locations
            let x2 = touch.location(in: self).x
            let x1 = touch.previousLocation(in: self).x
            let y2 = touch.location(in: self).y
            let y1 = touch.previousLocation(in: self).y

            let moveX = x2-x1
            let moveY = y2-y1
            
            spaceShip.moveBy(x: moveX,y: moveY)
        }
    }
    ///////////////////////////////
    ///////////////////////////////
    /// End Touches functions /////
    ///////////////////////////////
    ///////////////////////////////
    
    
    
    
    ///////////////////////////////
    ////// Contact Functions //////
    ///////////////////////////////
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secoundBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Spaceship" {
            firstBody = contact.bodyA
            secoundBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secoundBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Spaceship" && secoundBody.node?.name == "Comet" {
            playerHitByComet()
        }
    }
    ///////////////////////////////
    //// End Contact Functions ////
    ///////////////////////////////
    
    
    
    
    
    // changeing background color using the colors from GameManager
    func changeBackground() {
        run(SKAction.colorize(with: GameManager.instance.getColor(), colorBlendFactor: 1.0, duration: 10.0))
        
        Timer.scheduledTimer(timeInterval: TimeInterval(10.0), target: self, selector: #selector(GameplayScene.changeBackground), userInfo: nil, repeats: false)
    }

    
    // calculating distance between last location and curent location of a touch . NOT USE
    func calculateDistance(touch : UITouch) -> CGFloat {
        let x2 = touch.location(in: self).x
        let x1 = touch.previousLocation(in: self).x
        let y2 = touch.location(in: self).y
        let y1 = touch.previousLocation(in: self).y
        
        return sqrt(pow((x2-x1), 2) + pow((y2 - y1), 2))
    }
    
    
    // creating ship
    func createSpaceship() {        
        spaceShip = Spaceship(imageNamed: "Spaceship")
        spaceShip.initialize()
        self.addChild(spaceShip)
    }
    
    // creating score label
    func createLabels() {
        scoreLabel.zPosition = 4
        scoreLabel.position = CGPoint(x: 0, y: 560)
        scoreLabel.fontSize = 90
        scoreLabel.text = "\(score)"
        
        self.addChild(scoreLabel)
    
    }
    
    
    func incrementScore() {
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    
    // spawning obstacles
    func spawnObstacles() {
        let comet = Comet(imageNamed: "circle")
        comet.initialize()
        self.addChild(comet)
        if !isGamePaused {
            comet.performMove()
        }else {
            comet.gameIsPause()
        }
        comets.append(comet)
        
        // verify the comets and remove the bad ones.
        verifyComets()

        
        // calling timer for next obstacle spawn
        if isGamePaused {
            spawnObstacleTimer = Timer.scheduledTimer(timeInterval: TimeInterval(CometManager.instance.getCometSpawnRate()*GameManager.instance.pauseMultiplier), target: self, selector: #selector(GameplayScene.spawnObstacles), userInfo: nil, repeats: false)
        }else {
            spawnObstacleTimer = Timer.scheduledTimer(timeInterval: TimeInterval(CometManager.instance.getCometSpawnRate()), target: self, selector: #selector(GameplayScene.spawnObstacles), userInfo: nil, repeats: false)
        }
    }
    
    
    
    
    //// end game scenario
    
    // handeling when a comet hits the player
    func playerHitByComet() {
        
        if !isGamePaused {
            AbilitiesManager.instance.setAbilityPoints(points: AbilitiesManager.instance.getAbilityPoints() + score)
        }
        
        createEndGamePannel()
        pauseComets()
        isGamePaused = true
        scoreTimer.invalidate()
        scene?.isPaused = true
        spawnObstacleTimer.invalidate()
        spaceShip.removeAllActions()
        

        
        Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(GameplayScene.endGame), userInfo: nil, repeats: false)
    }
    
    func endGame() {
        isEndGame = true
    }
    
    // function that creates end game pannel
    func createEndGamePannel() {
        
        if GameManager.instance.getHighscore() < score {
            GameManager.instance.setHighscore(highscore: score)
        }
        
        let endGamePannel = SKSpriteNode()
        
        endGamePannel.name = "EndGamePannel"
        endGamePannel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endGamePannel.position = CGPoint(x: 0, y: 0)
        endGamePannel.size = CGSize(width: 750, height: 1334)
        endGamePannel.zPosition = 10
        endGamePannel.color = SKColor.black
        endGamePannel.alpha = 0.95
        
        
        let endGameLabel = SKLabelNode()
        endGameLabel.name = "EndGamePannelLabel"
        endGameLabel.position = CGPoint(x: 0, y: 50)
        endGameLabel.fontSize = 120
        endGameLabel.fontColor = SKColor.white
        endGameLabel.alpha = 0.8
        endGameLabel.text = "Game Over"
        endGamePannel.addChild(endGameLabel)
        
        let endGameScoreLabel = SKLabelNode()
        endGameScoreLabel.name = "EndGameScoreLabel"
        endGameScoreLabel.position = CGPoint(x: 0, y: 300)
        endGameScoreLabel.fontSize = 120
        endGameScoreLabel.fontColor = SKColor.white
        endGameScoreLabel.alpha = 0.8
        endGameScoreLabel.text = "\(score)"
        endGamePannel.addChild(endGameScoreLabel)
        
        let endGameQuitLabel = SKLabelNode()
        endGameQuitLabel.name = "EndGamePannelQuitLabel"
        endGameQuitLabel.position = CGPoint(x: 0, y: -200)
        endGameQuitLabel.fontSize = 90
        endGameQuitLabel.fontColor = SKColor.white
        endGameQuitLabel.alpha = 0.6
        endGameQuitLabel.text = "Tap to quit"
        endGamePannel.addChild(endGameQuitLabel)
        
        self.addChild(endGamePannel)
    }
    
}





