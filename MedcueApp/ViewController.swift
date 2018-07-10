//
//  ViewController.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/6/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController  {
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = HistoryScene(size: CGSize(width: 1536, height: 2048))
        let skView = self.view as! SKView
        scene.scaleMode = .aspectFill
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
