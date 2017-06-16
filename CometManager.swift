//
//  CometManager.swift
//  Air Defender
//
//  Created by Rus Razvan on 29/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import Foundation
import SpriteKit


class CometManager {
    
    static let instance = CometManager()
    private init() {}
    
    var procent = 0.01
    
    var minCometSpeed = 750.0
    var maxCometSpeed = 1750.0
    
    var startingPointMinX = CGFloat(-325)
    var startingPointMaxX = CGFloat(325)
    var startingPointY = CGFloat(750)
    var endingPiontY = CGFloat(-750)
    
    var minCometSize = 25
    var maxCometSize = 50
    
    var minCometSpawnRate = 0.75
    var maxCometSpawnRate = 1.5

    func prestige() {
        minCometSpeed = 750.0
        maxCometSpeed = 1750.0
        
        var level = AbilitiesManager.instance.getAbilityLevel(abilityName: "Comets Speed Ability")
        
        for _ in 0...level-1 {
            minCometSpeed = minCometSpeed * 0.95
            maxCometSpeed = maxCometSpeed * 0.95
        }
        setMinCometSpeed(speed: minCometSpeed)
        setMaxCometSpeed(speed: maxCometSpeed)
        
        minCometSpawnRate = 0.75
        maxCometSpawnRate = 1.5
        
        level = AbilitiesManager.instance.getAbilityLevel(abilityName: "Comets Spawn Ability")
        
        for _ in 0...level-1 {
            minCometSpawnRate = minCometSpawnRate * 1.05
            maxCometSpawnRate = maxCometSpawnRate * 1.05
        }
        setMinSpawnRate(spawnRate: minCometSpawnRate)
        setMaxSpawnRate(spawnRate: maxCometSpawnRate)
    }
    
    func reset()  {
        procent = 0.01
        if getMinCometSpeed() == 0 {
            minCometSpeed = 750.0
            maxCometSpeed = 1750.0
        
            minCometSpawnRate = 0.75
            maxCometSpawnRate = 1.5
            
            setMinCometSpeed(speed: minCometSpeed)
            setMaxCometSpeed(speed: maxCometSpeed)
            
            setMinSpawnRate(spawnRate: minCometSpawnRate)
            setMaxSpawnRate(spawnRate: maxCometSpawnRate)
        }else {
            minCometSpeed = getMinCometSpeed()
            maxCometSpeed = getMaxCometSpeed()
            
            minCometSpawnRate = getMinSpawnRate()
            maxCometSpawnRate = getMaxSpawnRate()
        }
    }
    
    func getCometSpeed() -> Double {
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minCometSpeed), secoundeNoumber: CGFloat(maxCometSpeed)))
    }
    
    func getCometSize() -> Double {
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minCometSize), secoundeNoumber: CGFloat(maxCometSize)))
    }
    
    func getCometSpawnRate() -> Double {
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minCometSpawnRate), secoundeNoumber: CGFloat(maxCometSpawnRate)))
    }
    
    func spawningRateIncrese() {
        minCometSpawnRate -= minCometSpawnRate * procent
        maxCometSpawnRate -= maxCometSpawnRate * procent
    }
    
    func speedIncrese() {
        minCometSpeed += minCometSpeed * procent
        maxCometSpeed += maxCometSpeed * procent
    }
    
    
    
    //////////////////
    //Saving things///
    //////////////////
    // seting and getting comet speed
    func setMinCometSpeed(speed: Double) {
        UserDefaults.standard.set(speed, forKey: "MinCometSpeed")
    }
    func getMinCometSpeed() -> Double {
        return UserDefaults.standard.double(forKey: "MinCometSpeed")
    }
    func setMaxCometSpeed(speed: Double) {
        UserDefaults.standard.set(speed, forKey: "MaxCometSpeed")
    }
    func getMaxCometSpeed() -> Double {
        return UserDefaults.standard.double(forKey: "MaxCometSpeed")
    }
    
    
    // seting and getting comet spawn rate
    func setMinSpawnRate(spawnRate: Double) {
        UserDefaults.standard.set(spawnRate, forKey: "MinCometSpawnRate")
    }
    func getMinSpawnRate() -> Double {
        return UserDefaults.standard.double(forKey: "MinCometSpawnRate")
    }
    func setMaxSpawnRate(spawnRate: Double) {
        UserDefaults.standard.set(spawnRate, forKey: "MaxCometSpawnRate")
    }
    func getMaxSpawnRate() -> Double {
        return UserDefaults.standard.double(forKey: "MaxCometSpawnRate")
    }

    
    
}
