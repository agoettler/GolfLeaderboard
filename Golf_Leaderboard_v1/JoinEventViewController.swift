//
//  JoinEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class JoinEventViewController: UIViewController
{

    @IBOutlet weak var handicapPicker: UIPickerView!
    
    var pickerData: [Int] = [Int]()
    
    @IBOutlet weak var startHolePicker: UIPickerView!
    
    var holeData: [Int] = [Int]()
    
    override func viewDidLoad()
    {
        print("JoinEventViewController: viewDidLoad")
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var index = 0
        
        while (index < 41)
        {
            if (index>0 && index<19)
            {
                holeData.append(index)
            }
            
            pickerData.append(index)
            
            index = index + 1
        }
        
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) 
    {
        print("JoinEventViewController: prepare for segue")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
