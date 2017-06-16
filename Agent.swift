//
//  Agent.swift
//  Air Defender
//
//  Created by Rus Razvan on 15/06/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

class Agent : SKSpriteNode  {
    var move = SKAction()
    var moveToPlayer = SKAction()
    
    var endingPoint = CGFloat(AgentManager.instance.getAgentPointX())
    var agentSpeed = AgentManager.instance.agentSpeed
    
    var isGamePaused = false
    
    func initialize() {        
        createAgent()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(Agent.observe), userInfo: nil, repeats: true)
    }
    
    func observe() {
        
        verifyPosition()
        let distance = calculateDistanceToPlayer(location: self.position)

        
        if distance < 500 {
            
            self.removeAction(forKey: "MoveToPlayer")

            self.removeAction(forKey: "Move")
            if isGamePaused {
                moveToPlayer = SKAction.move(to: CGPoint(x: SpaceshipManager.instance.curentX, y: SpaceshipManager.instance.curentY), duration: (Double(distance)/(agentSpeed))*GameManager.instance.pauseMultiplier)
                self.run(moveToPlayer, withKey: "MoveToPlayer")
            } else {
                moveToPlayer = SKAction.move(to: CGPoint(x: SpaceshipManager.instance.curentX, y: SpaceshipManager.instance.curentY), duration: Double(distance)/(agentSpeed))
                self.run(moveToPlayer, withKey: "MoveToPlayer")
            }
        } else {
            removeAction(forKey: "MoveToPlayer")
            if isGamePaused {
                self.gameIsPause()
            } else {
                self.gameIsUnpaused()
            }
        }
    }
    
    func verifyPosition() {
        if self.position.y < AgentManager.instance.agentEndingPointY+1 {
            self.removeFromParent()
        }
    }
    
    func createAgent() {
    
        self.name = "Agent"
        self.color = SKColor.purple
        self.zPosition = 4
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let agentSize = AgentManager.instance.agentSize
        self.size = CGSize(width: agentSize, height: agentSize)
        self.position = CGPoint(x: CGFloat(AgentManager.instance.getAgentPointX()), y: AgentManager.instance.agentStartingPointY)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = ColliderType.Obstacle
        self.physicsBody?.collisionBitMask = ColliderType.Player | ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Player | ColliderType.Obstacle
        
        let distanceCircle = SKSpriteNode(imageNamed: "distanceCircle")
        distanceCircle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        distanceCircle.zPosition = 3
        distanceCircle.position = CGPoint(x: 0, y: 0)
        distanceCircle.size = CGSize(width: 900, height: 900)
        distanceCircle.alpha = 0.02
        self.addChild(distanceCircle)
        
        
    }
    
    func performMove() {
        isGamePaused = false
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: AgentManager.instance.agentEndingPointY), duration: Double(distance)/agentSpeed)
        self.run(move, withKey: "Move")
    }
    
    func gameIsPause() {
        isGamePaused = true
        self.removeAction(forKey: "Move")
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: AgentManager.instance.agentEndingPointY), duration: (Double(distance)/agentSpeed)*GameManager.instance.pauseMultiplier)
        self.run(move, withKey: "Move")
    }
    
    
    func gameIsUnpaused() {
        isGamePaused = false
        self.removeAction(forKey: "Move")
        let distance = calculateDistance(location: self.position)
        move = SKAction.move(to: CGPoint(x: endingPoint, y: AgentManager.instance.agentEndingPointY), duration: Double(distance)/agentSpeed)
        self.run(move, withKey: "Move")
    }
    
    
    // calculating distance between curent location and ending point location
    func calculateDistance(location: CGPoint) -> CGFloat {
        let x2 = endingPoint
        let x1 = location.x
        let y2 = CGFloat(AgentManager.instance.agentEndingPointY)
        let y1 = location.y
        
        return sqrt(pow((x2-x1), 2) + pow((y2 - y1), 2))
    }
    
    // calculating distance between curent location and player location
    func calculateDistanceToPlayer(location: CGPoint) -> CGFloat {
        let x2 = SpaceshipManager.instance.curentX
        let x1 = location.x
        let y2 = SpaceshipManager.instance.curentY
        let y1 = location.y
        
        return sqrt(pow((x2-x1), 2) + pow((y2 - y1), 2))
    }

}
