//
//  EventImporter.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
import Firebase

class EventImporter{
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var exisitingNames: [String]!
    var exisitingEventDictionary: NSDictionary!
    var exisitingEvents: [Event] = [Event]()
    
    public init(){
        // search for exisitng events int the database
        self.ref.child("Events").observe(FIRDataEventType.value, with: {(snapshot) in
            self.exisitingEventDictionary = snapshot.value as? NSDictionary
            self.exisitingNames = self.exisitingEventDictionary?.allKeys as! [String] // put exisitng event names into the exisitingNames array

            var i: Int = 0
            while(i<self.exisitingNames.count){
                let eventData:NSDictionary = self.exisitingEventDictionary.value(forKey: self.exisitingNames[i]) as! NSDictionary
                
                let name = self.exisitingNames[i]
                let owner: String = eventData.value(forKey: "Owner") as! String
                let type: String = eventData.value(forKey: "GameType") as! String
                let courseString: String = eventData.value(forKey: "Course") as! String
                let cLI : CourseListImporter = CourseListImporter()
                let course:Course = cLI.getCurrentCourse(name: courseString)
                
                
                
                
                let nextEvent: Event = Event(name: name, owner: owner as! String, type: type as! String, course: course, players: <#T##[Player]#>, holePrizes: <#T##[HolePrize]#>)
                self.exisitingEvents.append(nextEvent)
                
                
                i = i + 1
            }
            
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
    func getExisitingEventNames() -> [String]{
        print()
        print("\(exisitingNames)")
        return exisitingNames
    }
    
    
    
    
    
}
