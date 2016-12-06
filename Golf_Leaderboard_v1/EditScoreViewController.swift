//
//  EditScoreViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Andrew Goettler on 12/5/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class EditScoreViewController: UIViewController
{
    let scorecard = CurrentEventGlobalAccess.globalData.globalPlayer.scorecard
    
    var selectedHole: Hole? = nil
    
    @IBOutlet weak var holeLabel: UILabel!
    @IBOutlet weak var yardageLabel: UILabel!
    @IBOutlet weak var parLabel: UILabel!
    @IBOutlet weak var handicapLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("EditScoreViewController: viewDidLoad")
        
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //configure the stepper
        configureStepper()
        
        // configure the labels
        configureLabels(hole: selectedHole!)
    }
    
    func configureStepper()
    {
        scoreStepper.stepValue = 1
        scoreStepper.minimumValue = 1
        scoreStepper.maximumValue = 15
        scoreStepper.value = Double(scorecard[selectedHole!.number].grossScore)
    }
    
    func configureLabels(hole: Hole)
    {
        holeLabel.text = "\(hole.number)"
        yardageLabel.text = "\(hole.yardage)"
        parLabel.text = "\(hole.par)"
        handicapLabel.text = "\(hole.handicap)"
        scoreLabel.text = "\(Int(scoreStepper.value))"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scoreStepperPressed(_ sender: UIStepper)
    {
        scoreLabel.text = "\(Int(scoreStepper.value))"
    }

    @IBAction func submitPressed(_ sender: UIButton)
    {
        print("Editing score for hole \(selectedHole!.number)  to \(Int(scoreStepper.value))")
        
        scorecard.updateScore(holeNumber: selectedHole!.number, grossScore: Int(scoreStepper.value))
        
        EventExporter.updatePlayerScorecardInDatabase()
        
        // not sure why assigning it to a variable is necessary
        let _ = self.navigationController!.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) 
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
