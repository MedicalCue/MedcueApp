//
//  GameViewController.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/2/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import FirebaseDatabase

class GameViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    var pick = 0
    var scenName = ""
    var scenTitle = ""
    var ref: DatabaseReference!
    var scenRef: DatabaseReference!
    var scen = [String]()

    @IBOutlet var Scenarios: UIPickerView!
    @IBOutlet var go: UIButton!
    
    var scenario = [""]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        go.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        go.layer.cornerRadius = 15
        
        let hosp = UserDefaults.standard.string(forKey: "Hospital")
        print("hosp: \(hosp!)")
        
        self.ref = Database.database().reference()
        self.scenRef = self.ref.child("Import").child("Scenarios")
        getScenarios(hospital: hosp!)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Lato-Regular", size: 26)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = scenario[row]
        pickerLabel?.textColor = UIColor.white
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return scenario[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pick = row
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scenario.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = scenario[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        return myTitle
    }
 
    @IBAction func button(_ sender: UIButton) {
 
        scenName = scenario[pick]
        
        UserDefaults.standard.set(("\(scenName)"), forKey: "Name")
                
        let scene = HistoryScene(size: CGSize(width: 1536, height: 2048))
        self.view = SKView()
        let skView = self.view as! SKView
        scene.viewController = self
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
     
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getScenarios(hospital: String) {
        self.scenRef.observe(.value, with: {(snapshot: DataSnapshot) in
            guard var scen = (snapshot.value) as? [String] else {
                print("Error")
                return
            }
            scen.sort()
            self.scenario = scen
            self.Scenarios.reloadAllComponents()
        })
    }
    
}
