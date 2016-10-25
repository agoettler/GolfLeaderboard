//
//  SearchEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class SearchEventViewController: UIViewController {

    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    
    
    @IBAction func FindButtonPressed(_ sender: UIButton) {
        
        if(roleSegmentedControl.selectedSegmentIndex == 0){
            let destVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "JoinEventVC")
            present(destVC, animated: true, completion: nil)
        }
        
    }
    
    
    
    override func viewDidLoad()
    {
        print("SearchEventViewController: viewDidLoad")
        super.viewDidLoad()

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
