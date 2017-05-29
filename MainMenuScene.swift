//
//  MainMenuScene.swift
//  Air Defender
//
//  Created by Rus Razvan on 29/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        initialize()
    }
    
    
    func initialize() {
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if atPoint(touch.location(in: self)).name == "Play" {
                let scene = GameplayScene(fileNamed: "GameplayScene")
                    // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                    
                    // Present the scene
                view?.presentScene(scene)
            }
        }
    }
    
    
}
