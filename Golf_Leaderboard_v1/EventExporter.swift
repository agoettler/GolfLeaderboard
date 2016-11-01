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
        
        let updates = EventExporter.toAnyObject(event: currentEvent)
        key.setValue(updates)
        
        
        
        
        
    }
    
    public static func toAnyObject(event: Event) -> Any{
        
        let holePrizesDictionary: NSDictionary = NSDictionary()
        
        for aPrize in event.holePrizes {
            holePrizesDictionary.setValue(aPrize.currentWinner, forKey: aPrize.prize)
        }
        
        let playerDictionary: NSDictionary = NSDictionary()
        
        for aPlayer in event.players {
            playerDictionary.setValue(["Current Hole": aPlayer.currentHole, "Handicap": aPlayer.handicap, "Start Hole": aPlayer.startHole], forKey: aPlayer.name)
        }
        
        return [
            "Course": event.course.name,
            "Owner": event.owner,
            "GameType": event.type,
            "Hole Prizes": "Null",
            "Players": "Null"
            //"Players": ["Adam1":["Current Hole": 5,"Gross Score":42, "Net Score": 42, "Handicap": 12, "Start Hole": 4]]
        ]
    }
    
    
    
}
