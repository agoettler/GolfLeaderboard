//
//  JoinEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class JoinEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{

    
    @IBOutlet weak var playerNameTextField: UITextField!

    @IBOutlet weak var handicapPicker: UIPickerView!
    @IBOutlet weak var startHolePicker: UIPickerView!
    
    var handicapData = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    var holeData = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView===startHolePicker){
            return holeData.count
        }
        else{
            return handicapData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView===startHolePicker){
            return holeData[row]
        }
        else{
            return handicapData[row]
        }
    }
    
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        print("JoinEventViewController: viewDidLoad")

        /*
        // Do any additional setup after loading the view.
        var index = 0
        
        while (index < 41)
        {
            if (index>0 && index<19)
            {
              //  holeData.append(index)
            }
            
            pickerData.append(index)
            
            index = index + 1
        }
        
        */
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
