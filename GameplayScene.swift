
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
    
    var spaceShip = SKSpriteNode()
    var move = SKAction()
    var shipSpeed = 0.4

    var isGamePaused = true
    
    var scoreTimer = Timer()
    var score = 0
    var scoreLabel = SKLabelNode()
    
    var spawnObstacleTimer = Timer()
    
    var comets = [Comet]()


    override func didMove(to view: SKView) {
        initialize()
    }


    func initialize() {
        physicsWorld.contactDelegate = self
        scene?.isPaused = false
        createSpaceship()
        createLabels()
        Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameplayScene.changeBackground), userInfo: nil, repeats: false)
    }
    
    
    func verifyShip() {
        if (spaceShip.position.x > 330) {
            spaceShip.position.x = 330
        }
        if (spaceShip.position.x < -330) {
            spaceShip.position.x = -330
        }
        if (spaceShip.position.y > 450) {
            spaceShip.position.y = 450
        }
        if (spaceShip.position.y < -550) {
            spaceShip.position.y = -550
        }
        
    }
    
    func stopComets() {
        for comet in comets {
            comet.gameIsPause()
        }
    }
    
    func startComet() {
        for comet in comets {
            comet.gameIsUnpaused()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        verifyShip()

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isGamePaused = false
        if !scoreTimer.isValid {
            scoreTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(GameplayScene.incrementScore), userInfo: nil, repeats: true)
        }
        startComet()
        scene?.isPaused = false
        if !spawnObstacleTimer.isValid {
            spawnObstacleTimer = Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.spawnObstacles), userInfo: nil, repeats: true)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopComets()
        isGamePaused = true
        scoreTimer.invalidate()
        scene?.isPaused = true
        spawnObstacleTimer.invalidate()
        spaceShip.removeAllActions()
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
            
            
            move = SKAction.moveBy(x: moveX, y: moveY, duration: TimeInterval(shipSpeed))

            spaceShip.run(move)
            
        }
    }
    
    
    
    
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
            print("dsadasda")
        }
    }
    
    
    
    func changeBackground() {
//        backgroundColor = UIColorFromRGB(rgbValue: 0x3f7589)
        run(SKAction.colorize(with: GameManager.instance.getColor(), colorBlendFactor: 1.0, duration: 10.0))
        
        Timer.scheduledTimer(timeInterval: TimeInterval(10.0), target: self, selector: #selector(GameplayScene.changeBackground), userInfo: nil, repeats: false)
    }
    
//    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
    
    
    func calculateDistance(touch : UITouch) -> CGFloat {
        let x2 = touch.location(in: self).x
        let x1 = touch.previousLocation(in: self).x
        let y2 = touch.location(in: self).y
        let y1 = touch.previousLocation(in: self).y
        
        return sqrt(pow((x2-x1), 2) + pow((y2 - y1), 2))
    }
    
    func createSpaceship() {        
        spaceShip = SKSpriteNode(imageNamed: "Spaceship")
        spaceShip.name = "Spaceship"
        spaceShip.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        spaceShip.position = CGPoint(x: 0, y: -100)
        spaceShip.setScale(0.4)
        spaceShip.zPosition = 5
        spaceShip.color = SKColor.white
        
        spaceShip.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Spaceship"),
                                                      size: CGSize(width: spaceShip.size.width,
                                                                   height: spaceShip.size.height))
        spaceShip.physicsBody?.allowsRotation = false
        spaceShip.physicsBody?.affectedByGravity = false
        
        spaceShip.physicsBody?.categoryBitMask = ColliderType.Player
        spaceShip.physicsBody?.collisionBitMask = ColliderType.Obstacle
        spaceShip.physicsBody?.contactTestBitMask = ColliderType.Obstacle
        
        self.addChild(spaceShip)
    }
    
    func createLabels() {
        scoreLabel.zPosition = 4
        scoreLabel.position = CGPoint(x: 0, y: 560)
        scoreLabel.fontSize = 90
        scoreLabel.text = "\(score)"
        scoreLabel.zPosition = 4
        
        self.addChild(scoreLabel)
    
    }
    
    
    func incrementScore() {
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    func spawnObstacles() {
        let comet = Comet(imageNamed: "circle")
        comet.initialize()
        self.addChild(comet)
        comet.performMove()
        comets.append(comet)
    }
    
    func playerHitByComet() {
        self.removeAllActions()
        self.removeAllChildren()
    }
    
}





