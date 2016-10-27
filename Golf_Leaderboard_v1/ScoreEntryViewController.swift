//
//  ScoreEntryViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class ScoreEntryViewController: UIViewController {
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var holeLabel: UILabel!
    @IBOutlet weak var yardageLabel: UILabel!
    @IBOutlet weak var parLabel: UILabel!
    @IBOutlet weak var handicapLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    
    
    
    @IBAction func scoreStepperPressed(_ sender: UIStepper) {
        let currentVal:Int = Int(scoreStepper.value)
        scoreLabel.text = "\(currentVal)"
        
    }
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("ScoreEntryViewController: viewDidLoad")
        ref = FIRDatabase.database().reference()

        scoreStepper.stepValue = 1
        scoreStepper.minimumValue = 1
        scoreStepper.maximumValue = 15
        scoreStepper.value = 4
        scoreLabel.text = "\(scoreStepper.value)"
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
