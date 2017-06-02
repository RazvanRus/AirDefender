//
//  Ability.swift
//  Air Defender
//
//  Created by Rus Razvan on 30/05/2017.
//  Copyright © 2017 RusRazvan. All rights reserved.
//

import SpriteKit

class Ability: SKSpriteNode {
    

    var abilityName: String
    var abilityLevel: Int
    var abilityCost: Int
    
    var nameLabel = SKLabelNode()
    var levelLabel = SKLabelNode()
    var costButton = SKSpriteNode()
    var costButtonLabel = SKLabelNode()

    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        self.abilityName = "Ability"
        self.abilityLevel = 0
        self.abilityCost = 50
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(abilityName: String = "ability", abilityLevel: Int = 0, abilityCost: Int = 50) {
        let size = CGSize(width: 100, height: 100);
        self.init(texture:nil, color: SKColor.white, size: size)
        
        self.abilityName = abilityName
        self.abilityLevel = abilityLevel
        self.abilityCost = abilityCost
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func initialize() {
        
    }
    
    func createLabelsAndButton() {
        
        self.removeAllChildren()    
        
        nameLabel = SKLabelNode()
        nameLabel.name = "NameLabel"
        nameLabel.position = CGPoint(x: -100, y: 40)
        nameLabel.zPosition = 4
        nameLabel.color = SKColor.black
        nameLabel.verticalAlignmentMode = .center
        nameLabel.horizontalAlignmentMode = .center
        nameLabel.fontSize = 30
        nameLabel.fontColor = UIColor.black
        nameLabel.text = self.abilityName
        
        self.addChild(nameLabel)

        levelLabel = SKLabelNode()
        levelLabel.name = "LevelLabel"
        levelLabel.position = CGPoint(x: -100, y: -30)
        levelLabel.zPosition = 4
        levelLabel.color = SKColor.black
        levelLabel.verticalAlignmentMode = .center
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.fontSize = 30
        levelLabel.fontColor = UIColor.black
        levelLabel.text = "Lvl: \(self.abilityLevel)"
        
        self.addChild(levelLabel)

        costButton = SKSpriteNode()
        costButton.name = "CostButton\(abilityName)"
        costButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        costButton.position = CGPoint(x: 150, y: 0)
        costButton.size = CGSize(width: 140, height: 140)
        //costButton.setScale(0.4)
        costButton.zPosition = 4
        costButton.color = SKColor.black
        
        costButtonLabel = SKLabelNode()
        costButtonLabel.name = "CostButton\(abilityName)"
        costButtonLabel.position = CGPoint(x: 0, y: 0)
        costButtonLabel.zPosition = 5
        costButtonLabel.color = SKColor.black
        costButtonLabel.verticalAlignmentMode = .center
        costButtonLabel.horizontalAlignmentMode = .center
        costButtonLabel.fontSize = 50
        costButtonLabel.fontColor = UIColor.white
        costButtonLabel.text = "\(self.abilityCost)"
        
        costButton.addChild(costButtonLabel)
        
        self.addChild(costButton)
    }
    
    
}
