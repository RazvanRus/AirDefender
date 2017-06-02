//
//  GameManage.swift
//  Air Defender
//
//  Created by Rus Razvan on 23/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    
    static let instance = GameManager()
    private init() {}
    
    
    var pauseMultiplier = 10.0
    
    // colors for bacjground
    var index = Int(0)
    var colors = [SKColor.darkGray, SKColor.white]
    
    
    
    
    func getColor() -> SKColor {
        incrementIndex()
        return colors[index]
    }
    
    func incrementIndex() {
        if index == colors.count-1 {
            index = Int(0)
        } else {
            index += 1
        }
    }
    
    func getShipSpeed() -> Double {
        if getSpaceshipSpeed() > 0.0 {
            return getSpaceshipSpeed()
        }else {
            setSpaceshipSpeed(speed: 0.4)
            return getSpaceshipSpeed()
        }
    }
    
    func getSpeedForScore() -> Double {
        if getScoreSpeed() > 0.0 {
            return getScoreSpeed()
        }else {
            setScoreSpeed(speed: 0.5)
            return getScoreSpeed()
        }
    }
    
    
    // seting and getting highscore , saved local
    func setHighscore(highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: "Highscore")
    }
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: "Highscore")
    }

    
    func setSpaceshipSpeed(speed: Double) {
        UserDefaults.standard.set(speed, forKey: "ShipSpeed")
    }
    func getSpaceshipSpeed() -> Double {
        return UserDefaults.standard.double(forKey: "ShipSpeed")
    }
    
    func setScoreSpeed(speed: Double) {
        UserDefaults.standard.set(speed, forKey: "ScoreSpeed")
    }
    func getScoreSpeed() -> Double {
        return UserDefaults.standard.double(forKey: "ScoreSpeed")
    }
    
    
    
    // a random function between two numbers
    func randomBetweenNumbers(firstNumber: CGFloat,secoundeNoumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secoundeNoumber) + min(firstNumber, secoundeNoumber)
    }
    
}
