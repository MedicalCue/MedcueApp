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
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 1500/3.5, height: 224/3.5)
        logoLabel.position = CGPoint(x: self.size.width*0.70, y: self.size.height*0.94)
        self.addChild(logoLabel)
        
        let finishedLabel = SKLabelNode(fontNamed: "Lato-Regular")
        finishedLabel.text = "Completed"
        finishedLabel.fontSize = 125
        finishedLabel.fontColor = SKColor.white
        finishedLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.50)
        self.addChild(finishedLabel)
        
        let scenLabel = SKLabelNode(fontNamed: "Lato-Regular")
        let scenName = UserDefaults.standard.string(forKey: "Name")!
        scenLabel.text = "\(scenName)"
        scenLabel.fontColor = SKColor.white
        scenLabel.fontSize = 150
        scenLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.60)
        self.addChild(scenLabel)
        
        let rect5 = SKShapeNode(rectOf: CGSize(width: 425, height: 150), cornerRadius: 10)
        let color = UIColor(red: 0/255, green: 147/255, blue: 249/255, alpha: 1)
        rect5.fillColor = color
        rect5.strokeColor = color
        rect5.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.405)
        self.addChild(rect5)
        
        let repeatLabel = SKLabelNode(fontNamed: "Lato-Regular")
        repeatLabel.text = "Repeat"
        repeatLabel.name = "repeat"
        repeatLabel.fontSize = 100
        repeatLabel.fontColor = SKColor.white
        repeatLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.39)
        self.addChild(repeatLabel)
        
        let quitLabel = SKLabelNode(fontNamed: "Lato-Regular")
        quitLabel.text = "Quit"
        quitLabel.name = "quit"
        quitLabel.fontSize = 100
        quitLabel.fontColor = SKColor.white
        quitLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.20)
        self.addChild(quitLabel)
        
        let part1 = UserDefaults.standard.string(forKey: "Part1")!
        let part2 = UserDefaults.standard.string(forKey: "Part2")!
        let part3 = UserDefaults.standard.string(forKey: "Part3")!
        let part4 = UserDefaults.standard.string(forKey: "Part4")!
        print("p1: \(part1), p2: \(part2), p3: \(part3), p4: \(part4)")

        
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
            if nodeITapped.name == "quit"   {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "first") as UIViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = view
            }
        
        }
    
    }
    
}





