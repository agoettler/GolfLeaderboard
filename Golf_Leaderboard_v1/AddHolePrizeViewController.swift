//
//  AddHolePrizeViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class AddHolePrizeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var holePrizePicker: UIPickerView!
    
    
    @IBAction func SavePressed(_ sender: UIBarButtonItem) {
        print("HERE")
        
        dismiss(animated: true, completion: nil)

    }
    

    @IBAction func CancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)

    }
    
    var holeData = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"]
    
    var prizeOptions = ["Longest Drive","Longest Putt","Closest to the Pin","Alternate Shot"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(component == 0){
            return holeData.count
        }
        else{
            return prizeOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return holeData[row]
        }
        else{
            return prizeOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if(component == 0){
            return CGFloat(80)
        }
        else{
            return CGFloat(300)
        }
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