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
        initialize()
    }
    
    func initialize() {
        initializeAbilities()
        displayAbilityes()
    }
    
    func displayAbilityes() {
        var index = 0
        for ability in AbilitiesManager.instance.abilities {
            ability.name = ability.abilityName
            ability.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ability.zPosition = 3
            ability.size = CGSize(width: 500, height: 150)
            ability.position = CGPoint(x: 0, y: (-200*index)+100)
            
            ability.createLabelsAndButton()
            
            self.addChild(ability)
            
            index += 1
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if atPoint(touch.location(in: self)).name == "CostButton" {
                
            }
        }
    }
    
    
    func initializeAbilities() {
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
    
    
    func calculateActualCostForAbility(abilityLevel: Int) -> Int {
        var costMultiplier = 1
        for _ in 0...abilityLevel {
            costMultiplier *= 2
        }
        return AbilitiesManager.instance.abilityStartCost*costMultiplier
    }
    
}
