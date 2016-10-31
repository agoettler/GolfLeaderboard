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
    public static var exisitingNames: [String]!
    var exisitingEventDictionary: NSDictionary!
   // public static var exisitingEvents: NSDictionary!
    public static var exisitingEvents: [Event] = [Event]()

    public init(){
        // search for exisitng events int the database
        // EventImporter.exisitingEvents = NSDictionary()
        self.ref.child("Events").observe(FIRDataEventType.value, with: {(snapshot) in
            self.exisitingEventDictionary = snapshot.value as? NSDictionary
            EventImporter.exisitingNames = self.exisitingEventDictionary?.allKeys as! [String] // put exisitng event names into the exisitingNames array

            var i: Int = 0
            while(i<EventImporter.exisitingNames.count){
                let eventData = self.exisitingEventDictionary.value(forKey: EventImporter.exisitingNames[i]) as! NSDictionary
                
                let name = EventImporter.exisitingNames[i]
                let owner = eventData.value(forKey: "Owner") as! NSDictionary
                let type: String = eventData.value(forKey: "GameType") as! String
                let courseString: String = eventData.value(forKey: "Course") as! String
                //let cLI : CourseListImporter = CourseListImporter()
                let course:Course = CourseListImporter.getCurrentCourse(name: courseString)
                let playerInDict:NSDictionary = eventData.value(forKey: "Players") as! NSDictionary
                var playerArray: [Player] = [Player]()
                
                let pNames: [String] = playerInDict.allKeys as! [String]
                
                var j: Int = 0

                while(j<pNames.count){
                    
                    let pValue: NSDictionary = playerInDict.value(forKey: pNames[i]) as! NSDictionary
                    let currHandicap: Int = pValue.value(forKey: "Handicap") as! Int
                    let startHole: Int = pValue.value(forKey: "Start Hole") as! Int

                    print("pValue \(pValue)")
                    let newPlayer: Player = Player(name: pNames[i], handicap: currHandicap, startHole: startHole)
                    
                    playerArray.append(newPlayer)
                    
                    j = j + 1
                }
                
                print("Name \(name)")
                print("Owner \(owner)")
                print("gametype \(type)")
                print("courseString \(courseString)")
                print("Course \(course)")
                print("pNames \(pNames)")
                
                
                while(j<pNames.count){
                    
                    let pValue: NSDictionary = playerInDict.value(forKey: pNames[i]) as! NSDictionary

                    let newPlayer: Player = Player(name: pNames[i], handicap: pValue.value(forKey: "Handicap") as! Int, startHole: pValue.value(forKey: "StartHole") as! Int)
                    
                    playerArray.append(newPlayer)
                    
                    j = j + 1
                }
                
                //let holePrizeInDict:NSDictionary = eventData.value(forKey: "HolePrizes") as! NSDictionary
                let holeArray: [HolePrize] = [HolePrize]()
                j = 0
                /*
                while(j<holePrizeInDict.count){
                    
                    let newPrize: HolePrize = HolePrize(incomingPrize: holePrizeInDict.value(forKey: "Prize") as! String, incomingWinner: holePrizeInDict.value(forKey: "Winner") as! String)
                    playerArray.append(newPlayer)
                    
                    j = j + 1
                }
                */
                
                let nextEvent: Event = Event(name: name, owner: owner.value(forKey: "Name") as! String, type: type, course: course, players: playerArray, holePrizes: holeArray)
                EventImporter.exisitingEvents.append(nextEvent)
                
                
                i = i + 1
            }
 
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    
    public static func getExisitingEventNames() -> [String]{
        print()
        print("\(exisitingNames)")
        return exisitingNames
    }
    
    public static func getSpecificEvent(name: String) -> Event {
        var i:Int = 0
        var desiredEventIndex:Int = 0
        while(i<exisitingEvents.count){
            if(exisitingEvents[i].name == name){
                desiredEventIndex = i
            }
            i = i + 1
        }
        
        return EventImporter.exisitingEvents[desiredEventIndex]

    }
    
    public static func getEvents() -> [Event]{
        return EventImporter.exisitingEvents
    }
    
    
}
