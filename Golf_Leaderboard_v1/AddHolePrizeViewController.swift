//
//  AddHolePrizeViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class AddHolePrizeViewController: UIViewController {

    @IBAction func SavePressed(_ sender: UIBarButtonItem) {
        print("HERE")
        dismiss(animated: true, completion: nil)

    }
    

    @IBAction func CancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)

    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("AddHolePrizeViewController: viewDidLoad")

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
