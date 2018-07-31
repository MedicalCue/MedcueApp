//
//  GameScene.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/2/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import SpriteKit
import GameplayKit
import FirebaseDatabase

class HistoryScene: SKScene {
    
    let scenarioLabel = SKLabelNode(fontNamed: "Lato-Regular")
    let weeksLabel = SKLabelNode(fontNamed: "Lato-Regular")
    let birthType = SKLabelNode(fontNamed: "Lato-Regular")
    let weightLabel = SKLabelNode(fontNamed: "Lato-Regular")
    let extraLabel = SKLabelNode(fontNamed: "Lato-Regular")
    let extraLabel2 = SKLabelNode(fontNamed: "Lato-Regular")
    
    var scenName: String = ""
    
    var title = ""
    var weeks = ""
    var birth = ""
    var weight = ""
    var extra = ""
    var extra2 = ""
    
    var ref: DatabaseReference!
    var scenRef: DatabaseReference!    
    
    override func didMove(to view: SKView) {
        
        let scenName = UserDefaults.standard.string(forKey: "Name")!
        print("scenName: \(scenName)")
      
        self.ref = Database.database().reference()
        self.scenRef = self.ref.child("Scenarios")
        getScenarios()
        
        if scenName == "Scenario A"    {
            insertScenarios(Title: "A", Birth: "Term Delivery", Weeks: "40", Weight: "3.6", Extra: "", Extra2: "")
        }
        if scenName == "Scenario B"    {
            insertScenarios(Title: "B", Birth: "C-Section", Weeks: "35", Weight: "3.5", Extra: "Class II Strip", Extra2: "")
        }
        if scenName == "Scenario C" {
            insertScenarios(Title: "C", Birth: "Precip Delivery", Weeks: "38", Weight: "4.5", Extra: "Meconium", Extra2: "Diabetic Mom")
        }
        if scenName == "Scenario D" {
            insertScenarios(Title: "D", Birth: "Urgent C-Section", Weeks: "38", Weight: "2.9", Extra: "Preclampsia", Extra2: "Magnesium")
        }
        if scenName == "Scenario E" {
            insertScenarios(Title: "E", Birth: "Urgent C-Section", Weeks: "32", Weight: "1.8-2", Extra: "Class II Fetal Strip", Extra2: "")
        }
        if scenName == "Scenario F" {
            insertScenarios(Title: "F", Birth: "C-Section", Weeks: "36", Weight: "3.2", Extra: "PROM, Class I Strip", Extra2: "Failure to Progress")
        }
        if scenName == "Scenario G" {
            insertScenarios(Title: "G", Birth: "Vaginal Delivery", Weeks: "31", Weight: "1.8", Extra: "Maternal Fever", Extra2: "")
        }
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 750, height: 112)
        logoLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.84)
        self.addChild(logoLabel)
        
        scenarioLabel.text = "Scenario: \(String(describing: title))"
        scenarioLabel.fontSize = 180
        scenarioLabel.fontColor = SKColor.white
        scenarioLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.70)
        self.addChild(scenarioLabel)
        
        weeksLabel.text = "\(String(describing: weeks)) weeks"
        weeksLabel.fontSize = 150
        weeksLabel.fontColor = SKColor.white
        weeksLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.60)
        self.addChild(weeksLabel)
        
        birthType.text = "\(String(describing: birth))"
        birthType.fontSize = 100
        birthType.fontColor = SKColor.white
        birthType.position = CGPoint(x: self.size.width/2, y: self.size.height*0.44)
        self.addChild(birthType)
        
        extraLabel.text = "\(String(describing: extra))"
        extraLabel.fontSize = 100
        extraLabel.fontColor = SKColor.white
        extraLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.375)
        self.addChild(extraLabel)
        
        extraLabel2.text = "\(String(describing: extra2))"
        extraLabel2.fontSize = 100
        extraLabel2.fontColor = SKColor.white
        extraLabel2.position = CGPoint(x: self.size.width/2, y: self.size.height*0.31)
        self.addChild(extraLabel2)
        
        weightLabel.text = "\(String(describing: weight)) kg"
        weightLabel.fontSize = 150
        weightLabel.fontColor = SKColor.white
        weightLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.515)
        self.addChild(weightLabel)
        
        let rect1 = SKShapeNode(rectOf: CGSize(width: 375, height: 191.25), cornerRadius: 20)
        let color1 = UIColor(red: 0/255, green: 138/255, blue: 0/255, alpha: 1)
        rect1.fillColor = color1
        rect1.strokeColor = color1
        rect1.position = CGPoint(x: self.size.width/2, y: self.size.height*0.23)
        self.addChild(rect1)
        
        let startSim = SKLabelNode(fontNamed: "Lato-Regular")
        startSim.text = "START"
        startSim.name = "startButton"
        startSim.fontSize = 100
        startSim.fontColor = SKColor.white
        startSim.position = CGPoint(x: self.size.width/2, y: self.size.height*0.21)
        self.addChild(startSim)
        
    }
    
    
    func insertScenarios(Title: String, Birth: String, Weeks: String, Weight: String, Extra: String, Extra2: String)  {
        let key = self.scenRef.child("Scenario \(Title)").key
        let scenarios : Dictionary =  ["Title" : Title,
                                         "Birth" : Birth,
                                         "Weeks" : Weeks,
                                         "Weight" : Weight,
                                         "Extra": Extra,
                                         "Extra2": Extra2]
        self.scenRef.updateChildValues(["/\(key)" : scenarios])
    }
    
    func getScenarios() {
        
            self.scenRef.observeSingleEvent(of: .childAdded, with: {(snapshot: DataSnapshot) in
            self.title = (snapshot.value as AnyObject).object(forKey: "Title") as! String
            self.birth = (snapshot.value as AnyObject).object(forKey: "Birth") as! String
            self.weeks = (snapshot.value as AnyObject).object(forKey: "Weeks") as! String
            self.weight = (snapshot.value as AnyObject).object(forKey: "Weight") as! String
            self.extra = (snapshot.value as AnyObject).object(forKey: "Extra") as! String
            self.extra2 = (snapshot.value as AnyObject).object(forKey: "Extra2") as! String

            self.scenarioLabel.text = "Scenario: \(String(describing: self.title))"
            self.weeksLabel.text = "\(String(describing: self.weeks)) weeks"
            self.birthType.text = "\(String(describing: self.birth))"
            self.weightLabel.text = "\(String(describing: self.weight)) kg"
            self.extraLabel.text = "\(String(describing: self.extra))"
            self.extraLabel2.text = "\(String(describing: self.extra2))"
            
        })
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
