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
import AVFoundation

class GameScene: SKScene {
    
    var audioPlayer : AVAudioPlayer!
    
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
    let respValue2 = SKLabelNode(fontNamed: "Arial")
    let testLabel = SKLabelNode(fontNamed: "Arial")
    let pulseValue = SKLabelNode(fontNamed: "Arial")
    let satValue = SKLabelNode(fontNamed: "Arial")
    let activityValue = SKLabelNode(fontNamed: "Arial")
    let activityValue2 = SKLabelNode(fontNamed: "Arial")
    let pauseButton = SKSpriteNode(imageNamed: "pause")
    let playButton = SKSpriteNode(imageNamed: "play")
    
    
    var run_time: [Double] = [0, 5, 10, 15, 20, 25, 30]
    var resp = ["Chest Rise", "Apnea", "Apnea", "Gasp", "Chest Rise", "No Rise", "Gasp"]
    var sound = ["Cry", "Silent", "Cry", "Silent", "Cry"]
    var pulse = [50, 40, 30, 45, 60, 70, 100]
    var sat = ["--", 40, 50, 60, 70, 80, 90] as [Any]
    var activity = ["Some Tone", "Limp", "Poor Motion", "Moving", "Motion", "Poor Motion", "Tone"]
    
    override func didMove(to view: SKView) {
        
        startTimer()
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 1500/3.5, height: 224/3.5)
        logoLabel.position = CGPoint(x: self.size.width*0.70, y: self.size.height*0.94)
        self.addChild(logoLabel)
        
        let rect1 = SKShapeNode(rectOf: CGSize(width: 525, height: 525), cornerRadius: 20)
        let color1 = UIColor(red: 94/255, green: 140/255, blue: 255/255, alpha: 1)
        rect1.fillColor = color1
        rect1.strokeColor = color1
        rect1.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.60)
        self.addChild(rect1)
        
        let rect2 = SKShapeNode(rectOf: CGSize(width: 525, height: 525), cornerRadius: 20)
        let color2 = UIColor(red: 255/255, green: 79/255, blue: 43/255, alpha: 1)
        rect2.fillColor = color2
        rect2.strokeColor = color2
        rect2.position = CGPoint(x: self.size.width*0.685, y: self.size.height*0.60)
        self.addChild(rect2)
        
        let rect3 = SKShapeNode(rectOf: CGSize(width: 525, height: 525), cornerRadius: 20)
        let color3 = UIColor(red: 0, green: 134/255, blue: 59/255, alpha: 1)
        rect3.fillColor = color3
        rect3.strokeColor = color3
        rect3.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.30)
        self.addChild(rect3)
        
        let rect4 = SKShapeNode(rectOf: CGSize(width: 525, height: 525), cornerRadius: 20)
        let color4 = UIColor(red: 161/255, green: 110/255, blue: 212/255, alpha: 1)
        rect4.fillColor = color4
        rect4.strokeColor = color4
        rect4.position = CGPoint(x: self.size.width*0.685, y: self.size.height*0.30)
        self.addChild(rect4)
        
        labelMinute.fontSize = 175
        labelMinute.fontColor = SKColor.white
        labelMinute.position = CGPoint(x: self.size.width*0.44, y: self.size.height*0.81)
        self.addChild(labelMinute)
        
        labelSecond.fontSize = 175
        labelSecond.fontColor = SKColor.white
        labelSecond.position = CGPoint(x: self.size.width*0.58, y: self.size.height*0.81)
        self.addChild(labelSecond)
        
        let respLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        respLabel.text = "Resp"
        respLabel.fontSize = 125
        respLabel.fontColor = SKColor.white
        respLabel.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.65)
        self.addChild(respLabel)
        
        
        respValue.fontColor = SKColor.white
        respValue.fontSize = 125
        respValue2.fontSize = 125
        respValue2.fontColor = SKColor.white
        respValue2.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.50)
        if resp[0] == "Chest Rise" || resp[0] == "No Rise"  {
            if resp[0] == "Chest Rise"  {
                respValue.text = "Chest"
                
                respValue2.text = "Rise"
            }
            if resp[0] == "No Rise" {
                respValue.text = "No"
                respValue2.text = "Rise"
            }
            respValue.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.57)
        }
        else    {
            respValue.text = "\(resp[0])"
            respValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.55)
        }
        self.addChild(respValue)
        self.addChild(respValue2)
        
        let pulseLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        pulseLabel.text = "Pulse"
        pulseLabel.fontSize = 125
        pulseLabel.fontColor = SKColor.white
        pulseLabel.position = CGPoint(x: self.size.width*0.69, y: self.size.height*0.655)
        self.addChild(pulseLabel)
        
        pulseValue.text = "\(pulse[0])"
        pulseValue.fontSize = 125
        pulseValue.fontColor = SKColor.white
        /*
         if pulse[0] > 99 && pulse[0] < 301  {
         pulseValue.fontColor = SKColor.green
         }
         else if pulse[0] > 59 && pulse[0] < 100  {
         pulseValue.fontColor = SKColor.yellow
         }
         else    {
         pulseValue.fontColor = SKColor.red
         }*/
        pulseValue.position = CGPoint(x: self.size.width*0.63, y: self.size.height*0.55)
        pulseValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(pulseValue)
        
        let satLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        satLabel.text = "Sat"
        //     var sp: String = "SpO2"
        //      subscript(i: sp.3) -> Character { get }
        satLabel.fontSize = 125
        satLabel.fontColor = SKColor.white
        satLabel.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.35)
        self.addChild(satLabel)
        
        satValue.text = "\(sat[0])"
        satValue.fontSize = 125
        satValue.fontColor = SKColor.white
        satValue.position = CGPoint(x: self.size.width*0.275, y: self.size.height*0.26)
        satValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(satValue)
        
        let activityLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        activityLabel.text = "Activity"
        activityLabel.fontSize = 125
        activityLabel.fontColor = SKColor.white
        activityLabel.position = CGPoint(x: self.size.width*0.685, y: self.size.height*0.35)
        self.addChild(activityLabel)
        
        activityValue.fontSize = 125
        activityValue2.fontSize = 125
        activityValue.fontColor = SKColor.white
        if activity[0] == "Some Tone" || activity[0] == "Poor Motion"   {
            if activity[0] == "Some Tone"  {
                activityValue.text = "Some"
                activityValue2.text = "Tone"
            }
            if activity[0] == "Poor Motion"  {
                activityValue.text = "Poor"
                activityValue2.text = "Motion"
            }
            activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.28)
            activityValue2.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.21)
        }
        else    {
            activityValue.text = "\(activity[0])"
            activityValue.position = CGPoint(x: self.size.width*0.67, y: self.size.height*0.26)
        }
        /*
         if activity[0] == "Tone" || activity[0] == "Motion" || activity[0] == "Moving"    {
         activityValue.fontColor = SKColor.green
         }
         else if activity[0] == "Some Tone" || activity[0] == "Poor Motion"   {
         activityValue.fontColor = SKColor.yellow
         }
         else    {
         activityValue.fontColor = SKColor.red
         } */
        self.addChild(activityValue)
        self.addChild(activityValue2)
        
        
        pauseButton.size = CGSize(width: 626/3, height: 626/3)
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: self.size.width/2, y: self.size.height*0.09)
        self.addChild(pauseButton)
        
        
        playButton.size = CGSize(width: 969/4, height: 969/4)
        playButton.name = "play"
        playButton.position = CGPoint(x: self.size.width/2, y: self.size.height*0.09)
        self.addChild(playButton)
        
        /*
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
         */
        /*
         let startOver = SKLabelNode(fontNamed: "Arial")
         startOver.text = "Reset"
         startOver.name = "reset"
         startOver.fontSize = 85
         startOver.fontColor = SKColor.white
         startOver.position = CGPoint(x: self.size.width*0.52, y: self.size.height*0.2)
         self.addChild(startOver)
         */
        
        let rect5 = SKShapeNode(rectOf: CGSize(width: 250, height: 127.5), cornerRadius: 10)
        rect5.fillColor = UIColor.red
        rect5.strokeColor = UIColor.red
        rect5.position = CGPoint(x: self.size.width*0.773, y: self.size.height*0.05)
        self.addChild(rect5)
        
        let exitButton = SKLabelNode(fontNamed: "Arial")
        exitButton.text = "End"
        exitButton.fontSize = 100
        exitButton.fontColor = SKColor.white
        exitButton.name = "finish"
        exitButton.position = CGPoint(x: self.size.width*0.773, y: self.size.height*0.035)
        self.addChild(exitButton)
        /*
         //testLabel.text = "timer: \(time)"
         testLabel.fontColor = SKColor.white
         testLabel.fontSize = 100
         testLabel.position = CGPoint(x: self.size.width*0.4, y: self.size.height*0.20)
         self.addChild(testLabel)
         */
        let crySound = SKAction.playSoundFileNamed("BabyCrying", waitForCompletion: false)
        self.run(crySound)
        
        if sound[reference] == "Cry" {
            self.run(crySound, withKey: "crySound")
        }
        
        /*
         else if sound[reference] == "Silent" {
         if self.audioPlayer.isPlaying {
         crySound.stop(remove)
         }
         }
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
                
                pulseValue.text = String("\(pulse[reference])")
                satValue.text = String("\(sat[reference])")
                activityValue.text = String("\(activity[reference])")
                activityValue.fontSize = 125
                
                if resp[reference] == "Chest Rise" || resp[reference] == "No Rise"  {
                    if resp[reference] == "Chest Rise"  {
                        respValue.text = "Chest"
                        respValue2.text = "Rise"
                    }
                    if resp[reference] == "No Rise" {
                        respValue.text = "No"
                        respValue2.text = "Rise"
                    }
                    respValue.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.57)
                }
                else    {
                    respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.55)
                    respValue.text = String("\(resp[reference])")
                    respValue2.text = ""
                }
                
                if activity[reference] == "Some Tone" || activity[reference] == "Poor Motion"   {
                    if activity[reference] == "Some Tone"  {
                        activityValue.text = "Some"
                        activityValue2.text = "Tone"
                    }
                    if activity[reference] == "Poor Motion"  {
                        activityValue.text = "Poor"
                        activityValue2.text = "Motion"
                    }
                    activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.28)
                    activityValue2.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.21)
                }
                else    {
                    activityValue.text = "\(activity[reference])"
                    activityValue2.text = ""
                    activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.26)
                }
                
                /*
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
                 }*/
                
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
            playButton.isHidden = true
            pauseButton.isHidden = false
        }
    }
    
    func pauseTimer()    {
        if status == true   {
            elapsed = Date().timeIntervalSinceReferenceDate - startTime
            timer?.invalidate()
            status = false
            pauseButton.isHidden = true
            playButton.isHidden = false
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
