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
    
    @IBOutlet var Scenarios: UIPickerView!
    
    let scenario = ["Scenario: A", "Scenario: B", "Scenario: C", "Scenario: D", "Scenario: E", "Scenario: F", "Scenario: G"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let label = (view as? UILabel) ?? UILabel()
        label.font = UIFont(name: "Lato-Regular", size: 20)
        return scenario.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return scenario[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pick = row
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = scenario[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return myTitle
    }
 
    
    @IBAction func button(_ sender: UIButton) {
 
        if pick == 0 {
            scenName = "Scenario A"
            scenTitle = "A"
        }
        if pick == 1 {
            scenName = "Scenario B"
            scenTitle = "B"
        }
        if pick == 2    {
            scenName = "Scenario C"
            scenTitle = "C"
        }
        if pick == 3    {
            scenName = "Scenario D"
            scenTitle = "D"
        }
        if pick == 4    {
            scenName = "Scenario E"
            scenTitle = "E"
        }
        if pick == 5    {
            scenName = "Scenario F"
            scenTitle = "F"
        }
        if pick == 6    {
            scenName = "Scenario G"
            scenTitle = "G"
        }
       
        UserDefaults.standard.set(("\(scenName)"), forKey: "Name")
        UserDefaults.standard.set(("\(scenTitle)"), forKey: "Title")
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()

    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
