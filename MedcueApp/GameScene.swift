//
//  GameScene.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/3/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameScene: SKScene {
    
    var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status = false
    var reference = 1
    let labelSecond = SKLabelNode(fontNamed: "Times New Roman")
    let labelMinute = SKLabelNode(fontNamed: "Times New Roman")
    let respValue = SKLabelNode(fontNamed: "Times New Roman")
    let testLabel = SKLabelNode(fontNamed: "Times New Roman")
    
    var run_time: [Double] = [0, 5, 10, 15, 20]
    var resp = ["Gasp", "Labored", "Apnea", "Gasp", "Chest Rise"]
    
    
    override func didMove(to view: SKView) {
       
        startTimer()
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 1500/4, height: 224/4)
        logoLabel.position = CGPoint(x: self.size.width*0.27, y: self.size.height*0.95)
        self.addChild(logoLabel)
        
        labelMinute.fontSize = 175
        labelMinute.fontColor = SKColor.white
        labelMinute.position = CGPoint(x: self.size.width*0.44, y: self.size.height*0.85)
        self.addChild(labelMinute)
        
        labelSecond.fontSize = 175
        labelSecond.fontColor = SKColor.white
        labelSecond.position = CGPoint(x: self.size.width*0.575, y: self.size.height*0.85)
        self.addChild(labelSecond)
 
        let respLabel = SKLabelNode(fontNamed: "Times New Roman")
        respLabel.text = "Resp:"
        respLabel.fontSize = 125
        respLabel.fontColor = SKColor.white
        respLabel.position = CGPoint(x: self.size.width*0.25, y: self.size.height*0.70)
        self.addChild(respLabel)
        
      
        respValue.text = "\(resp[0])"
        if resp[0] == "Gasp" || resp[0] == "Apnea"  {
            respValue.fontColor = SKColor.red
        }
        respValue.fontSize = 125
        respValue.fontColor = SKColor.white
        respValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        respValue.position = CGPoint(x: self.size.width*0.16, y: self.size.height*0.57)
        self.addChild(respValue)
        
        let pulseLabel = SKLabelNode(fontNamed: "Times New Roman")
        pulseLabel.text = "Pulse:"
        pulseLabel.fontSize = 125
        pulseLabel.fontColor = SKColor.white
        pulseLabel.position = CGPoint(x: self.size.width*0.63, y: self.size.height*0.70)
        self.addChild(pulseLabel)
        
        let satLabel = SKLabelNode(fontNamed: "Times New Roman")
        satLabel.text = "Sat:"
        satLabel.fontSize = 125
        satLabel.fontColor = SKColor.white
        satLabel.position = CGPoint(x: self.size.width*0.225, y: self.size.height*0.40)
        self.addChild(satLabel)
        
        let activitylabel = SKLabelNode(fontNamed: "Times New Roman")
        activitylabel.text = "Activity:"
        activitylabel.fontSize = 125
        activitylabel.fontColor = SKColor.white
        activitylabel.position = CGPoint(x: self.size.width*0.67, y: self.size.height*0.40)
        self.addChild(activitylabel)
        
        let pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.size = CGSize(width: 626/4, height: 626/4)
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: self.size.width*0.20, y: self.size.height*0.10)
        self.addChild(pauseButton)
        
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.size = CGSize(width: 969/5, height: 969/5)
        playButton.name = "play"
        playButton.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.10)
        self.addChild(playButton)
        
        let startOver = SKLabelNode(fontNamed: "Times New Roman")
        startOver.text = "Start Over"
        startOver.name = "reset"
        startOver.fontSize = 85
        startOver.fontColor = SKColor.white
        startOver.position = CGPoint(x: self.size.width*0.52, y: self.size.height*0.0866)
        self.addChild(startOver)
        
        let exitButton = SKLabelNode(fontNamed: "Times New Roman")
        exitButton.text = "Exit"
        exitButton.fontSize = 85
        exitButton.fontColor = SKColor.white
        exitButton.name = "exit"
        exitButton.position = CGPoint(x: self.size.width*0.75, y: self.size.height*0.0866)
        self.addChild(exitButton)
        
/*
        testLabel.text = "timer: \(time)"
        testLabel.fontColor = SKColor.white
        testLabel.fontSize = 100
        testLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.20)
        self.addChild(testLabel)
   */
        
        
}
    
    func changeValue()  {
        
        if time/2 >= run_time[reference]  {
            testLabel.text = "\(reference)"
            respValue.text = String("\(resp[reference])")
            if resp[reference] == "Gasp" || resp[reference] == "Apnea"  {
                respValue.fontColor = SKColor.red
            }
            reference += 1
        }
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in:self)
            let nodeITapped = atPoint(pointOfTouch)
            
            if nodeITapped.name == "pause"    {
                pauseTimer()
            }
            if nodeITapped.name == "play"   {
                startTimer()
            }
            if nodeITapped.name == "reset"  {
                resetButton()
            }
            if nodeITapped.name == "exit"   {
                let sceneToMoveTo = HistoryScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view!.presentScene(sceneToMoveTo)
            }
        }
        
    }
    
    func startTimer()   {
        
        if status == false  {
        startTime = Date().timeIntervalSinceReferenceDate - (elapsed)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

        status = true
        }
    }
    
    func pauseTimer()    {
        elapsed = Date().timeIntervalSinceReferenceDate - startTime
        timer?.invalidate()
        status = false
        
    }
    
    func resetButton()  {
        
        timer?.invalidate()
        startTime = 0
        time = 0
        elapsed = 0
        status = false
        reference = 1
        
        labelMinute.text = String("00:")
        labelSecond.text = String("00")
        respValue.text = "\(resp[0])"
        startTimer()
    }
    
    @objc func updateTimer()    {
        
        time = Date().timeIntervalSinceReferenceDate - startTime
        
        let minutes = UInt(time/60)
        time += (TimeInterval(minutes) * 60)
        
        var seconds = UInt(time)
        time += (TimeInterval(seconds))
        if seconds >= 60 {
            seconds = seconds%60
        }
        
        let strMinutes = String(format: "%02d:", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        labelMinute.text = strMinutes
        labelSecond.text = strSeconds
  //      testLabel.text = "Timer: \(time)"
        
        changeValue()
        
    }
    
    
    
    
    
    
    
    

}
