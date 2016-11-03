//
//  TitleViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class TitleViewController: UIViewController {

    var ref: FIRDatabaseReference!
    var courseListImporterObject: CourseListImporter!
    var eventImporterObject: EventImporter!
    var ourCourses: [Course]!
    var ourEvents: NSDictionary!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //ourEvents = EventImporter.getEvents()

        ourCourses = CourseListImporter.getCourses()
        // print("Courses: \(ourCourses.count)")
        
        if(segue.identifier == "goToCreateEventVC"){
            let destVC: CreateEventViewController = segue.destination as! CreateEventViewController
            destVC.availableCourses = ourCourses
            destVC.courseOptions = courseListImporterObject.getCourseNames()
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print()
        print("TitleViewController: viewDidLoad")
        print()
        ref = FIRDatabase.database().reference()
        courseListImporterObject = CourseListImporter.init()
        ourCourses = CourseListImporter.coursesArray

        // print("Courses count: \(ourCourses.count)")
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
