//
//  JoinEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class JoinEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    @IBOutlet weak var playerNameTextField: UITextField!

    @IBOutlet weak var handicapPicker: UIPickerView!
    @IBOutlet weak var startHolePicker: UIPickerView!
    
    @IBOutlet weak var playerNameErrorLabel: UILabel!
    
    
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    let handicapData = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    let holeData = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"]
    
    var player: Player!
    var currentEventName: String!
    var currentEvent: Event!
    
    @IBAction func joinButtonPressed(_ sender: UIButton) {
        let name = playerNameTextField.text
        let handicap = handicapPicker.selectedRow(inComponent: 0)
        let startHole = startHolePicker.selectedRow(inComponent: 0) + 1
        
        let whiteSpaceSet = NSCharacterSet.whitespaces
        let trimmedString = name?.trimmingCharacters(in: whiteSpaceSet)

        if(currentEvent.containsPlayer(name: name!)){
            playerNameTextField.text = ""
            playerNameErrorLabel.text = "Error: Name Taken"
        }
        else if ((trimmedString?.isEmpty)!){
            playerNameTextField.text = ""
            playerNameErrorLabel.text = "Error: Invalid Name"
        }
        else
        {
            playerNameTextField.text = ""
            let emptyCard: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
            player = Player(name: name!, handicap: handicap, startHole: startHole, card: emptyCard)
            currentEvent.addPlayer(newPlayer: player)
            EventExporter.addPlayer(player: player, event: currentEvent)
            
            globals.globalPlayer = player // make this new player the global player
            performSegue(withIdentifier: "goToScoreEntryVC", sender: self)
        }

    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView===startHolePicker){
            return holeData.count
        }
        else{
            return handicapData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView===startHolePicker){
            return holeData[row]
        }
        else{
            return handicapData[row]
        }
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("JoinEventViewController: viewDidLoad")

        
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) 
    {
        print("JoinEventViewController: prepare for segue")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
