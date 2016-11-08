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
    
    var globals: CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    
    @IBOutlet weak var holeLabel: UILabel!
    @IBOutlet weak var yardageLabel: UILabel!
    @IBOutlet weak var parLabel: UILabel!
    @IBOutlet weak var handicapLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    @IBOutlet weak var submitScoreButton: UIButton!
    @IBOutlet weak var roundCompleteLabel: UILabel!
    
    
    @IBAction func scoreStepperPressed(_ sender: UIStepper) {
        let currentVal:Int = Int(scoreStepper.value)
        scoreLabel.text = "\(currentVal)"
        
    }
    
    
    @IBAction func submitScorePressed(_ sender: UIButton) {
        let currentHole: Int = globals.globalPlayer.currentHole
        let enteredScore: Int = Int(scoreLabel.text!)!
        print("CURRENT HOLE: \(currentHole)")
        globals.globalPlayer.scorecard.updateScore(holeNumber: currentHole, grossScore: enteredScore)
        
        globals.globalPlayer.goToNextHole()

        EventExporter.updatePlayerScorecardInDatabase()
        
        if(globals.globalPlayer.currentHole != -1){
            updateLabels(currentHole: globals.globalPlayer.currentHole)
            print("CURRENT HOLE 2: \(globals.globalPlayer.currentHole)")
        }
        else{
            submitScoreButton.isEnabled = true
            submitScoreButton.alpha = 0.5
            roundCompleteLabel.text = "Round Completed"
            //globals.globalPlayer.currentHole = -1
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentHole: Int = globals.globalPlayer.currentHole
        if(currentHole != -1){
            updateLabels(currentHole: currentHole)
        }
    }
    
    
    func updateLabels(currentHole: Int){
        let hole:Hole = globals.globalEvent.course[currentHole]
        holeLabel.text = "\(currentHole)"
        yardageLabel.text = "\(hole.yardage)"
        parLabel.text = "\(hole.par)"
        handicapLabel.text = "\(hole.handicap)"
        scoreLabel.text = "\(hole.par)"
        scoreStepper.value = Double(hole.par)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("ScoreEntryViewController: viewDidLoad")
        ref = FIRDatabase.database().reference()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        scoreStepper.stepValue = 1
        scoreStepper.minimumValue = 1
        scoreStepper.maximumValue = 15
        
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
