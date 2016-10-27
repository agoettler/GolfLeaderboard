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
    
    public init(){
        // search for exisitng events int the database
        self.ref.child("Events").observe(FIRDataEventType.value, with: {(snapshot) in
            self.exisitingEventDictionary = snapshot.value as? NSDictionary
            self.exisitingNames = self.exisitingEventDictionary?.allKeys as! [String] // put exisitng event names into the exisitingNames array
            
            
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
