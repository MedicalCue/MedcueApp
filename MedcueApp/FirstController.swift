//
//  ViewController.swift
//  SimCue
//
//  Created by Ardella Phoa on 8/15/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit

class FirstController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textbox: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
   //     textbox.becomeFirstResponder()
        configureTextFields()
        configureTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textbox.resignFirstResponder()
        loginAttempt()
        return true
    }
    
    func configureTextFields()  {
        textbox.delegate = self
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
        
        if code == "dummy" || code == "scripps"  {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "success") as UIViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = view
        }
        else    {
            let alert = UIAlertController(title: "Error", message: "Please input hospital code to enter simulation. If you do not have a code, proceed to the next page.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: proceed))
            self.present(alert, animated: true)
        }
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
