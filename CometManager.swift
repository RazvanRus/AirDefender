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
    
    var minCometSpeed = 750.0
    var maxCometSpeed = 2000.0
    
    var startingPointMinX = CGFloat(-325)
    var startingPointMaxX = CGFloat(325)
    var startingPointY = CGFloat(750)
    var endingPiontY = CGFloat(-750)
    
    var minCometSize = 20
    var maxCometSize = 50
    
    var minCometSpawnRate = 1
    var maxCometSpawnRate = 2

    func getCometSpeed() -> Double {
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minCometSpeed), secoundeNoumber: CGFloat(maxCometSpeed)))
    }
    
    func getCometSize() -> Double {
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minCometSize), secoundeNoumber: CGFloat(maxCometSize)))
    }
    
    func getCometSpawnRate() -> Double {
        return Double(GameManager.instance.randomBetweenNumbers(firstNumber: CGFloat(minCometSpawnRate), secoundeNoumber: CGFloat(maxCometSpawnRate)))
    }
    
}
