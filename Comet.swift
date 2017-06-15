//
//  Comet.swift
//  Air Defender
//
//  Created by Rus Razvan on 24/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

class Comet: SKSpriteNode {
    
    var move = SKAction()
    var endingPoint = CGFloat()
    var cometSpeed = CometManager.instance.getCometSpeed()
        
    func initialize() {
        createComet()
        CometManager.instance.spawningRateIncrese()
        CometManager.instance.speedIncrese()
    }
    
    func createComet() {
        
        let startingPoint = GameManager.instance.randomBetweenNumbers(firstNumber: CometManager.instance.startingPointMinX, secoundeNoumber: CometManager.instance.startingPointMaxX)
        endingPoint = GameManager.instance.randomBetweenNumbers(firstNumber: CometManager.instance.startingPointMinX, secoundeNoumber: CometManager.instance.startingPointMaxX)

        self.name = "Comet"
        self.color = SKColor.white
        self.zPosition = 4
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let cometSize = CometManager.instance.getCometSize()
        self.size = CGSize(width: cometSize, height: cometSize)
        self.position = CGPoint(x: startingPoint, y: CometManager.instance.startingPointY)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = ColliderType.Obstacle
        self.physicsBody?.collisionBitMask = ColliderType.Player | ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Player | ColliderType.Obstacle
    }
    
    func performMove() {
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: CometManager.instance.endingPiontY), duration: Double(distance)/cometSpeed)
        self.run(move, withKey: "Move")
    }
    
    func gameIsPause() {
        self.removeAction(forKey: "Move")
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: CometManager.instance.endingPiontY), duration: (Double(distance)/cometSpeed)*GameManager.instance.pauseMultiplier)
        self.run(move, withKey: "Move")
    }
    
    
    func gameIsUnpaused() {
        self.removeAction(forKey: "Move")
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: CometManager.instance.endingPiontY), duration: Double(distance)/cometSpeed)
        self.run(move, withKey: "Move")
    }
    
    // calculating distance between curent location and ending point location
    func calculateDistance(location: CGPoint) -> CGFloat {
        let x2 = endingPoint
        let x1 = location.x
        let y2 = CGFloat(CometManager.instance.endingPiontY)
        let y1 = location.y
        
        return sqrt(pow((x2-x1), 2) + pow((y2 - y1), 2))
    }
    
    
    
    
}
