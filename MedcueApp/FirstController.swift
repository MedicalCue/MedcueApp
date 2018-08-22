//
//  ViewController.swift
//  SimCue
//
//  Created by Ardella Phoa on 8/15/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirstController: UIViewController, UITextFieldDelegate {

    var ref: DatabaseReference!
    var firstRef: DatabaseReference!
    
    @IBOutlet weak var textbox: UITextField!
    @IBOutlet var enter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     textbox.becomeFirstResponder()
        configureFields()
        configureTapGesture()
        
        self.ref = Database.database().reference()
        self.firstRef = self.ref.child("Participants")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textbox.resignFirstResponder()
        loginAttempt()
        return true
    }
    
    func configureFields()  {
        textbox.delegate = self
        enter.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        enter.layer.cornerRadius = 15
    }
    
    func configureTapGesture()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap()    {
        view.endEditing(true)
    }
    
    @IBAction func enterTapped(_ sender: Any) {
        view.endEditing(true)
        loginAttempt()
    }

    func loginAttempt() {
        
        let code = textbox.text
        
        UserDefaults.standard.set(("\(String(describing: (code)!))"), forKey: "Code")
        
        
        self.firstRef.observe(.value, with: {(snapshot: DataSnapshot) in
            print(snapshot.value!)
            if snapshot.exists() {
                print("\nyes\n")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "success") as UIViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = view
            }
            else    {
                let alert = UIAlertController(title: "Error", message: "Please input hospital code to enter simulation. If you do not have a code, proceed to the next page.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: self.proceed))
                self.present(alert, animated: true)
            }
            
        })
      /*
        if code == "dummy" || code == "scripps"  {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "success") as UIViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = view
        }
        else    {
            let alert = UIAlertController(title: "Error", message: "Please input hospital code to enter simulation. If you do not have a code, proceed to the next page.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: proceed))
            self.present(alert, animated: true)
        }*/
    }
    
    func proceed(action: UIAlertAction) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "new") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = view
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
