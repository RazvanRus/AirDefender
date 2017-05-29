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
    
    
    func initialize() {
        createComet()
        performMove()
    }
    
    func createComet() {
        
        let startingPoint = GameManager.instance.randomBetweenNumbers(firstNumber: -400, secoundeNoumber: 400)
        endingPoint = GameManager.instance.randomBetweenNumbers(firstNumber: -400, secoundeNoumber: 400)

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
        move = SKAction.move(to: CGPoint(x: endingPoint, y: -750), duration: 2)
        self.run(move, withKey: "Move")
    }
    
    func gameIsPause() {
        self.removeAction(forKey: "Move")
        move = SKAction.move(to: CGPoint(x: endingPoint, y: -750), duration: 5)
        self.run(move, withKey: "Move")
        print("#############")
    }
    
    
    func gameIsUnpaused() {
        self.removeAction(forKey: "Move")
        move = SKAction.move(to: CGPoint(x: endingPoint, y: -750), duration: 1)
        self.run(move, withKey: "Move")
        print("$$$$$$$$$$")
    }
    
    
    
    
    
}
