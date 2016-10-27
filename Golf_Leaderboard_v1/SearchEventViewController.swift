//
//  SearchEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class SearchEventViewController: UIViewController {

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    
    var eventName:String = ""
    var eventImporterObject: EventImporter!
    var exisitingNames:[String] = [String]()
    
    
    @IBAction func FindButtonPressed(_ sender: UIButton) {
        eventName = eventNameTextField.text!
        exisitingNames = eventImporterObject.getExisitingEventNames()
        
        if(exisitingNames.contains(eventName)){
            if(roleSegmentedControl.selectedSegmentIndex == 0){
                //let destVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "JoinEventVC")
                // present(destVC, animated: true, completion: nil)
                performSegue(withIdentifier: "goToJoinEvent", sender: self)
            }
            else{
                performSegue(withIdentifier: "goToSpectatorTabBar", sender: self)
            }
        }
        else{
            eventNameTextField.text = ""
            errorLabel.text = "Error: Event Does Not Exist"
        }
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("SearchEventViewController: viewDidLoad")
        eventNameTextField.text = eventName
        eventImporterObject = EventImporter()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
