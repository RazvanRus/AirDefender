//
//  AgentManager.swift
//  Air Defender
//
//  Created by Rus Razvan on 15/06/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import Foundation
import SpriteKit

class AgentManager {
    
    static let instance = AgentManager()
    private init() {}
    
    var distanceToPlayer = 450
    
    var agentSize = 50
    
    var minAgentStartingPointX = CGFloat(-300)
    var maxAgentStartingPointX = CGFloat(300)
    
    var agentStartingPointY = CGFloat(750)
    var agentEndingPointY = CGFloat(-1200)
    
    var minAgentSpawnRate = 3.0
    var maxAgentSpawnRate = 6.0
    
    var agentSpeed = 450.0
    
    func getAgentSpawnRate() -> Double{
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minAgentSpawnRate), secoundeNoumber: CGFloat(maxAgentSpawnRate)))
    }
    
    func getAgentPointX() -> Double{
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minAgentStartingPointX), secoundeNoumber: CGFloat(maxAgentStartingPointX)))
    }
    
}
