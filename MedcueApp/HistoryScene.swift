//
//  GameScene.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/2/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import SpriteKit
import GameplayKit

class HistoryScene: SKScene {
 
    let title = "A"
    let weeks = "40"
    let birth = "C-section"
    let weight = "3.5"
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 750, height: 112)
        logoLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        self.addChild(logoLabel)
        
        let scenarioLabel = SKLabelNode(fontNamed: "Arial")
        scenarioLabel.text = "Scenario: \(title)"
        scenarioLabel.fontSize = 190
        scenarioLabel.fontColor = SKColor.white
        scenarioLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.65)
        self.addChild(scenarioLabel)
        
        let weeksLabel = SKLabelNode(fontNamed: "Arial")
        weeksLabel.text = "\(weeks) weeks"
        weeksLabel.fontSize = 150
        weeksLabel.fontColor = SKColor.white
        weeksLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        self.addChild(weeksLabel)
        
        let birthType = SKLabelNode(fontNamed: "Arial")
        birthType.text = "\(birth)"
        birthType.fontSize = 150
        birthType.fontColor = SKColor.white
        birthType.position = CGPoint(x: self.size.width/2, y: self.size.height*0.465)
        self.addChild(birthType)
        
        let weightLabel = SKLabelNode(fontNamed: "Arial")
        weightLabel.text = "\(weight) kg"
        weightLabel.fontSize = 150
        weightLabel.fontColor = SKColor.white
        weightLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.38)
        self.addChild(weightLabel)
        
        let startSim = SKSpriteNode(imageNamed: "start")
        startSim.size = CGSize(width: 300, height: 300)
        startSim.name = "startButton"
        startSim.position = CGPoint(x: self.size.width/2, y: self.size.height*0.23)
        self.addChild(startSim)
/*
        let startSim = SKLabelNode(fontNamed: "Arial")
        startSim.text = "START"
        startSim.name = "startButton"
        startSim.fontSize = 150
        startSim.fontColor = SKColor.green
        startSim.position = CGPoint(x: self.size.width/2, y: self.size.height*0.20)
        self.addChild(startSim)
  */
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in:self)
            let nodeITapped = atPoint(pointOfTouch)
            if nodeITapped.name == "startButton"    {
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view!.presentScene(sceneToMoveTo)
            }
        }
    }
}
