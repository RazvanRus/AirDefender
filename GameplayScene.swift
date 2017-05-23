
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
        Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameplayScene.changeBackground), userInfo: nil, repeats: false)
        
    }
    
    
    func verifyShip() {
        if (spaceShip.position.x > 330) {
            spaceShip.position.x = 330
        }
        if (spaceShip.position.x < -330) {
            spaceShip.position.x = -330
        }
        if (spaceShip.position.y > 500) {
            spaceShip.position.y = 500
        }
        if (spaceShip.position.y < -600) {
            spaceShip.position.y = -600
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        verifyShip()

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

            let moveX = x2-x1
            let moveY = y2-y1
//
//            print(abs(spaceShip.position.x + moveX))
//            if (abs(spaceShip.position.x + moveX) > 330) {
//                moveX = 0
//            }
//            
//            if (abs(spaceShip.position.y + moveY) > 610) {
//                moveY = 0
//            }
            
            move = SKAction.moveBy(x: moveX, y: moveY, duration: TimeInterval(gameSpeed))

            spaceShip.run(move)
            
        }
    }
    
    func changeBackground() {
//        backgroundColor = UIColorFromRGB(rgbValue: 0x3f7589)
        run(SKAction.colorize(with: GameManager.instance.getColor(), colorBlendFactor: 1.0, duration: 3.0))
        
        Timer.scheduledTimer(timeInterval: TimeInterval(3.0), target: self, selector: #selector(GameplayScene.changeBackground), userInfo: nil, repeats: false)
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
        spaceShip.position = CGPoint(x: 0, y: -400)
        spaceShip.setScale(0.4)
        spaceShip.zPosition = 5
        
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
    
}





