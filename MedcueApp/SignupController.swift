//
//  SignupController.swift
//  SimCue
//
//  Created by Ardella Phoa on 8/20/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class SignupController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet var first: UITextField!
    @IBOutlet var hospital: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var submit: UIButton!
    
    var ref: DatabaseReference!
    var signRef: DatabaseReference!
    
    var name: String = ""
    var hospit: String = ""
    var mail: String = ""
    var number: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
        configureTapGesture()
        
        self.ref = Database.database().reference()
        self.signRef = self.ref.child("Export").child("Signups")
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
        
        self.phone.resignFirstResponder()
        
        name = self.first.text!
        hospit = self.hospital.text!
        mail = self.email.text!
        number = self.phone.text!
        let status = "Failed"
        
        if name.isEmpty == true || hospit.isEmpty == true || mail.isEmpty == true || number.isEmpty == true  {
            self.error()
            return
        }
        
        let info: Dictionary =  ["Name": name,
                                 "Hospital": hospit,
                                 "Email": mail,
                                 "Phone": number,
                                 "Status": status] as [String : Any]

        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail()    {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else    {
            showMailError()
        }
        
        let ref = self.signRef.child("\(number)")
        ref.setValue(info)

    }
    
    func configureMailController() -> MFMailComposeViewController   {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["marie.alexander@medicalcue.com"])
        mailComposerVC.setSubject("SimCue Signup")
        mailComposerVC.setMessageBody("Hello,\n\nMy name is \(name) and I would like to sign up to use SimCue.\n\nName: \(name)\nHospital: \(hospit)\n Email: \(mail)\n Phone Number: \(number)\n\nThanks,\n\(name)", isHTML: false)
        
        return mailComposerVC
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            print("Mail cancelled")
            self.signRef.child("\(number)").child("Status").setValue("Cancelled")
            showMailError()
        case .saved:
            print("Mail saved")
            self.signRef.child("\(number)").child("Status").setValue("Saved")
            showMailError()
        case .sent:
            print("Mail sent")
            self.signRef.child("\(number)").child("Status").setValue("Sent")
            let alert = UIAlertController(title: "Thank You", message: "You will receive an email when your hospital has been approved.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Home", style: .default, handler: self.proceed))
            self.present(alert, animated: true)
        case .failed:
            print("failed")
            self.signRef.child("\(number)").child("Status").setValue("Failed")
            showMailError()
        }

    }
    
    func showMailError()    {
        let alert = UIAlertController(title: "Error", message: "Send an email to signup.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func error()    {
        let alert = UIAlertController(title: "Error", message: "All fields are required to proceed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func proceed(action: UIAlertAction) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "first") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = view
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
