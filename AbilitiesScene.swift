//
//  AbilitiesScene.swift
//  Air Defender
//
//  Created by Rus Razvan on 30/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

class AbilitiesScene: SKScene {
    
    override func didMove(to view: SKView) {
        //self.removeAllChildren()
        //self.removeAllActions()
        initialize()
    }
    
    func initialize() {
        initializeAbilities()
        displayAbilityes()
        displayButton()
        createAbilityPointsLabel()
        //createBackground()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground()
    }
    
    func displayAbilityes() {
        var index = 0
        for ability in AbilitiesManager.instance.abilities {
            ability.name = ability.abilityName
            ability.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ability.zPosition = 3
            ability.alpha = 0.9
            ability.size = CGSize(width: 500, height: 150)
            ability.position = CGPoint(x: 0, y: (-200*index)+100)
            
            ability.createLabelsAndButton()
            
            self.addChild(ability)
            
            index += 1
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
    
    func displayButton() {
        let exitButton = SKSpriteNode(imageNamed: "exit")
        exitButton.name = "exit"
        exitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        exitButton.setScale(0.1)
        exitButton.zPosition = 3
        exitButton.position = CGPoint(x: 300, y: 600)
        
        self.addChild(exitButton)
    }
    
    func createBackground(){
        let background = SKSpriteNode(imageNamed: "Background")
        background.name = "BG"
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 0
        background.position = CGPoint(x: 0, y: 0)
        
        let background1 = SKSpriteNode(imageNamed: "Background")
        background1.name = "BG"
        background1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background1.zPosition = 0
        background1.position = CGPoint(x: 0, y: -1334)
        
        let background2 = SKSpriteNode(imageNamed: "Background")
        background2.name = "BG"
        background2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background2.zPosition = 0
        background2.position = CGPoint(x: 0, y: -2668)
        
        let backgroundAlpha = SKSpriteNode()
        backgroundAlpha.color = UIColor.black
        backgroundAlpha.name = "BGAlpha"
        backgroundAlpha.zPosition = 1
        backgroundAlpha.size = CGSize(width: 800, height: 1400)
        backgroundAlpha.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundAlpha.position = CGPoint(x: 0, y: 0)
        
        
        self.addChild(background)
        self.addChild(background1)
        self.addChild(background2)
        self.addChild(backgroundAlpha)
    }
    
    func createAbilityPointsLabel() {
        let abilityPointsLabael = SKLabelNode()
        abilityPointsLabael.zPosition = 4
        abilityPointsLabael.position = CGPoint(x: 0, y: 560)
        abilityPointsLabael.fontSize = 90
        abilityPointsLabael.text = "\(AbilitiesManager.instance.getAbilityPoints())"
        
        self.addChild(abilityPointsLabael)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if atPoint(touch.location(in: self)).name == "exit" {
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // Present the scene
                view?.presentScene(scene)
            }
            if atPoint(touch.location(in: self)).name != nil {
                let name = atPoint(touch.location(in: self)).name
                if (name!.hasPrefix("CostButton")) {
                    switch name! {
                    case "CostButtonComets Spawn Ability":
                        if checkForAbilityPoints(ability: name!) {
                            CometManager.instance.setMinSpawnRate(spawnRate: CometManager.instance.getMinSpawnRate() * 1.1)
                            CometManager.instance.setMaxSpawnRate(spawnRate: CometManager.instance.getMaxSpawnRate() * 1.1)
                            upgradeAbility(ability: name!)
                        }
                    case "CostButtonComets Speed Ability":
                        if checkForAbilityPoints(ability: name!) {
                            CometManager.instance.setMaxCometSpeed(speed: CometManager.instance.getMaxCometSpeed() * 0.90)
                            CometManager.instance.setMinCometSpeed(speed: CometManager.instance.getMinCometSpeed() * 0.90)
                            upgradeAbility(ability: name!)
                        }
                    case "CostButtonScore Speed Ability":
                        if checkForAbilityPoints(ability: name!) {
                            GameManager.instance.setScoreSpeed(speed: GameManager.instance.getScoreSpeed() * 0.90)
                            upgradeAbility(ability: name!)
                        }
                    case "CostButtonShip Speed Ability":
                        if checkForAbilityPoints(ability: name!) {
                            SpaceshipManager.instance.setSpaceshipSpeed(speed: SpaceshipManager.instance.getSpaceshipSpeed() * 0.95)
                            upgradeAbility(ability: name!)
                        }
                    default:
                        print("")
                    }
                }
            }
        }
    }
    
    
    func checkForAbilityPoints(ability : String) -> Bool {
        
        for ab in AbilitiesManager.instance.abilities {
            if ab.costButtonLabel.name == ability {
                return AbilitiesManager.instance.getAbilityPoints() >= ab.abilityCost
            }
        }
        return false
    }
    
    func upgradeAbility(ability : String) {
        for ab in AbilitiesManager.instance.abilities {
            if ab.costButtonLabel.name == ability {
                let level = AbilitiesManager.instance.getAbilityLevel(abilityName: ab.abilityName)
                AbilitiesManager.instance.setAbilityPoints(points: AbilitiesManager.instance.getAbilityPoints() - ab.abilityCost)
                AbilitiesManager.instance.setAbilityLevel(level: level+1, abilityName: ab.abilityName)
                AbilitiesManager.instance.abilities.removeAll()
//                self.removeAllActions()
//                self.removeAllChildren()
//                initialize()
                let scene = AbilitiesScene(fileNamed: "AbilitiesScene")
                scene?.scaleMode = .aspectFill
                view?.presentScene(scene)
            }
        }
    }

    
    func initializeAbilities() {
        if AbilitiesManager.instance.abilities.isEmpty {
            let spaceshipSpeedAbility = Ability(abilityName: "Ship Speed Ability", abilityLevel: 0, abilityCost: AbilitiesManager.instance.abilityStartCost)
            spaceshipSpeedAbility.abilityLevel = AbilitiesManager.instance.getAbilityLevel(abilityName: spaceshipSpeedAbility.abilityName)
            spaceshipSpeedAbility.abilityCost = calculateActualCostForAbility(abilityLevel: spaceshipSpeedAbility.abilityLevel)
            AbilitiesManager.instance.abilities.append(spaceshipSpeedAbility)
            
            
            let scoreSpeedAbility = Ability(abilityName: "Score Speed Ability", abilityLevel: 0, abilityCost: AbilitiesManager.instance.abilityStartCost)
            scoreSpeedAbility.abilityLevel = AbilitiesManager.instance.getAbilityLevel(abilityName: scoreSpeedAbility.abilityName)
            scoreSpeedAbility.abilityCost = calculateActualCostForAbility(abilityLevel: scoreSpeedAbility.abilityLevel)
            AbilitiesManager.instance.abilities.append(scoreSpeedAbility)
            
            
            let cometsSpeedAbility = Ability(abilityName: "Comets Speed Ability", abilityLevel: 0, abilityCost: AbilitiesManager.instance.abilityStartCost)
            cometsSpeedAbility.abilityLevel = AbilitiesManager.instance.getAbilityLevel(abilityName: cometsSpeedAbility.abilityName)
            cometsSpeedAbility.abilityCost = calculateActualCostForAbility(abilityLevel: cometsSpeedAbility.abilityLevel)
            AbilitiesManager.instance.abilities.append(cometsSpeedAbility)
            
            
            let cometsSpawnRateAbility = Ability(abilityName: "Comets Spawn Ability", abilityLevel: 0, abilityCost: AbilitiesManager.instance.abilityStartCost)
            cometsSpawnRateAbility.abilityLevel = AbilitiesManager.instance.getAbilityLevel(abilityName: cometsSpawnRateAbility.abilityName)
            cometsSpawnRateAbility.abilityCost = calculateActualCostForAbility(abilityLevel: cometsSpawnRateAbility.abilityLevel)
            AbilitiesManager.instance.abilities.append(cometsSpawnRateAbility)
        }

    }
    
    
    func calculateActualCostForAbility(abilityLevel: Int) -> Int {
        var costMultiplier = 1
        for _ in 0...abilityLevel {
            costMultiplier *= 2
        }
        return AbilitiesManager.instance.abilityStartCost*costMultiplier
    }
    
}
