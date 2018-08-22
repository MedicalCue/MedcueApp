//
//  SuccessController.swift
//  SimCue
//
//  Created by Ardella Phoa on 8/17/18.
//  Copyright © 2018 MedicalCue. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import FirebaseDatabase


class SuccessController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    var successRef: DatabaseReference!

    var participants = [String]()
    var partList: [String] = []
    
    @IBOutlet var part1: UIPickerView!
    @IBOutlet var table: UITableView!
    @IBOutlet var add: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        self.ref = Database.database().reference()
        self.successRef = self.ref.child("Participants")
        
        let codeName = UserDefaults.standard.string(forKey: "Code")!
        getInfo(codeName: (codeName))
        
        part1.delegate = self
        part1.dataSource = self
        table.delegate = self
        table.dataSource = self
        
        add.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        add.layer.cornerRadius = 15
        
    }
    

    @IBAction func add(_ sender: Any) {
        
        if partList.count == 4  {
            print("returning")
            part1.selectRow(0, inComponent: 0, animated: true)
            return
        }
        else    {
            if partList.contains(participants[part1.selectedRow(inComponent: 0)])   {
                part1.selectRow(0, inComponent: 0, animated: true)
                return
            }
            if participants[part1.selectedRow(inComponent: 0)] == "Select Participant"  {
                return
            }
            table.reloadData()
            partList.append(participants[part1.selectedRow(inComponent: 0)])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (partList.count+1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.partList[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Lato-Regular", size: 20)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.black
        return cell
    }
    

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let label = (view as? UILabel) ?? UILabel()
        label.font = UIFont(name: "Lato-Regular", size: 20)
        return participants.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return participants[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = participants[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Lato-Regular", size: 26)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = participants[row]
        pickerLabel?.textColor = UIColor.white
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    @IBAction func next(_ sender: Any) {
        print("plcount: \(partList.count)")
        if partList.count == 0  {
            print("got in here")
            let alert = UIAlertController(title: "Error", message: "Please select at least one participant.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        UserDefaults.standard.set(partList, forKey: "Parts")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getInfo(codeName: String)  {
        
        self.successRef.child("\(codeName)").observe(.value, with: {(snapshot: DataSnapshot) in
            guard let dict = (snapshot.value)! as? [String] else {
                print("Error\n")
                print((snapshot.value)!)
                return
            }
            print(dict)
            self.participants = dict
            self.part1.reloadAllComponents()
        })
    }
    
}