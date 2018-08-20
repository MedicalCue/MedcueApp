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
    
    let p1 = UserDefaults.standard.string(forKey: "Part1")!
    let p2 = UserDefaults.standard.string(forKey: "Part2")!
    let p3 = UserDefaults.standard.string(forKey: "Part3")!
    let p4 = UserDefaults.standard.string(forKey: "Part4")!
    
    
    var pick = 0
    var scenName = ""
    var scenTitle = ""
    var ref: DatabaseReference!
    var scenRef: DatabaseReference!
    
    @IBOutlet var Scenarios: UIPickerView!
    
    let scenario = ["Scenario A", "Scenario B", "Scenario C", "Scenario D", "Scenario E", "Scenario F", "Scenario G"]
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("\n\nIN GVC\n\np1: \(String(describing: p1)), p2: \(String(describing: p2)), p3: \(String(describing: p3)), p4: \(String(describing: p4))")
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
