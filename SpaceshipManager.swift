//
//  SpaceshipManager.swift
//  Air Defender
//
//  Created by Rus Razvan on 15/06/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import Foundation
import SpriteKit

class SpaceshipManager {
    static let instance = SpaceshipManager()
    private init() {}
    
    var curentX = CGFloat(0.0)
    var curentY = CGFloat(0.0)
    
    
    func getShipSpeed() -> Double {
        if getSpaceshipSpeed() > 0.0 {
            return getSpaceshipSpeed()
        }else {
            setSpaceshipSpeed(speed: 0.4)
            return getSpaceshipSpeed()
        }
    }
    
    func setSpaceshipSpeed(speed: Double) {
        UserDefaults.standard.set(speed, forKey: "ShipSpeed")
    }
    func getSpaceshipSpeed() -> Double {
        return UserDefaults.standard.double(forKey: "ShipSpeed")
    }
}
