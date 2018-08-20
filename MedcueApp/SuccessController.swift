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

class SuccessController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var partName1 = ""
    var partName2 = ""
    var partName3 = ""
    var partName4 = ""
    var participants = [String]()
    
    @IBOutlet var part1: UIPickerView!
    @IBOutlet var part2: UIPickerView!
    @IBOutlet var part3: UIPickerView!
    @IBOutlet var part4: UIPickerView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        let codeName = UserDefaults.standard.string(forKey: "Code")!

        getInfo(codeName: (codeName))
        
        part1.delegate = self
        part2.delegate = self
        part3.delegate = self
        part4.delegate = self
        part1.dataSource = self
        part2.dataSource = self
        part3.dataSource = self
        part4.dataSource = self
        
    }
    
    func getInfo(codeName: String)  {
        if codeName == "dummy"  {
            participants = ["Select Participant", "Ardella Phoa", "Ari Brown", "Marie Alexander", "Peter David", "Peter Coehlo"]
        }
        if codeName == "scripps"    {
            participants = ["Select Participant", "Elena Aijala", "Rhoda Badillo", "Elizabeth Cruel", "Charlotte Delacruz", "Taya Delaney", "Irene Eisenhauer", "Michelle Evers", "Larisa FitzGerald", "Jenny Flickinger", "Martha Fudala", "Desiree Garner", "Danielle Hurtado", "Julie Joslin", "Marjorie Kubitz", "Alicia Lagendijk", "Michelle Landy", "Annette Linares", "MaryAnn Lugod-Manalad", "Heidi Mauricio", "Christopher McGonegal", "Michelle Merkel", "Ashley Milcarek", "Marsi Perez", "Jillian Pillsbury", "Myrna Poblete", "Marc Russell", "Jamie Sahagun", "Dorthe Smith", "Elizabeth Spooner", "Annette St. Hilaire", "Tracey Stellas", "Mia Ursini", "Sharon Wilson", "Rachel Wissner"]
        }
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
        if part2.selectedRow(inComponent: 0) == part1.selectedRow(inComponent: 0)  {
            print("same")
            part2.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func next(_ sender: Any) {
        let part1 = participants[self.part1.selectedRow(inComponent: 0)]
        let part2 = participants[self.part2.selectedRow(inComponent: 0)]
        let part3 = participants[self.part3.selectedRow(inComponent: 0)]
        let part4 = participants[self.part4.selectedRow(inComponent: 0)]
        print("p1: \(part1), p2: \(part2), p3: \(part3), p4: \(part4) ")
        
        UserDefaults.standard.set(("\(part1)"), forKey: "Part1")
        UserDefaults.standard.set(("\(part2)"), forKey: "Part2")
        UserDefaults.standard.set(("\(part3)"), forKey: "Part3")
        UserDefaults.standard.set(("\(part4)"), forKey: "Part4")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
