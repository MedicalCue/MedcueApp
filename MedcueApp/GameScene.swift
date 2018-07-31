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
import FirebaseDatabase

class GameScene: SKScene {
    
    var audioPlayer : AVAudioPlayer!
    var ref: DatabaseReference!
    var scenRef: DatabaseReference!
    var scenName: String = ""
    
    var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status = false
    var idx = 0
    var reference = 0
    var flag = 0
    let labelSecond = SKLabelNode(fontNamed: "Lato-Regular")
    let labelMinute = SKLabelNode(fontNamed: "Lato-Regular")
    let respValue = SKLabelNode(fontNamed: "Lato-Regular")
    let respValue2 = SKLabelNode(fontNamed: "Lato-Regular")
    let testLabel = SKLabelNode(fontNamed: "Lato-Regular")
    let pulseValue = SKLabelNode(fontNamed: "Lato-Regular")
    let satValue = SKLabelNode(fontNamed: "Lato-Regular")
    let activityValue = SKLabelNode(fontNamed: "Lato-Regular")
    let activityValue2 = SKLabelNode(fontNamed: "Lato-Regular")
    let pauseButton = SKSpriteNode(imageNamed: "pause")
    let playButton = SKSpriteNode(imageNamed: "play")

    var run_time = [Double]()
    var resp = [String]()
    var sound = [String]()
    var pulse = [Int]()
    var sat = [Any]()
    var activity = [String]()
    
    override func didMove(to view: SKView) {
        
        let scenName = UserDefaults.standard.string(forKey: "Name")!
        print("scenName: \(scenName)")
        
        self.ref = Database.database().reference()
        self.scenRef = self.ref.child("Scenarios")
        
        if scenName == "Scenario A" {
            insertScenarios(Title: "A",
                            Times: [0,10,20,40,50,60,70,80,90,100,110,120,130,160,180,200],
                            Resp: ["Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate" ],
                            Pulse: [110,140,160,180,190,160,165,150,145,155,145,145,160,150,145,150],
                            Sat: [0,0,"--",55,50,50,52,60,55,60,65,65,70,80,85,85],
                            Activity: ["Motion", "Motion", "Motion", "Poor Tone", "Limp", "Limp", "Limp", "Moving", "Moving", "Moving", "Moving", "Good Tone", "Good Tone", "Good Tone", "Good Tone", "Good Tone"])
        }
        if scenName == "Scenario B" {
            insertScenarios(Title: "B",
                            Times: [0,10,20,40,50,60,70,80,90,100,110,120,130,160,180,200],
                            Resp: ["Labored", "Labored", "Labored", "Labored", "Labored", "Labored", "Labored", "Labored", "Labored", "Labored", "Labored", "Adequate", "Adequate", "Adequate", "Adequate", "Adequate"],
                            Pulse: [120,140,160,180,110,105,110,120,125,125,135,145,160,150,145,150],
                            Sat: ["0", "0", "--", "55", "50", "50", "52", "60", "55", "60", "55", "65", "70", "80", "85", "85"],
                            Activity: ["Motion", "Motion", "Motion", "Poor Tone", "Limp", "Limp", "Limp", "Moving", "Moving", "Moving", "Moving", "Good Tone", "Good Tone", "Good Tone", "Good Tone", "Good Tone"])
        }
        if scenName == "Scenario C" {
            insertScenarios(Title: "C",
                            Times: [0,10,20,40,50,60,70,80,90,100,110,120,150,160,180,220,230,240],
                            Resp: ["Labored", "Labored", "Labored", "Labored", "Ap/No Rise", "Ap/No Rise", "Ap/No Rise", "No Rise","No Rise", "No Rise", "Chest Rise", "Chest Rise", "Chest Rise", "Labored", "Labored", "Adequate", "Adequate", "Adequate"],
                            Pulse: [100,115,105,105,95,85,90,90,95,97,92,95,105,160,175,150,155,150],
                            Sat: ["0", "0", "--", "55", "50", "50", "55", "60", "55", "60", "65", "65", "70", "80", "85","85","90","90"],
                            Activity: ["Poor Tone", "Motion", "Motion", "Poor Tone", "Limp", "Limp", "Limp", "Limp", "Poor Tone", "Poor Tone", "Poor Tone","Some Tone", "Good Tone", "Good Tone", "Good Tone", "Good Tone", "Good Tone", "Good Tone"])
        }
        if scenName == "Scenario D" {
            insertScenarios(Title: "D",
                            Times: [0,10,20,40,50,60,70,80,90,100,110,120,150,160,190,200,220,240],
                            Resp: ["Apnea", "Apnea", "Apnea", "Ap/No Rise", "Ap/No Rise", "Ap/No Rise", "Ap/No Rise", "No Rise", "No Rise", "Chest Rise", "Chest Rise", "Chest Rise", "Rise/Apnea", "Rise/Apnea","Rise/Apnea","Rise/Apnea","Rise/Apnea","Adequate"],
                            Pulse: [105,102,105,106,102,105,90,90,95,85,90,93,97,92,105,150,155,150],
                            Sat: ["0", "0", "--", "55", "50", "50", "55", "60", "55", "60", "60", "65","70","80","85","85","90","90"],
                            Activity: ["Poor Tone", "Poor Tone", "Poor Tone", "Poor Tone", "Limp", "Limp","Limp","Limp","Weak Tone", "Weak Tone","Weak Tone","Weak Tone","Weak Tone","Some Tone","Good Tone","Good Tone","Good Tone","Good Tone"])
        }
        if scenName == "Scenario E" {
            insertScenarios(Title: "E",
                            Times: [0,10,20,40,50,60,70,80,90,100,110,120,130,160,180,210,230,270],
                            Resp: ["Labored","Labored","Labored","Labored","Labored","Ap/No Rise","Ap/No Rise","No Rise","No Rise","No Rise", "No Rise","No Rise","No Rise","No Rise","No Rise","No Rise","Chest Rise","Adequate"],
                            Pulse: [120,115,105,105,102,105,90,90,95,85,90,85,80,70,90,95,105,150],
                            Sat: ["0","0","--","55","50","50","55","60","55","60","65","65","70","60","55","85","90","90"],
                            Activity: ["Poor Tone", "Motion", "Motion", "Poor Tone", "Poor Tone", "Limp", "Limp", "Limp", "Weak Tone","Weak Tone", "Weak Tone","Weak Tone", "Weak Tone", "Weak Tone", "Weak Tone", "Weak Tone", "Weak Tone", "Moving"])
        }
        if scenName == "Scenario F" {
            insertScenarios(Title: "F",
                            Times: [0,10,20,30,50,60,70,80,90,100,110,120,130,160,180,200,230,240,270],
                            Resp: ["Labored","Labored","Labored","Labored","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise","Chest Rise"],
                            Pulse: [120,140,160,180,90,75,65,55,55,50,55,45,50,30,40,50,55,70,90],
                            Sat: ["0","0","--","55","50","50","52","--","--","--","--","67","--","--","--","--","--","70","98"],
                            Activity: ["Motion","Motion","Motion","Poor Tone","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp","Limp"])
        }
        if scenName == "Scenario G" {
            insertScenarios(Title: "G",
                            Times: [0,10,25,40,55,70,85,100,115,130,145,160,175,190,205,220,240,270],
                            Resp: ["Gasp", "Apnea", "Ap/No Rise", "Ap/No Rise", "Ap/No Rise", "No Rise", "No Rise", "No Rise", "No Rise", "No Rise", "No Rise", "Chest Rise", "Chest Rise", "Chest Rise", "Chest Rise", "Chest Rise", "Chest Rise", "Chest Rise"],
                            Pulse: [50,40,30,20,50,50,40,30,30,50,30,45,40,45,50,45,30,20],
                            Sat: ["--", "--", "--", "55", "--", "50", "--", "--", "55", "50", "--", "50", "--", "55", "--", "--", "75", "--"],
                            Activity: ["Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp", "Limp"])
        }
        
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
        labelSecond.position = CGPoint(x: self.size.width*0.59, y: self.size.height*0.81)
        self.addChild(labelSecond)
        
        let respLabel = SKLabelNode(fontNamed: "Lato-Bold")
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
                    respValue.position = CGPoint(x: self.size.width*0.22, y: self.size.height*0.57)
                }
                if resp[0] == "No Rise" {
                    respValue.text = "No"
                    respValue2.text = "Rise"
                    respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.57)
                }
            }
            else if resp[0] == "Ap/No Rise"  {
                respValue.text = "Ap/"
                respValue2.text = "No Rise"
                respValue.position = CGPoint(x: self.size.width*0.25 , y: self.size.height*0.57)
                respValue2.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.50)
            }
            else if resp[0] == "Rise/Apnea" {
                respValue.text = "Rise/"
                respValue2.text = "Apnea"
                respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.57)
                respValue2.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.50)
            }
            else if resp[0] == "Adequate"   {
                respValue.text = "\(resp[0])"
                respValue.fontSize = 100
                respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.55)
            }
            else if resp[0] == "Apnea"  {
                respValue.text = "\(resp[0])"
                respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.55)
            }
            else if resp[0] == "Labored"    {
                respValue.text = "\(resp[0])"
                respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.55)
            }
            else    {
                respValue.text = "\(resp[0])"
                respValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                respValue.position = CGPoint(x: self.size.width*0.23, y: self.size.height*0.55)
            }
        self.addChild(respValue)
        self.addChild(respValue2)
        
        let pulseLabel = SKLabelNode(fontNamed: "Lato-Bold")
        pulseLabel.text = "Pulse"
        pulseLabel.fontSize = 125
        pulseLabel.fontColor = SKColor.white
        pulseLabel.position = CGPoint(x: self.size.width*0.69, y: self.size.height*0.655)
        self.addChild(pulseLabel)
        
        pulseValue.text = "\(pulse[0])"
        pulseValue.fontSize = 125
        pulseValue.fontColor = SKColor.white
            if pulse[0] > 99    {
                pulseValue.position = CGPoint(x: self.size.width*0.62, y: self.size.height*0.55)
            }
            else    {
                pulseValue.position = CGPoint(x: self.size.width*0.63, y: self.size.height*0.55)
            }
        pulseValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(pulseValue)
        
        let satLabel = SKLabelNode(fontNamed: "Lato-Bold")
        satLabel.text = "SpO"
        satLabel.fontSize = 125
        satLabel.fontColor = SKColor.white
        satLabel.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.35)
        self.addChild(satLabel)
        
        let satLabel2 = SKLabelNode(fontNamed: "Lato-Bold")
        satLabel2.text = "2"
        satLabel2.fontSize = 75
        satLabel2.fontColor = SKColor.white
        satLabel2.position = CGPoint(x: self.size.width*0.392, y: self.size.height*0.34)
        self.addChild(satLabel2)
        
        satValue.text = "\(sat[0])"
        satValue.fontSize = 125
        satValue.fontColor = SKColor.white
        satValue.position = CGPoint(x: self.size.width*0.28, y: self.size.height*0.26)
        satValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(satValue)
        
        let activityLabel = SKLabelNode(fontNamed: "Lato-Bold")
        activityLabel.text = "Activity"
        activityLabel.fontSize = 125
        activityLabel.fontColor = SKColor.white
        activityLabel.position = CGPoint(x: self.size.width*0.685, y: self.size.height*0.35)
        self.addChild(activityLabel)
        
        activityValue.fontSize = 125
        activityValue2.fontSize = 125
        activityValue.fontColor = SKColor.white
            if activity[0] == "Some Tone" || activity[0] == "Poor Motion" || activity[0] == "Poor Tone" || activity[0] == "Good Tone" || activity[0] == "Weak Tone"   {
                if activity[0] == "Some Tone"  {
                    activityValue.text = "Some"
                    activityValue2.text = "Tone"
                }
                if activity[0] == "Poor Motion"  {
                    activityValue.text = "Poor"
                    activityValue2.text = "Motion"
                }
                if activity[0] == "Poor Tone"   {
                    activityValue.text = "Poor"
                    activityValue2.text = "Tone"
                }
                if activity[0] == "Good Tone"   {
                    activityValue.text = "Good"
                    activityValue2.text = "Tone"
                }
                if activity[0] == "Weak Tone"   {
                    activityValue.text = "Weak"
                    activityValue2.text = "Tone"
                }
                activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.28)
                activityValue2.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.21)
            }
            else    {
                activityValue.text = "\(activity[0])"
                activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.26)
            }
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
        
        let rect5 = SKShapeNode(rectOf: CGSize(width: 250, height: 127.5), cornerRadius: 10)
        rect5.fillColor = UIColor.red
        rect5.strokeColor = UIColor.red
        rect5.position = CGPoint(x: self.size.width*0.773, y: self.size.height*0.05)
        self.addChild(rect5)
        
        let exitButton = SKLabelNode(fontNamed: "Lato-Regular")
        exitButton.text = "End"
        exitButton.fontSize = 100
        exitButton.fontColor = SKColor.white
        exitButton.name = "finish"
        exitButton.position = CGPoint(x: self.size.width*0.773, y: self.size.height*0.035)
        self.addChild(exitButton)
        
        /*
        let crySound = SKAction.playSoundFileNamed("BabyCrying", waitForCompletion: false)
        self.run(crySound)
        
        if sound[reference] == "Cry" {
            self.run(crySound, withKey: "crySound")
        }
        */
        /*
         else if sound[reference] == "Silent" {
         if self.audioPlayer.isPlaying {
         crySound.stop(remove)
         }
         }
         */
        
    }
    
    func insertScenarios(Title: String, Times: [Double], Resp: [String], Pulse: [Int], Sat: [Any], Activity: [String])    {
        let key = self.scenRef.child("Scenario \(Title)").key
        let scenarios: Dictionary = ["Times": Times,
                                     "Resp": Resp,
                                     "Pulse": Pulse,
                                     "Sat": Sat,
                                     "Activity": Activity]
        self.run_time = Times
        self.resp = Resp
        self.pulse = Pulse
        self.sat = Sat
        self.activity = Activity
        self.scenRef.updateChildValues(["/\(key)": scenarios])

    }

    func changeValue()  {
        reference = idx + 1
        
        if elapsed >= run_time[reference]  {
            if run_time[reference] == run_time.last  {
                exit()
            }
            else    {
                pulseValue.text = String("\(pulse[reference])")
                satValue.text = String("\(sat[reference])")
                activityValue.text = String("\(activity[reference])")
                activityValue.fontSize = 125
                respValue.fontSize = 125
                respValue2.text = ""
                activityValue2.text = ""
                respValue.position = CGPoint(x: self.size.width*0.23, y: self.size.height*0.55)
                respValue2.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.50)
                
                if resp[reference] == "Chest Rise" || resp[reference] == "No Rise"  {
                    if resp[reference] == "Chest Rise"  {
                        respValue.text = "Chest"
                        respValue2.text = "Rise"
                        respValue.position = CGPoint(x: self.size.width*0.22, y: self.size.height*0.57)
                    }
                    if resp[reference] == "No Rise" {
                        respValue.text = "No"
                        respValue2.text = "Rise"
                        respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.57)
                    }
                }
                else if resp[reference] == "Ap/No Rise"  {
                    respValue.text = "Ap/"
                    respValue2.text = "No Rise"
                    respValue.position = CGPoint(x: self.size.width*0.25, y: self.size.height*0.57)
                    respValue2.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.50)
                }
                else if resp[reference] == "Rise/Apnea" {
                    respValue.text = "Rise/"
                    respValue2.text = "Apnea"
                    respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.57)
                    respValue2.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.50)
                }
                else if resp[reference] == "Adequate"   {
                    respValue.text = "\(resp[reference])"
                    respValue.fontSize = 100
                    respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.55)
                }
                else if resp[reference] == "Apnea"  {
                    respValue.text = "\(resp[reference])"
                    respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.55)
                }
                else if resp[reference] == "Labored"    {
                    respValue.text = "\(resp[reference])"
                    respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.55)
                }
                else    {
                    respValue.position = CGPoint(x: self.size.width*0.23, y: self.size.height*0.55)
                    respValue.text = String("\(resp[reference])")
                }
                
                if activity[reference] == "Some Tone" || activity[reference] == "Poor Motion" || activity[reference] == "Poor Tone" || activity[reference] == "Good Tone" || activity[reference] == "Weak Tone"  {
                    if activity[reference] == "Some Tone"  {
                        activityValue.text = "Some"
                        activityValue2.text = "Tone"
                    }
                    if activity[reference] == "Poor Motion"  {
                        activityValue.text = "Poor"
                        activityValue2.text = "Motion"
                    }
                    if activity[reference] == "Poor Tone"   {
                        activityValue.text = "Poor"
                        activityValue2.text = "Tone"
                    }
                    if activity[reference] == "Good Tone"   {
                        activityValue.text = "Good"
                        activityValue2.text = "Tone"
                    }
                    if activity[reference] == "Weak Tone"   {
                        activityValue.text = "Weak"
                        activityValue2.text = "Tone"
                    }
                    activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.28)
                    activityValue2.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.21)
                }
                else    {
                    activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.26)
                }
                
                if pulse[reference] > 99    {
                    pulseValue.position = CGPoint(x: self.size.width*0.62, y: self.size.height*0.55)
                }
                else    {
                    pulseValue.position = CGPoint(x: self.size.width*0.63, y: self.size.height*0.55)
                }
                idx += 1
            }
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
        
        changeValue()
        
    }
    
    func changeScene()  {
        
        let sceneToMoveTo = EndScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        self.view!.presentScene(sceneToMoveTo)
        
    }
    
    func exit()  {
        
        pauseTimer()
        
        self.scenRef.child("Scenarios").removeValue()
        
        let waitToChangeScene = SKAction.wait(forDuration: 0.5)
        let changeSceneAction = SKAction.run(changeScene)
        let changeSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSequence)
        
    }    
    
}
