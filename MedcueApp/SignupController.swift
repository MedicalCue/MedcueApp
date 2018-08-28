//
//  SignupController.swift
//  SimCue
//
//  Created by Ardella Phoa on 8/20/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit

class SignupController: UIViewController, UITextFieldDelegate {

    @IBOutlet var first: UITextField!
    @IBOutlet var hospital: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
        configureTapGesture()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        first.resignFirstResponder()
        
        if textField == first   {
            hospital.becomeFirstResponder()
        }
        else if textField == hospital   {
            hospital.resignFirstResponder()
            email.becomeFirstResponder()
        }
        else if textField == email  {
            email.resignFirstResponder()
            phone.becomeFirstResponder()
        }
        else    {
            phone.resignFirstResponder()
        }
        return true
    }
    
    func configureFields()  {
        first.delegate = self
        hospital.delegate = self
        email.delegate = self
        phone.delegate = self
        
        submit.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        submit.layer.cornerRadius = 15
    }
    
    func configureTapGesture()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignupController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func submit(_ sender: Any) {
        
        let first = self.first.text
        let hosp = self.hospital.text
        let email = self.email.text
        let phone = self.phone.text
        
        if first?.isEmpty == true || hosp?.isEmpty == true || email?.isEmpty == true || phone?.isEmpty == true  {
            self.error()
            return
        }

        UserDefaults.standard.set(first, forKey: "SignName")
        UserDefaults.standard.set(hosp, forKey: "SignHospital")
        UserDefaults.standard.set(email, forKey: "SignEmail")
        UserDefaults.standard.set(phone, forKey: "SignPhone")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "gvc") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = view
        
    }
    
    func error()    {
        let alert = UIAlertController(title: "Error", message: "All fields are required to proceed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func handleTap()    {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
