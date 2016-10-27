//
//  CreateEventViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class CreateEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var ref: FIRDatabaseReference!

    var availableCourses:CourseList?
    
    @IBOutlet weak var eventNameTextField: UITextField!
    
    @IBOutlet weak var selectCoursePicker: UIPickerView!
    @IBOutlet weak var gameTypePicker: UIPickerView!
    
    var courseOptions = ["Brown Deer"]
    
    var gameTypes = ["Stroke Play","Best Ball","Scramble","Alternate Shot"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView===gameTypePicker){
            return gameTypes.count
        }
        else{
            return courseOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView===gameTypePicker){
            return gameTypes[row]
        }
        else{
            return courseOptions[row]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("CreateEventViewController: viewDidLoad")
        ref = FIRDatabase.database().reference()

        /*
        if let courses = CourseImporter.getCourses(){
            availableCourses = courses
            
        }
        else{
            print("No available courses")
        }
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("CreateEventViewController: prepare")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
