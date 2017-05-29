//
//  Comet.swift
//  Air Defender
//
//  Created by Rus Razvan on 24/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 1
    static let Obstacle: UInt32 = 2
}

class Comet: SKSpriteNode {
    
    var move = SKAction()
    var endingPoint = CGFloat()
    
    var cometSpeed = 1000.0
    var cometSpeedPauseMultiplyer = 10.0
    
    func initialize() {
        createComet()
        performMove()
    }
    
    func createComet() {
        
        let startingPoint = GameManager.instance.randomBetweenNumbers(firstNumber: -325, secoundeNoumber: 325)
        endingPoint = GameManager.instance.randomBetweenNumbers(firstNumber: -325, secoundeNoumber: 325)

        self.name = "Comet"
        self.color = SKColor.white
        self.zPosition = 4
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = CGSize(width: 30, height: 30)
        self.position = CGPoint(x: startingPoint, y: 750)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = ColliderType.Obstacle
        self.physicsBody?.collisionBitMask = ColliderType.Player
        self.physicsBody?.contactTestBitMask = ColliderType.Player
    }
    
    func performMove() {
        let distance = calculateDistance(location: self.position)
        print(distance)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: -750), duration: Double(distance)/cometSpeed)
        self.run(move, withKey: "Move")
    }
    
    func gameIsPause() {
        self.removeAction(forKey: "Move")
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: -750), duration: (Double(distance)/cometSpeed)*cometSpeedPauseMultiplyer)
        self.run(move, withKey: "Move")
    }
    
    
    func gameIsUnpaused() {
        self.removeAction(forKey: "Move")
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: -750), duration: Double(distance)/cometSpeed)
        self.run(move, withKey: "Move")
    }
    
    
    func calculateDistance(location: CGPoint) -> CGFloat {
        let x2 = endingPoint
        let x1 = location.x
        let y2 = CGFloat(-750)
        let y1 = location.y
        
        return sqrt(pow((x2-x1), 2) + pow((y2 - y1), 2))
    }
    
    
    
    
}
