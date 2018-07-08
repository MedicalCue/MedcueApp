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
    var idx = 0
    var reference = 0
    var flag = 0
    let labelSecond = SKLabelNode(fontNamed: "Arial")
    let labelMinute = SKLabelNode(fontNamed: "Arial")
    let respValue = SKLabelNode(fontNamed: "Arial")
    let testLabel = SKLabelNode(fontNamed: "Arial")
    let pulseValue = SKLabelNode(fontNamed: "Arial")
    let satValue = SKLabelNode(fontNamed: "Arial")
    let activityValue = SKLabelNode(fontNamed: "Arial")
    
    var run_time: [Double] = [0, 5, 10, 15, 20, 25, 30]
    var resp = ["Gasp", "Apnea", "Apnea", "Gasp", "Chest Rise", "No Rise", "Gasp"]
    var pulse = [50, 40, 30, 45, 60, 70, 100]
    var sat = ["?", 40, 50, 60, 70, 80, 90] as [Any]
    var activity = ["Limp", "Some Tone", "Tone", "Moving", "Motion", "Poor Motion", "Tone"]
    
    override func didMove(to view: SKView) {
        
        startTimer()
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 1500/4, height: 224/4)
        logoLabel.position = CGPoint(x: self.size.width*0.73, y: self.size.height*0.95)
        self.addChild(logoLabel)
        
        let backLabel = SKLabelNode(fontNamed: "Arial")
        backLabel.text = "<Back"
        backLabel.fontSize = 85
        backLabel.fontColor = SKColor.white
        backLabel.name = "back"
        backLabel.position = CGPoint(x: self.size.width*0.22, y: self.size.height*0.935)
        self.addChild(backLabel)
        
        labelMinute.fontSize = 175
        labelMinute.fontColor = SKColor.white
        labelMinute.position = CGPoint(x: self.size.width*0.44, y: self.size.height*0.81)
        self.addChild(labelMinute)
        
        labelSecond.fontSize = 175
        labelSecond.fontColor = SKColor.white
        labelSecond.position = CGPoint(x: self.size.width*0.58, y: self.size.height*0.81)
        self.addChild(labelSecond)
 
        let respLabel = SKLabelNode(fontNamed: "Arial")
        respLabel.text = "Resp:"
        respLabel.fontSize = 125
        respLabel.fontColor = SKColor.white
        respLabel.position = CGPoint(x: self.size.width*0.27, y: self.size.height*0.70)
        self.addChild(respLabel)
      
        respValue.text = "\(resp[0])"
        if resp[0] == "Gasp" || resp[0] == "Apnea"  {
            respValue.fontColor = SKColor.red
        }
        respValue.fontSize = 125
        respValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        respValue.position = CGPoint(x: self.size.width*0.165, y: self.size.height*0.57)
        self.addChild(respValue)
        
        let pulseLabel = SKLabelNode(fontNamed: "Arial")
        pulseLabel.text = "Pulse:"
        pulseLabel.fontSize = 125
        pulseLabel.fontColor = SKColor.white
        pulseLabel.position = CGPoint(x: self.size.width*0.645, y: self.size.height*0.70)
        self.addChild(pulseLabel)
        
        pulseValue.text = "\(pulse[0])"
        pulseValue.fontSize = 125
        if pulse[0] > 99 && pulse[0] < 301  {
            pulseValue.fontColor = SKColor.green
        }
        else if pulse[0] > 59 && pulse[0] < 100  {
            pulseValue.fontColor = SKColor.yellow
        }
        else    {
            pulseValue.fontColor = SKColor.red
        }
        pulseValue.position = CGPoint(x: self.size.width*0.56, y: self.size.height*0.57)
        pulseValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(pulseValue)
        
        let satLabel = SKLabelNode(fontNamed: "Arial")
        satLabel.text = "Sat:"
        satLabel.fontSize = 125
        satLabel.fontColor = SKColor.white
        satLabel.position = CGPoint(x: self.size.width*0.225, y: self.size.height*0.38)
        self.addChild(satLabel)
        
        satValue.text = "\(sat[0])"
        satValue.fontSize = 125
        satValue.position = CGPoint(x: self.size.width*0.18, y: self.size.height*0.27)
        satValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(satValue)
        
        let activityLabel = SKLabelNode(fontNamed: "Arial")
        activityLabel.text = "Activity:"
        activityLabel.fontSize = 125
        activityLabel.fontColor = SKColor.white
        activityLabel.position = CGPoint(x: self.size.width*0.64, y: self.size.height*0.38)
        self.addChild(activityLabel)
        
        activityValue.text = "\(activity[0])"
        activityValue.fontSize = 125
        activityValue.position = CGPoint(x: self.size.width*0.64, y: self.size.height*0.27)
        if activity[0] == "Tone" || activity[0] == "Motion" || activity[0] == "Moving"    {
            activityValue.fontColor = SKColor.green
        }
        else if activity[0] == "Some Tone" || activity[0] == "Poor Motion"   {
            activityValue.fontColor = SKColor.yellow
        }
        else    {
            activityValue.fontColor = SKColor.red
        }
        self.addChild(activityValue)
        
        let pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.size = CGSize(width: 626/4, height: 626/4)
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: self.size.width*0.47, y: self.size.height*0.10)
        self.addChild(pauseButton)
        
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.size = CGSize(width: 969/5, height: 969/5)
        playButton.name = "play"
        playButton.position = CGPoint(x: self.size.width*0.55, y: self.size.height*0.10)
        self.addChild(playButton)
        
        let fastForward = SKSpriteNode(imageNamed: "ff")
        fastForward.size = CGSize(width: 974/7, height: 974/7)
        fastForward.name = "forward"
        fastForward.position = CGPoint(x: self.size.width*0.64, y: self.size.height*0.10)
        self.addChild(fastForward)
        
        let fastBackward = SKSpriteNode(imageNamed: "fb")
        fastBackward.size = CGSize(width: 974/7, height: 974/7)
        fastBackward.name = "backward"
        fastBackward.position = CGPoint(x: self.size.width*0.38, y: self.size.height*0.10)
        self.addChild(fastBackward)
 
    /*
        let startOver = SKLabelNode(fontNamed: "Arial")
        startOver.text = "Reset"
        startOver.name = "reset"
        startOver.fontSize = 85
        startOver.fontColor = SKColor.white
        startOver.position = CGPoint(x: self.size.width*0.52, y: self.size.height*0.2)
        self.addChild(startOver)
    */
        let exitButton = SKLabelNode(fontNamed: "Arial")
        exitButton.text = "Finish"
        exitButton.fontSize = 85
        exitButton.fontColor = SKColor.white
        exitButton.name = "finish"
        exitButton.position = CGPoint(x: self.size.width*0.75, y: self.size.height*0.2)
        self.addChild(exitButton)
  /*
        //testLabel.text = "timer: \(time)"
        testLabel.fontColor = SKColor.white
        testLabel.fontSize = 100
        testLabel.position = CGPoint(x: self.size.width*0.4, y: self.size.height*0.20)
        self.addChild(testLabel)
  */
}
    
    func changeValue()  {
        reference = idx + 1

        if elapsed >= run_time[reference]  {
            if run_time[reference] == run_time.last  {
                exit()
            }
            else    {
      //          testLabel.text = "\(reference)"
                respValue.text = String("\(resp[reference])")
                respValue.fontSize = 125
                pulseValue.text = String("\(pulse[reference])")
                satValue.text = String("\(sat[reference])")
                activityValue.text = String("\(activity[reference])")
                activityValue.fontSize = 125
                
                if resp[reference] == "Gasp" || resp[reference] == "Apnea" || resp[reference] == "No Rise" {
                    respValue.fontColor = SKColor.red
                }
                else if resp[reference] == "Labored"    {
                    respValue.fontColor = SKColor.yellow
                }
                else if resp[reference] == "Chest Rise" {
                    respValue.fontColor = SKColor.green
                    respValue.fontSize = 100
                }
                
                if pulse[reference] > 99  {
                    pulseValue.fontColor = SKColor.green
                }
                else if pulse[reference] > 59 && pulse[reference] < 100 {
                    pulseValue.fontColor = SKColor.yellow
                }
                else    {
                    pulseValue.fontColor = SKColor.red
                }
                
                if activity[reference] == "Tone" || activity[reference] == "Motion" || activity[reference] == "Moving"    {
                    activityValue.fontColor = SKColor.green
                }
                else if activity[reference] == "Some Tone" || activity[reference] == "Poor Motion"   {
                    activityValue.fontColor = SKColor.yellow
                    activityValue.fontSize = 100
                }
                else{
                    activityValue.fontColor = SKColor.red
                }
                
                idx += 1
            }
        }
        print ("elapsed:\(elapsed)")
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
                resetTimer()
            }
            if nodeITapped.name == "back"   {
                let sceneToMoveTo = HistoryScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view!.presentScene(sceneToMoveTo)
            }
            if nodeITapped.name == "finish" {
                exit()
            }
            
        }
        
    }
    
    func startTimer()   {
        if status == false    {
            startTime = Date().timeIntervalSinceReferenceDate - (elapsed)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            status = true
        }
    }
    //pause not working
    func pauseTimer()    {
        if status == true   {
            elapsed = Date().timeIntervalSinceReferenceDate - startTime
            timer?.invalidate()
            status = false
        }
    }
    
    func resetTimer()  {
        
        timer?.invalidate()
        startTime = 0
        time = 0
        elapsed = 0
        status = false
        idx = 0
        reference = idx + 1
        
        labelMinute.text = String("00:")
        labelSecond.text = String("00")
        respValue.text = "\(resp[0])"
        pulseValue.text = "\(pulse[0])"
        satValue.text = "\(sat[0])"
        activityValue.text = "\(activity[0])"
        startTimer()
        
    }
    
    
    @objc func updateTimer()    {
        
//      testLabel.text = "ref: \(reference) idx: \(idx)"
    
        time = Date().timeIntervalSinceReferenceDate - startTime
        elapsed = Date().timeIntervalSinceReferenceDate - startTime
        
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
   //     testLabel.text = "Timer: \(elapsed)"
        
        changeValue()
        
    }
    
    func changeScene()  {
        
        let sceneToMoveTo = EndScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        self.view!.presentScene(sceneToMoveTo)
        
    }
    
    func exit()  {
        
        pauseTimer()
        
        let waitToChangeScene = SKAction.wait(forDuration: 0.5)
        let changeSceneAction = SKAction.run(changeScene)
        let changeSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSequence)
        
    }
    
    
    
    
    
    

}
