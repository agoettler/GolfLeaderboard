//
//  SearchEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class SearchEventViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    
    var eventName:String = ""
    var eventImporterObject: EventImporter!
    var exisitingNames:[String] = [String]()
    
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData // searched event will be the global event for this app

    
    @IBAction func FindButtonPressed(_ sender: UIButton)
    {
        // TODO: Move search functionality into a separate function
        // TODO: Streamline this process so the event owner doesn't need to search for their own event
        eventName = eventNameTextField.text!
        exisitingNames = EventImporter.getExisitingEventNames()
        
        if(exisitingNames.contains(eventName)){
            
            globals.globalEvent = EventImporter.getSpecificEvent(name: eventName) // set the searched event to the global event

            if(roleSegmentedControl.selectedSegmentIndex == 0){
                globals.role = "player"
                performSegue(withIdentifier: "goToJoinEvent", sender: self)
            }
            else{
                globals.role = "spectator"
                performSegue(withIdentifier: "goToSpectatorTabBar", sender: self)
            }
        }
        else{
            eventNameTextField.text = ""
            errorLabel.text = "Error: Event Does Not Exist"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("SearchEventViewController: viewDidLoad")
        eventNameTextField.text = eventName
        eventImporterObject = EventImporter()
        self.eventNameTextField.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "goToJoinEvent"){
            let destVC: JoinEventViewController = segue.destination as! JoinEventViewController
            destVC.currentEventName = eventName
            destVC.currentEvent = EventImporter.getSpecificEvent(name: eventName)
            print( "Current event: \(destVC.currentEvent.name)")

            
        }
        else{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    

}
