//
//  EndScene.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/5/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import Foundation
import SpriteKit
import FirebaseDatabase

class EndScene: SKScene {
    
    var ref: DatabaseReference!
    var endRef: DatabaseReference!
    var idenRef: DatabaseReference!
    var scenRef: DatabaseReference!
    
    var scenName: String = ""
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let logoLabel = SKSpriteNode(imageNamed: "logo")
        logoLabel.size = CGSize(width: 1500/2.25, height: 224/2.25)
        logoLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.88)
        self.addChild(logoLabel)
        
        let finishedLabel = SKLabelNode(fontNamed: "Lato-Regular")
        finishedLabel.text = "Completed"
        finishedLabel.fontSize = 125
        finishedLabel.fontColor = SKColor.white
        finishedLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.625)
        self.addChild(finishedLabel)
        
        let scenLabel = SKLabelNode(fontNamed: "Lato-Regular")
        scenName = UserDefaults.standard.string(forKey: "Name")!
        scenLabel.text = "\(scenName)"
        scenLabel.fontColor = SKColor.white
        scenLabel.fontSize = 150
        scenLabel.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.72)
        self.addChild(scenLabel)
        
        let anotherRect = SKShapeNode(rectOf: CGSize(width: 425, height: 150), cornerRadius: 10)
        let color2 = UIColor(red: 0/255, green: 175/255, blue: 0/255, alpha: 1)
        anotherRect.fillColor = color2
        anotherRect.strokeColor = color2
        anotherRect.position = CGPoint(x: self.size.width/2, y: self.size.height*0.515)
        self.addChild(anotherRect)
        
        let anotherLabel = SKLabelNode(fontNamed: "Lato-Regular")
        anotherLabel.text = "Scenarios"
        anotherLabel.name = "another"
        anotherLabel.fontSize = 90
        anotherLabel.fontColor = SKColor.white
        anotherLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.50)
        self.addChild(anotherLabel)
        
        let teamRect = SKShapeNode(rectOf: CGSize(width: 425, height: 150), cornerRadius: 10)
        let color1 = UIColor(red: 0/255, green: 147/255, blue: 249/255, alpha: 1)
        teamRect.fillColor = color1
        teamRect.strokeColor = color1
        teamRect.position = CGPoint(x: self.size.width/2, y: self.size.height*0.415)
        self.addChild(teamRect)
        
        let teamLabel = SKLabelNode(fontNamed: "Lato-Regular")
        teamLabel.text = "Team"
        teamLabel.name = "team"
        teamLabel.fontSize = 90
        teamLabel.fontColor = SKColor.white
        teamLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.40)
        self.addChild(teamLabel)
        
        let quitRect = SKShapeNode(rectOf: CGSize(width: 425, height: 150), cornerRadius: 10)
        let color = UIColor(red: 255/255, green: 60/255, blue: 0/255, alpha: 1)
        quitRect.fillColor = color
        quitRect.strokeColor = color
        quitRect.position = CGPoint(x: self.size.width*0.50, y: self.size.height*0.315)
        self.addChild(quitRect)
        
        let quitLabel = SKLabelNode(fontNamed: "Lato-Regular")
        quitLabel.text = "Quit"
        quitLabel.name = "quit"
        quitLabel.fontSize = 90
        quitLabel.fontColor = SKColor.white
        quitLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.30)
        self.addChild(quitLabel)
        
        self.ref = Database.database().reference()
        self.endRef = self.ref.child("Export").child("Completed")
        
        let elapsed = UserDefaults.standard.double(forKey: "Elapsed")
        let time = UserDefaults.standard.double(forKey: "Last")
        print("elapsed: \(elapsed) & time: \(time)")
        let difference = time - elapsed
        
        if difference <= 10.0   {
            export()
        }
        else    {
            print("did not export")
        }
        
    }
    
    func export()   {
        
        self.idenRef = self.ref.child("Import").child("Identifiers")
        let parts = UserDefaults.standard.stringArray(forKey: "Parts")!
        print("parts: \(parts)")
        print("completed: \(scenName)")
        
        let Scenario = "\(self.scenName)"
        let Hospital = UserDefaults.standard.string(forKey: "Hospital")!
        let Key = UserDefaults.standard.string(forKey: "Key")!
        
        let info: Dictionary =  ["Scenario": Scenario,
                                 "Key": Key] as [String : Any]
        
        self.idenRef.child("\(Hospital)").observe(.value, with: {(snapshot: DataSnapshot) in
            guard let dict = (snapshot.value)! as? [String: Any] else {
                print("Error")
                return
            }
            
            var counter = 0
            
            while counter != parts.count    {
                let temp = parts[counter]
                let iden = dict["\((temp))"]
                print("temp: \(temp)")
                print("iden: \(iden!)")
                
                let date = NSDate()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy' 'HH:mm:ss"
                dateFormatter.timeZone = NSTimeZone.local
                let time = dateFormatter.string(from: date as Date)
                
                self.scenRef = self.endRef.child("\(Hospital)")
                let next = self.scenRef.child("\(iden!)")
                next.updateChildValues(["/\(time)" : info ])
                
                counter+=1
            }
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in:self)
            let nodeITapped = atPoint(pointOfTouch)
        
            if nodeITapped.name == "another" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "gvc") as UIViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = view
            }
            if nodeITapped.name == "quit"   {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "first") as UIViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = view
            }
            if nodeITapped.name == "team"   {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "success") as UIViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = view
            }
        }
    
    }
    
}





