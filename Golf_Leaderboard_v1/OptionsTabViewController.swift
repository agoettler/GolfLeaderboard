//
//  OptionsTabViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/15/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class OptionsTabViewController: UIViewController {

    
    var alertVC: UIAlertController!
    
    @IBAction func leaveGameButtonPressed() {
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func leaveGame() {
        print("leaving game...")
        performSegue(withIdentifier: "leaveGameSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertVC = UIAlertController.init(title: "Leave Game", message: "Are you sure?", preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in print("no pressed") }))
        
        alertVC.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { action in self.leaveGame() }))
        

        
        
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
