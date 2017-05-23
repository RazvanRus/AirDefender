
//
//  GameplayScene.swift
//  Air Defender
//
//  Created by Rus Razvan on 15/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
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
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("||||||||||||||||")
        print(touches)
        
        for touch in touches {
            spaceShip.position = touch.location(in: self)
        }
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





