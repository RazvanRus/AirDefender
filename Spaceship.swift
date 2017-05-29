//
//  Spaceship.swift
//  Air Defender
//
//  Created by Rus Razvan on 29/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 1
    static let Obstacle: UInt32 = 2
}

class Spaceship: SKSpriteNode {
    
    var move = SKAction()
    var shipSpeed = 0.4
    
    func initialize() {
        createSpaceship()
    }
    
    
    func createSpaceship() {
        self.name = "Spaceship"
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 0, y: -100)
        self.setScale(0.4)
        self.zPosition = 5
        self.color = SKColor.white
        
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Spaceship"),
                                              size: CGSize(width: self.size.width,
                                                           height: self.size.height))
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Obstacle
        
    }
    
    // moving ship by the giving coordonates
    func moveBy(x:CGFloat, y:CGFloat) {
        move = SKAction.moveBy(x: x, y: y, duration: TimeInterval(shipSpeed))
        self.run(move)
    }
    
    // verify if the ship is still in the screen
    func verifyPosition() {
        if (self.position.x > 330) {
            self.position.x = 330
        }
        if (self.position.x < -330) {
            self.position.x = -330
        }
        if (self.position.y > 450) {
            self.position.y = 450
        }
        if (self.position.y < -550) {
            self.position.y = -550
        }
    }
    
    
}
