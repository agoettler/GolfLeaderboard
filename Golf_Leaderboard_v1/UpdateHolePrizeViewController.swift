//
//  UpdateHolePrizeViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/26/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase

class UpdateHolePrizeViewController: UIViewController {
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var leaderLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var claimHolePrizeButton: UIButton!
    
    var selectedPrize: HolePrize!
    var name: String!
    var leader: String!
    
    @IBAction func claimHolePrizePressed(_ sender: UIButton) {
        print("HP select \(selectedPrize.prize)")
        
        if(globals.role == "player"){
            leader = globals.globalPlayer.name
            selectedPrize.currentWinner = leader
            leaderLabel.text = leader
            EventExporter.updateHolePrizes(holePrize: selectedPrize)
        }
        else{
            errorLabel.text = "Error: Spectators cannot win hole prizes"
        }
        // will update the current leader with the name of the player who pressed it
        // dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        prizeLabel.text = selectedPrize.prize
        leaderLabel.text = selectedPrize.currentWinner
        if(globals.role != "player"){
            claimHolePrizeButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UpdateHolePrizeViewController Did Load")
        self.navigationController?.setNavigationBarHidden(false, animated: false)

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
