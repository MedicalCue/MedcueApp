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
    
    var player: AVAudioPlayer?
    var ref: DatabaseReference!
    var gameRef: DatabaseReference!
    var scenName: String = ""
    var scenTitle: String = ""
    
    var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status = false
    var isPlaying = false
    var idx = 0
    var reference = 0
    let labelSecond = SKLabelNode(fontNamed: "Lato-Regular")
    let labelMinute = SKLabelNode(fontNamed: "Lato-Regular")
    let respValue = SKLabelNode(fontNamed: "Lato-Regular")
    let respValue2 = SKLabelNode(fontNamed: "Lato-Regular")
    let testLabel = SKLabelNode(fontNamed: "Lato-Regular")
    let pulseValue = SKLabelNode(fontNamed: "Lato-Regular")
    let soundLabel = SKLabelNode(fontNamed: "Lato-Bold")
    let satValue = SKLabelNode(fontNamed: "Lato-Regular")
    let activityValue = SKLabelNode(fontNamed: "Lato-Regular")
    let activityValue2 = SKLabelNode(fontNamed: "Lato-Regular")
    let pauseButton = SKSpriteNode(imageNamed: "pause")
    let playButton = SKSpriteNode(imageNamed: "play")
    
    let cry = Bundle.main.path(forResource: "crying", ofType: "mp3")

    var run_time = [0.0, 10.0]
    var resp = [""]
    var sound = [""]
    var pulse = [0]
    var sat = [""] as [Any]
    var activity = [""]
    
    override func didMove(to view: SKView) {
        
        scenName = UserDefaults.standard.string(forKey: "Name")!
        scenTitle = UserDefaults.standard.string(forKey: "Title")!
        
        self.ref = Database.database().reference()
        self.gameRef = self.ref.child("Simulations")
        
        getScenarios(scenName: scenName)
        print("current: \(scenName)")

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
        rect1.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.63)
        self.addChild(rect1)
        
        let rect2 = SKShapeNode(rectOf: CGSize(width: 525, height: 525), cornerRadius: 20)
        let color2 = UIColor(red: 255/255, green: 110/255, blue: 0/255, alpha: 1)
        rect2.fillColor = color2
        rect2.strokeColor = color2
        rect2.position = CGPoint(x: self.size.width*0.685, y: self.size.height*0.63)
        self.addChild(rect2)
        
        let rect3 = SKShapeNode(rectOf: CGSize(width: 525, height: 525), cornerRadius: 20)
        let color3 = UIColor(red: 238/255, green: 98/255, blue: 157/255, alpha: 1)
        rect3.fillColor = color3
        rect3.strokeColor = color3
        rect3.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.29)
        self.addChild(rect3)
        
        let rect4 = SKShapeNode(rectOf: CGSize(width: 525, height: 525), cornerRadius: 20)
        let color4 = UIColor(red: 161/255, green: 110/255, blue: 212/255, alpha: 1)
        rect4.fillColor = color4
        rect4.strokeColor = color4
        rect4.position = CGPoint(x: self.size.width*0.685, y: self.size.height*0.29)
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
        respLabel.position = CGPoint(x: self.size.width*0.315, y: self.size.height*0.68)
        self.addChild(respLabel)
        
        respValue.fontColor = SKColor.white
        respValue.fontSize = 125
        respValue.text = "\(resp[0])"
        respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.58)
        respValue2.fontSize = 125
        respValue2.fontColor = SKColor.white
        respValue2.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.53)
            if resp[0] == "Chest Rise"  {
                respValue.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.60)
                respValue.text = "Chest"
                respValue2.text = "Rise"
            }
            if resp[0] == "No Rise" {
                respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.60)
                respValue.text = "No"
                respValue2.text = "Rise"
            }
            if resp[0] == "Ap/No Rise"  {
                respValue.text = "Ap/"
                respValue2.text = "No Rise"
                respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.60)
                respValue2.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.53)
            }
            if resp[0] == "Rise/Apnea" {
                respValue.text = "Rise/"
                respValue2.text = "Apnea"
                respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.60)
                respValue2.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.53)
            }
            if resp[0] == "Adequate"    {
                respValue.fontSize = 100
            }
        self.addChild(respValue)
        self.addChild(respValue2)
        
        let pulseLabel = SKLabelNode(fontNamed: "Lato-Bold")
        pulseLabel.text = "Pulse"
        pulseLabel.fontSize = 125
        pulseLabel.fontColor = SKColor.white
        pulseLabel.position = CGPoint(x: self.size.width*0.69, y: self.size.height*0.685)
        self.addChild(pulseLabel)
        
        pulseValue.text = "\(pulse[0])"
        pulseValue.fontSize = 125
        pulseValue.fontColor = SKColor.white
            if pulse[0] > 99    {
                pulseValue.position = CGPoint(x: self.size.width*0.62, y: self.size.height*0.58)
            }
            else    {
                pulseValue.position = CGPoint(x: self.size.width*0.63, y: self.size.height*0.58)
            }
        pulseValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(pulseValue)
        
        soundLabel.text = "\(sound[0])"
        soundLabel.fontSize = 110
        soundLabel.fontColor = SKColor.white
        soundLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.443)
        self.addChild(soundLabel)
        
        let satLabel = SKLabelNode(fontNamed: "Lato-Bold")
        satLabel.text = "SpO"
        satLabel.fontSize = 125
        satLabel.fontColor = SKColor.white
        satLabel.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.34)
        self.addChild(satLabel)
        
        let satLabel2 = SKLabelNode(fontNamed: "Lato-Bold")
        satLabel2.text = "2"
        satLabel2.fontSize = 75
        satLabel2.fontColor = SKColor.white
        satLabel2.position = CGPoint(x: self.size.width*0.392, y: self.size.height*0.33)
        self.addChild(satLabel2)
        
        satValue.text = "\(sat[0])"
        satValue.fontSize = 125
        satValue.fontColor = SKColor.white
        satValue.position = CGPoint(x: self.size.width*0.28, y: self.size.height*0.25)
        satValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(satValue)
        
        let activityLabel = SKLabelNode(fontNamed: "Lato-Bold")
        activityLabel.text = "Activity"
        activityLabel.fontSize = 125
        activityLabel.fontColor = SKColor.white
        activityLabel.position = CGPoint(x: self.size.width*0.685, y: self.size.height*0.34)
        self.addChild(activityLabel)
        
        activityValue.fontSize = 125
        activityValue2.fontSize = 125
        activityValue.fontColor = SKColor.white
            if activity[0].range(of: "Tone") != nil  {
                if activity[0] == "Some Tone"  {
                    activityValue.text = "Some"
                }
                if activity[0] == "Poor Tone"   {
                    activityValue.text = "Poor"
                }
                if activity[0] == "Good Tone"   {
                    activityValue.text = "Good"
                }
                if activity[0] == "Weak Tone"   {
                    activityValue.text = "Weak"
                }
                activityValue2.text = "Tone"
                activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.27)
                activityValue2.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.20)
            }
            else    {
                activityValue.text = "\(activity[0])"
                activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.25)
            }
        self.addChild(activityValue)
        self.addChild(activityValue2)
        
        let scenLabel = SKLabelNode(fontNamed: "Lato-Regular")
        scenLabel.text = "\(scenTitle)"
        scenLabel.fontSize = 175
        scenLabel.fontColor = SKColor.white
        scenLabel.position = CGPoint(x: self.size.width*0.23, y: self.size.height*0.81)
        self.addChild(scenLabel)
        
        pauseButton.size = CGSize(width: 626/3, height: 626/3)
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.052)
        self.addChild(pauseButton)
        
        playButton.size = CGSize(width: 969/4, height: 969/4)
        playButton.name = "play"
        playButton.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.052)
        self.addChild(playButton)
        
        let backButton = SKLabelNode(fontNamed: "Lato-Regular")
        backButton.text = "<Back"
        backButton.name = "back"
        backButton.fontSize = 77
        backButton.fontColor = SKColor.white
        backButton.position = CGPoint(x: self.size.width*0.229, y: self.size.height*0.918)
        self.addChild(backButton)
        
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

        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: cry!))
        } catch let error {
            print(error.localizedDescription)
        }
        
        if sound[0] == "Cry" || sound[0] == "Crying" {
            player?.play()
            player?.volume = 1.0
            player?.numberOfLoops = -1
            isPlaying = true
        }
        else if sound[0] == "Weak Cry"  {
            player?.play()
            player?.volume = 0.25
            player?.numberOfLoops = -1
            isPlaying = true
        }
    }

    func changeValue()  {
        reference = idx + 1
        
        if elapsed >= run_time[reference]  {
            if run_time[reference] == run_time.last  {
                exit()
            }
            else    {
                print("isplaying: \(isPlaying)")

                pulseValue.text = String("\(pulse[reference])")
                soundLabel.text = String("\(sound[reference])")
                satValue.text = String("\(sat[reference])")
                activityValue.text = String("\(activity[reference])")
                respValue.text = String("\(resp[reference])")
                respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.58)
                respValue2.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.53)
                activityValue.fontSize = 125
                respValue.fontSize = 125
                respValue2.text = ""
                activityValue2.text = ""
                
                if sound[reference] == "Cry" || sound[reference] == "Crying" {
                    player?.play()
                    player?.numberOfLoops = -1
                    player?.volume = 1.0
                    isPlaying = true
                }
                else if sound[reference] == "Weak Cry" {
                    player?.play()
                    player?.volume = 0.25
                    player?.numberOfLoops = -1
                    isPlaying = true
                }
                else if sound[reference] == "Silent" || sound[reference] == "Quiet" || sound[reference] == "Apnea" || sound[reference] == "Grunt"  {
                    player?.pause()
                    isPlaying = false
                }
                
                if resp[reference] == "Chest Rise" || resp[reference] == "No Rise"  {
                    if resp[reference] == "Chest Rise"  {
                        respValue.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.60)
                        respValue.text = "Chest"
                    }
                    if resp[reference] == "No Rise" {
                        respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.60)
                        respValue.text = "No"
                    }
                    respValue2.text = "Rise"
                }
                if resp[reference] == "Ap/No Rise"  {
                    respValue.text = "Ap/"
                    respValue2.text = "No Rise"
                    respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.60)
                    respValue2.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.53)
                }
                if resp[reference] == "Rise/Apnea" {
                    respValue.text = "Rise/"
                    respValue2.text = "Apnea"
                    respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.60)
                    respValue2.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.53)
                }
                if resp[reference] == "Apnea" || resp[reference] == "Labored" || resp[reference] == "Adequate" {
                    if resp[reference] == "Adequate"    {
                        respValue.fontSize = 100
                    }
                    respValue.text = "\(resp[reference])"
                    respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.58)
                }
                
                if activity[reference].range(of: "Tone") != nil  {
                    if activity[reference] == "Some Tone"  {
                        activityValue.text = "Some"
                    }
                    if activity[reference] == "Poor Tone"   {
                        activityValue.text = "Poor"
                    }
                    if activity[reference] == "Good Tone"   {
                        activityValue.text = "Good"
                    }
                    if activity[reference] == "Weak Tone"   {
                        activityValue.text = "Weak"
                    }
                    activityValue2.text = "Tone"
                    activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.27)
                    activityValue2.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.20)
                }
                else    {
                    activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.25)
                }
                
                if pulse[reference] > 99    {
                    pulseValue.position = CGPoint(x: self.size.width*0.62, y: self.size.height*0.58)
                }
                else    {
                    pulseValue.position = CGPoint(x: self.size.width*0.63, y: self.size.height*0.58)
                }
                idx+=1
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
                if sound[reference] == "Cry" || sound[reference] == "Crying" && isPlaying == false   {
                    player?.play()
                    player?.volume = 1.0
                    player?.numberOfLoops = -1
                    isPlaying = true
                }
            }
            if nodeITapped.name == "reset"  {
                resetTimer()
            }
            if nodeITapped.name == "finish" {
                exit()
            }
            if nodeITapped.name == "back"   {
                pauseTimer()
                player?.stop()
                isPlaying = false
                let scene = HistoryScene(size: CGSize(width: 1536, height: 2048))
                let skView = self.view! as SKView
                scene.scaleMode = .aspectFill
                skView.presentScene(scene)
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
            
            player?.pause()
            isPlaying = false
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
        player?.stop()
        isPlaying = false
        let waitToChangeScene = SKAction.wait(forDuration: 0.25)
        let changeSceneAction = SKAction.run(changeScene)
        let changeSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSequence)
    }
    
    func getScenarios(scenName: String) {
        
            self.gameRef.child("\(scenName)").observe(.value, with: {(snapshot: DataSnapshot) in
            guard var dict = snapshot.value as? [String:Any] else {
                print("Error")
                return
            }
            
            self.run_time = dict["Times"] as! [Double]
            self.resp = dict["Resp"] as! [String]
            self.pulse = dict["Pulse"] as! [Int]
            self.sound = dict["Sound"] as! [String]
            self.sat = dict["Sat"] as! [Any]
            self.activity = dict["Activity"] as! [String]
                
            self.respValue.text = "\(self.resp[0])"
                if self.resp[0] == "Chest Rise"  {
                    self.respValue.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.60)
                    self.respValue.text = "Chest"
                    self.respValue2.text = "Rise"
                }
                if self.resp[0] == "No Rise" {
                    self.respValue.position = CGPoint(x: self.size.width*0.31, y: self.size.height*0.60)
                    self.respValue.text = "No"
                    self.respValue2.text = "Rise"
                }
                if self.resp[0] == "Ap/No Rise"  {
                    self.respValue.text = "Ap/"
                    self.respValue2.text = "No Rise"
                    self.respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.60)
                    self.respValue2.position = CGPoint(x: self.size.width*0.32, y: self.size.height*0.53)
                }
                if self.resp[0] == "Rise/Apnea" {
                    self.respValue.text = "Rise/"
                    self.respValue2.text = "Apnea"
                    self.respValue.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.60)
                    self.respValue2.position = CGPoint(x: self.size.width*0.30, y: self.size.height*0.53)
                }
                if self.resp[0] == "Adequate"    {
                    self.respValue.fontSize = 100
                }
            self.pulseValue.text = "\(self.pulse[0])"
                if self.pulse[0] > 99    {
                    self.pulseValue.position = CGPoint(x: self.size.width*0.62, y: self.size.height*0.58)
                }
                else    {
                    self.pulseValue.position = CGPoint(x: self.size.width*0.63, y: self.size.height*0.58)
                }
            self.soundLabel.text = "\(self.sound[0])"
                if self.sound[0] == "Cry" || self.sound[0] == "Crying" {
                    self.player?.play()
                    self.player?.volume = 1.0
                    self.player?.numberOfLoops = -1
                    self.isPlaying = true
                }
                else if self.sound[0] == "Weak Cry"  {
                    self.player?.play()
                    self.player?.volume = 0.25
                    self.player?.numberOfLoops = -1
                    self.isPlaying = true
                }
            self.satValue.text = "\(self.sat[0])"
            self.activityValue.text = "\(self.activity[0])"
                if self.activity[0].range(of: "Tone") != nil  {
                    if self.activity[0] == "Some Tone"  {
                        self.activityValue.text = "Some"
                    }
                    if self.activity[0] == "Poor Tone"   {
                        self.activityValue.text = "Poor"
                    }
                    if self.activity[0] == "Good Tone"   {
                        self.activityValue.text = "Good"
                    }
                    if self.activity[0] == "Weak Tone"   {
                        self.activityValue.text = "Weak"
                    }
                    self.activityValue2.text = "Tone"
                    self.activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.27)
                    self.activityValue2.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.20)
                }
                else    {
                    self.activityValue.text = "\(self.activity[0])"
                    self.activityValue.position = CGPoint(x: self.size.width*0.68, y: self.size.height*0.25)
                }
        })
    }
}
