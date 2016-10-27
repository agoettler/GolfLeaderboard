//
//  CourseListImporter.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
import Firebase

class CourseListImporter {
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()

    static var courseListObject:CourseList!
    
    // get the array of courses from database
    // for each course, create a course object and append it to courseListObject
    func getCourses(){
        self.ref.child("Courses").observe(FIRDataEventType.value, with: {(snapshot) in
            let importedCourses = snapshot.value as? [String]
            
            print(importedCourses?[0])
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
}
