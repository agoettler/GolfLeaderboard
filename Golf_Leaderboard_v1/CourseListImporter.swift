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
    
    var coursesArray: [Course] = [Course]()
    var aCourse: Course!
    var courseNames: [String]! = [String]()
    // get the array of courses from database
    // for each course, create a course object and append it to courseListObject
    
    public init(){
        self.ref.child("Courses").observe(FIRDataEventType.value, with: {(snapshot) in
            let importedCourses = snapshot.value as? NSDictionary
            self.courseNames = importedCourses?.allKeys as! [String]
            var i:Int = 0
            while(i < self.courseNames.count){
                let courseDict: NSDictionary = importedCourses?[self.courseNames[i]] as! NSDictionary
                let courseData: [String] = courseDict.allValues as! [String]
                
                var parString: [String] = courseData[0].components(separatedBy: ",")
                var yardageString: [String] = courseData[1].components(separatedBy: ",")
                var handicapString: [String] = courseData[2].components(separatedBy: ",")
                
                var parArray: [Int] = [Int]()
                var yardageArray: [Int] = [Int]()
                var handicapArray: [Int] = [Int]()
                
                var j: Int = 0
                while(j < parString.count){
                    
                    parArray.append(Int(parString[j])!)
                    yardageArray.append(Int(yardageString[j])!)
                    handicapArray.append(Int(handicapString[j])!)
                    
                    // print(parArray[j])
                    // print(yardageArray[j])
                    // print(handicapArray[j])
                    
                    j=j+1
                }
                
                self.aCourse = Course.init(name: self.courseNames[i], yardages: yardageArray, pars: parArray)
                self.coursesArray.append(self.aCourse)
                
                //print()
                //print("A Course: \(self.aCourse.name)")
                //print()
                
                i=i+1
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        print("\(coursesArray)")
    }
    
    func getCourses() -> [Course]{
        return self.coursesArray
    }
    

    func getCourseNames() -> [String]{
        return self.courseNames
    }
    
}
