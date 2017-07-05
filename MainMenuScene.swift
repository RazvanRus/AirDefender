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
        createAbilityPointsLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground()
    }
    
    func createAbilityPointsLabel() {
        let abilityPointsLabael = SKLabelNode()
        abilityPointsLabael.zPosition = 4
        abilityPointsLabael.position = CGPoint(x: 0, y: 450)
        abilityPointsLabael.fontSize = 100
        abilityPointsLabael.text = "Air Defender"
        
        self.addChild(abilityPointsLabael)
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
            if atPoint(touch.location(in: self)).name == "Abilities" {
                let scene = AbilitiesScene(fileNamed: "AbilitiesScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // Present the scene
                view?.presentScene(scene)
            }
            if atPoint(touch.location(in: self)).name == "Prestige" {
                if GameManager.instance.getStage() > 1 {
                    AbilitiesManager.instance.setAbilityPoints(points: AbilitiesManager.instance.getAbilityPoints() + (GameManager.instance.getStage()+1) * 100 * (GameManager.instance.getStage()+1))
                    GameManager.instance.prestige()
                    CometManager.instance.prestige()
                    SpaceshipManager.instance.prestige()
                }
            }
        }
    }
    
    func moveBackground() {
        enumerateChildNodes(withName: "BG", using: ({
            (node, error) in
            
            node.position.y -= 1;
            
            if node.position.y < -(self.frame.height) {
                node.position.y += self.frame.height * 3
            }
        }))
    }
}
