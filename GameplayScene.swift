
//
//  GameplayScene.swift
//  Air Defender
//
//  Created by Rus Razvan on 15/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit
import Darwin

class GameplayScene: SKScene {
    var move = SKAction()
    var gameSpeed = 0.4
    
    var spaceShip = SKSpriteNode()
    
    var score = 0
    var scoreLabel = SKLabelNode()


    override func didMove(to view: SKView) {
        initialize()
    }


    func initialize() {
        createSpaceship()
        createLabels()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(GameplayScene.incrementScore), userInfo: nil, repeats: true)
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //spaceShip.removeAction(forKey: "ShipMove")
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // locations
            let x2 = touch.location(in: self).x
            let x1 = touch.previousLocation(in: self).x
            let y2 = touch.location(in: self).y
            let y1 = touch.previousLocation(in: self).y

            move = SKAction.moveBy(x: x2-x1, y: y2-y1, duration: TimeInterval(gameSpeed))

            spaceShip.run(move)
        }
    }
    
    func changeBackground() {
        
    }
    
    
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
        spaceShip.position = CGPoint(x: 0, y: -400)
        spaceShip.setScale(0.4)
        
        self.addChild(spaceShip)
    }
    
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
    
}





