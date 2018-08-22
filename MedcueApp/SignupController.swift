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
    @IBOutlet var last: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phone: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        first.becomeFirstResponder()
        configureTextFields()
        configureTapGesture()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        first.resignFirstResponder()
        
        if textField == first   {
            first.resignFirstResponder()
            last.becomeFirstResponder()
        }
        else if textField == last   {
            last.resignFirstResponder()
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
    
    func configureTextFields()  {
        first.delegate = self
        last.delegate = self
        email.delegate = self
        phone.delegate = self
    }
    
    func configureTapGesture()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstController.handleTap))
        view.addGestureRecognizer(tapGesture)
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
