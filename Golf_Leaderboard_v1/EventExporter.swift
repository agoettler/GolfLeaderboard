//
//  EventExporter.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
import Firebase

public class EventExporter{
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    
    public init(currentEvent: Event){
        
        let name: String = currentEvent.name
        //let owner: String = currentEvent.owner
        //let course: String = currentEvent.course.name
        //let gameType: String = currentEvent.type
        print()
        print(name)
        print()
        
        let key = self.ref.child("Events/\(name)")
        print("KEY: \(key)")
        
        let updates = currentEvent.toAnyObject()
        key.setValue(updates)
        
        
        
        
        
    }
    
    
    
    
}
