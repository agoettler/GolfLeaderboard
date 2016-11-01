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
    
    public static var coursesArray: [Course] = [Course]()
    var aCourse: Course!
    var courseNames: [String]! = [String]()
    var currentCourse: Course!
    // get the array of courses from database
    // for each course, create a course object and append it to courseListObject
    
    public init(){

        self.ref.child("Courses").observe(FIRDataEventType.value, with: {(snapshot) in
            let importedCourses = snapshot.value as? NSDictionary

            self.courseNames = importedCourses?.allKeys as! [String]
            
            var i:Int = 0
            while(i < self.courseNames.count){
                let courseDict: NSDictionary = importedCourses?[self.courseNames[i]] as! NSDictionary
                
                let parString: [String] = (courseDict.value(forKey: "Par") as? String)!.components(separatedBy: ",")
                let yardageString: [String] = (courseDict.value(forKey: "Yardage") as? String)!.components(separatedBy: ",")
                let handicapString: [String] = (courseDict.value(forKey: "Handicap") as? String)!.components(separatedBy: ",")
                
                
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
                print("Course Count: \(CourseListImporter.coursesArray.count)")
                CourseListImporter.coursesArray.append(self.aCourse)
                
                //print()
                //print("A Course: \(self.aCourse.name)")
                //print()
                
                i=i+1
            }
            
        }){ (error) in
            print("Local Error")
            print(error.localizedDescription)
        }
        // print("\(CourseListImporter.coursesArray)")
    }
    
    
    public static func getCurrentCourse(name: String) -> Course{
        var i: Int = 0
        print()
        print(CourseListImporter.coursesArray.count)
        print()
        while(i < CourseListImporter.coursesArray.count){
            if(CourseListImporter.coursesArray[i].name == name){
                return CourseListImporter.coursesArray[i]
            }
            i = i + 1;
        }
        return CourseListImporter.coursesArray[0]
    }
    
    
    public static func getCourses() -> [Course]{
        return CourseListImporter.coursesArray
    }
    

    func getCourseNames() -> [String]{
        return self.courseNames
    }
    
}
