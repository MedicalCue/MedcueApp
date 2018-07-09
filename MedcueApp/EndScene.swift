//
//  EndScene.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/5/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        
        let finishedLabel = SKLabelNode(fontNamed: "Arial")
        finishedLabel.text = "Finished!"
        finishedLabel.fontSize = 150
        finishedLabel.fontColor = SKColor.white
        finishedLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(finishedLabel)
        
        let repeatLabel = SKLabelNode(fontNamed: "Arial")
        repeatLabel.text = "Repeat"
        repeatLabel.name = "repeat"
        repeatLabel.fontSize = 100
        repeatLabel.fontColor = SKColor.white
        repeatLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.40)
        self.addChild(repeatLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in:self)
            let nodeITapped = atPoint(pointOfTouch)
        
            if nodeITapped.name == "repeat" {
                
                let sceneToMoveTo = HistoryScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view!.presentScene(sceneToMoveTo)
                
            }
        
        }
    
    }
    
    
}





