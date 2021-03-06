//
//  CreateEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class CreateEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var availableCourses:[Course]?
    var eventName:String!
    var eventType:String!
    var courseSelection:Course!
    var holePrizesArray: [HolePrize] = [HolePrize]()
    var eventImporterObject: EventImporter!
    var exisitingNames:[String] = [String]()
    var createdEvent: Event!
    
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    @IBOutlet weak var eventNameTextField: UITextField!

    @IBOutlet weak var selectCoursePicker: UIPickerView!
    @IBOutlet weak var gameTypePicker: UIPickerView!
    
    @IBOutlet weak var skinsSwitch: UISwitch!
    
    
    var courseOptions: [String]!
    var gameTypes = ["Alternate Shot","Best Ball","Scramble","Stroke Play"]
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func createEventButtonPressed(_ sender: UIButton) {
        exisitingNames = EventImporter.getExisitingEventNames()
        eventName = eventNameTextField.text
        let whiteSpaceSet = NSCharacterSet.whitespaces
        let trimmedString:String = eventName.trimmingCharacters(in: whiteSpaceSet)
        let alphaNumericSet = NSCharacterSet.alphanumerics
        var removedAllWhitespace:String = (trimmedString.replacingOccurrences(of: " ", with: ""))
        removedAllWhitespace = removedAllWhitespace.replacingOccurrences(of: "'", with: "")

        print("alphanumberic removeWhite: \(removedAllWhitespace)")
        print("alphanumberic range empty?: \(removedAllWhitespace.rangeOfCharacter(from: alphaNumericSet.inverted)?.isEmpty)")
        
        if(exisitingNames.contains(trimmedString)){
            eventNameTextField.text = ""
            errorLabel.text = "Error, Name Taken"
        }
        else if ((trimmedString.isEmpty) || (removedAllWhitespace.rangeOfCharacter(from: alphaNumericSet.inverted)?.lowerBound != removedAllWhitespace.rangeOfCharacter(from: alphaNumericSet.inverted)?.upperBound)){
            eventNameTextField.text = ""
            errorLabel.text = "Error: Invalid Name"
        }
        else{
            errorLabel.text = ""
            //eventName = eventNameTextField.text

            eventType = gameTypes[gameTypePicker.selectedRow(inComponent: 0)]
            let courseSelectionName:String = courseOptions[selectCoursePicker.selectedRow(inComponent: 0)]
            courseSelection = availableCourses?[0]

            for possibleCourse in availableCourses!{
                if(possibleCourse.name == courseSelectionName){
                    courseSelection = possibleCourse
                }
            }
            var skinsBool:Bool = false
            
            if(skinsSwitch.isOn){
                skinsBool = true
            }
            
            createdEvent = Event(name: trimmedString, owner: "Null", type: eventType, course: courseSelection, players: [], holePrizes: holePrizesArray, skins: skinsBool)
            let _ = EventExporter(currentEvent: createdEvent)
            
            globals.globalEvent = createdEvent // make the created event the global event for this app
            globals.owner = true
            
            performSegue(withIdentifier: "goToEventSearch", sender: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView===gameTypePicker){
            return gameTypes.count
        }
        else{
            return courseOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView===gameTypePicker){
            return gameTypes[row]
        }
        else{
            return courseOptions[row]
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("CreateEventViewController: viewDidLoad")
        eventImporterObject = EventImporter()
        self.eventNameTextField.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.skinsSwitch.setOn(false, animated: true)
        self.courseOptions.sort()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("CreateEventViewController: prepare")
        if(segue.identifier == "goToEventSearch"){
            let destVC:SearchEventViewController = segue.destination as! SearchEventViewController
            destVC.eventName = eventName
            //destVC.navigationController?.setNavigationBarHidden(true, animated: false)
        
        }
        else if(segue.identifier == "goToHPTableView"){
            let destVC:HolePrizesTableTableViewController = segue.destination as! HolePrizesTableTableViewController
                destVC.holePrizesArray = self.holePrizesArray
                destVC.parentVC = self
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
