//
//  AbilitiesManager.swift
//  Air Defender
//
//  Created by Rus Razvan on 30/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import Foundation
import SpriteKit


class AbilitiesManager {
    
    static let instance = AbilitiesManager()
    private init() {}
    
    var abilityStartCost = 50
    var abilities = [Ability]()


    // seting and getting ability points
    func setAbilityPoints(points: Int) {
        UserDefaults.standard.set(points, forKey: "AbilityPoints")
    }
    func getAbilityPoints() -> Int {
        return UserDefaults.standard.integer(forKey: "AbilityPoints")
    }
    
    // set and get ability level
    func setAbilityLevel(level: Int,abilityName: String) {
        UserDefaults.standard.set(level, forKey: abilityName)
    }
    func getAbilityLevel(abilityName: String) -> Int {
        return UserDefaults.standard.integer(forKey: abilityName)
    }
    
    
    
    
}
