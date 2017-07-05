//
//  MainMenuScene.swift
//  Air Defender
//
//  Created by Rus Razvan on 29/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    var inPrestigeDialog = false
    
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
        if inPrestigeDialog {
            let scene = MainMenuScene(fileNamed: "MainMenuScene")
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            
            // Present the scene
            view?.presentScene(scene)
        }
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
                    inPrestigeDialog = true
                    createPrestigeDialog()
                    AbilitiesManager.instance.setAbilityPoints(points: AbilitiesManager.instance.getAbilityPoints() + (GameManager.instance.getStage()+1) * 100 * (GameManager.instance.getStage()+1))
                    GameManager.instance.prestige()
                    CometManager.instance.prestige()
                    SpaceshipManager.instance.prestige()
                } else {
                    stageToLowDialog()
                    inPrestigeDialog = true
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
    
    func createPrestigeDialog() {
        let dialogPannel = SKSpriteNode()
        
        dialogPannel.name = "DialogPannel"
        dialogPannel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        dialogPannel.position = CGPoint(x: 0, y: 0)
        dialogPannel.size = CGSize(width: 750, height: 1334)
        dialogPannel.zPosition = 10
        dialogPannel.color = SKColor.black
        dialogPannel.alpha = 0.95
        
        
        let dialogLabel = SKLabelNode()
        dialogLabel.name = "DialogLabel"
        dialogLabel.position = CGPoint(x: 0, y: 50)
        dialogLabel.fontSize = 100
        dialogLabel.fontColor = SKColor.white
        dialogLabel.alpha = 0.8
        dialogLabel.text = "Prestige done."
        dialogPannel.addChild(dialogLabel)
        
        
        let dialogQuitLabel = SKLabelNode()
        dialogQuitLabel.name = "DialogQuitLabel"
        dialogQuitLabel.position = CGPoint(x: 0, y: -200)
        dialogQuitLabel.fontSize = 90
        dialogQuitLabel.fontColor = SKColor.white
        dialogQuitLabel.alpha = 0.6
        dialogQuitLabel.text = "Tap to exit"
        dialogPannel.addChild(dialogQuitLabel)
        
        self.addChild(dialogPannel)
    }
    
    func stageToLowDialog() {
            let dialogPannel = SKSpriteNode()
        
            dialogPannel.name = "DialogPannel"
            dialogPannel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            dialogPannel.position = CGPoint(x: 0, y: 0)
            dialogPannel.size = CGSize(width: 750, height: 1334)
            dialogPannel.zPosition = 10
            dialogPannel.color = SKColor.black
            dialogPannel.alpha = 0.95
            
            
            let dialogLabel = SKLabelNode()
            dialogLabel.name = "DialogLabel"
            dialogLabel.position = CGPoint(x: 0, y: 50)
            dialogLabel.fontSize = 100
            dialogLabel.fontColor = SKColor.white
            dialogLabel.alpha = 0.8
            dialogLabel.text = "Stage to low."
            dialogPannel.addChild(dialogLabel)
            
            
            let dialogQuitLabel = SKLabelNode()
            dialogQuitLabel.name = "DialogQuitLabel"
            dialogQuitLabel.position = CGPoint(x: 0, y: -200)
            dialogQuitLabel.fontSize = 90
            dialogQuitLabel.fontColor = SKColor.white
            dialogQuitLabel.alpha = 0.6
            dialogQuitLabel.text = "Tap to exit"
            dialogPannel.addChild(dialogQuitLabel)
            
            self.addChild(dialogPannel)
    }
}
