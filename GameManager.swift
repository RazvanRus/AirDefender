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
    
    var index = Int(0)
    var colors = [SKColor.blue, SKColor.green, SKColor.red]
    
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
    
    func setHighscore(highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: "Highscore")
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: "Highscore")
    }
    
    
}