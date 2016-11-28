//
//  OptionsTabViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/15/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class OptionsTabViewController: UIViewController {

    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData

    var alertVC: UIAlertController!
    
    @IBAction func leaveGameButtonPressed() {
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func leaveGame() {
        print("leaving game...")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateInitialViewController()
        self.navigationController?.present(homeVC!, animated: false, completion: nil)
        var viewcontrollers = self.navigationController?.viewControllers
        viewcontrollers?.removeAll()
        viewcontrollers?.append(homeVC!)
        globals.globalEvent = nil
        globals.globalPlayer = nil
        
        
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
