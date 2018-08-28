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
    
     var viewController: GameViewController!
    
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
        
        scenName = UserDefaults.standard.string(forKey: "Name")!
      
        self.ref = Database.database().reference()
        self.scenRef = self.ref.child("Histories")
        getScenarios(scenName: scenName)
        
        UserDefaults.standard.set(("\(title)"), forKey: "Title")
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 750, height: 112)
        logoLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.84)
        self.addChild(logoLabel)
        
        let menuButton = SKLabelNode(fontNamed: "Lato-Regular")
        menuButton.text = "<Back"
        menuButton.name = "menu"
        menuButton.fontSize = 77
        menuButton.fontColor = SKColor.white
        menuButton.position = CGPoint(x: self.size.width*0.229, y: self.size.height*0.918)
        self.addChild(menuButton)

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
        
        let key = generateRandomDigits(10)
        UserDefaults.standard.set(key, forKey: "Key")
        
        let uniqueLabel = SKLabelNode(fontNamed: "Lato-Regular")
        uniqueLabel.text = "Key: \(key)"
        uniqueLabel.fontSize = 90
        uniqueLabel.fontColor = SKColor.white
        uniqueLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.08)
        self.addChild(uniqueLabel)
        
    }
   
    func getScenarios(scenName: String) {
        self.scenRef.child("\(scenName)").observe(.value, with: {(snapshot: DataSnapshot) in
            guard var dict = snapshot.value as? [String:Any] else {
                print("Error")
                return
            }
            
            self.title = (dict["Title"])! as! String
            self.birth = (dict["Birth"])! as! String
            self.weeks = (dict["Weeks"])! as! String
            self.weight = (dict["Weight"])! as! String
            self.extra = (dict["Extra"])! as! String
            self.extra2 = (dict["Extra2"])! as! String
            
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
            if nodeITapped.name == "menu"   {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "gvc") as UIViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = view
            }
        }
    }

    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
    
}


