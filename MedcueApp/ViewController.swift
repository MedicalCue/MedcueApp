//
//  ViewController.swift
//  MedcueApp
//
//  Created by Ardella Phoa on 7/6/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit
import SpriteKit
import FirebaseDatabase

protocol ViewControllerDelegate : NSObjectProtocol {
    func menuButtonHidden(hidden : Bool)
}

class ViewController: UIViewController, ViewControllerDelegate {
    
    let game = GameScene()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
   //     self.menuButtonHidden(hidden: false)
        
 /*     let scene2 = GameScene(size: CGSize(width: 1536, height: 2048))
        scene2.gameVCDelegate = self
        print("self: \((scene2.gameVCDelegate)!)")*/
        
        let scene = HistoryScene(size: CGSize(width: 1536, height: 2048))
        let skView = self.view as! SKView
        scene.scaleMode = .aspectFill
        scene.VCDelegate = self
        print("self: \((scene.VCDelegate)!)")
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func menuButtonHidden(hidden: Bool) {
    //    self.menu.isHidden = hidden
    }
    
    /*
    override func viewWillDisappear(_ animated: Bool) {
        game.exit()
        print("vc exit")
        print("isplayg: \(game.isPlaying)")
    }*/
    
}
