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
    var globals: CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    public static var exisitingNames: [String]!
    var exisitingEventDictionary: NSDictionary!
    // public static var exisitingEvents: NSDictionary!
    public static var exisitingEvents: [Event] = [Event]()

    public init(){
        // search for exisitng events int the database
        // EventImporter.exisitingEvents = NSDictionary()
        self.ref.child("Events").observe(FIRDataEventType.value, with: {(snapshot) in
            self.exisitingEventDictionary = snapshot.value as? NSDictionary
            print()
            print(snapshot.value!)
            print()
            
            EventImporter.exisitingNames = self.exisitingEventDictionary?.allKeys as! [String] // put exisitng event names into the exisitingNames array

            var i: Int = 0
            while(i<EventImporter.exisitingNames.count){
                let eventData = self.exisitingEventDictionary.value(forKey: EventImporter.exisitingNames[i]) as! NSDictionary
                
                let name = EventImporter.exisitingNames[i]
                //let owner = eventData.value(forKey: "Owner") as! NSDictionary
                let owner = eventData.value(forKey: "Owner") as! String

                let type: String = eventData.value(forKey: "GameType") as! String
                let courseString: String = eventData.value(forKey: "Course") as! String
                //let cLI : CourseListImporter = CourseListImporter()
                let course:Course = CourseListImporter.getCurrentCourse(name: courseString)
                var j: Int = 0
                var playerArray: [Player] = [Player]()
                
                if let playerInDict:NSDictionary = eventData.value(forKey: "Players") as? NSDictionary {
                
                    let pNames: [String] = playerInDict.allKeys as! [String]
                    print("pNames \(pNames.count)")

                    while(j<pNames.count){
                    
                        let pValue: NSDictionary = playerInDict.value(forKey: pNames[j]) as! NSDictionary
                        let currHandicap: Int = pValue.value(forKey: "Handicap") as! Int
                        let startHole: Int = pValue.value(forKey: "Start Hole") as! Int
                        let currentHole: Int = pValue.value(forKey: "Current Hole") as! Int

                        let currScoreCardString: String = pValue.value(forKey: "Scorecard") as! String

                        let currScoreCardArray: [String] = currScoreCardString.components(separatedBy: ",")
                        var currScorecard: [Int] = [Int]()
                        
                        for aString in currScoreCardArray{
                            currScorecard.append(Int(aString)!)
                        }
                        
                        print("pValue \(pValue)")
                        let newPlayer: Player = Player(name: pNames[j], handicap: currHandicap, startHole: startHole, card: currScorecard, currentHole: currentHole)
                    
                        playerArray.append(newPlayer)
                    
                        j = j + 1
                    }
                }
//                print("Name \(name)")
//                print("Owner \(owner)")
//                print("gametype \(type)")
//                print("courseString \(courseString)")
//                print("Course \(course)")
//                print("pNames \(pNames)")
                var holePrizeArray: [HolePrize] = [HolePrize]()
                var sortedHolePrizeArray: [HolePrize] = [HolePrize]()

                let holePrizeForEvent = eventData.value(forKey: "Hole Prizes")
//                print("HPS: \(holePrizeForEvent)")

                if(holePrizeForEvent != nil){
                    j = 0
                    let holePrizeDictionary: NSDictionary = eventData.value(forKey: "Hole Prizes") as! NSDictionary

                    for aPrize in holePrizeDictionary {
                    
                        let newPrize: HolePrize = HolePrize(incomingPrize: aPrize.key as! String, incomingWinner: aPrize.value as! String)
                        holePrizeArray.append(newPrize)
                    
                        j = j + 1
                    }
                    
                    if(holePrizeArray.count > 1){
                        var holeOptions:[Int] = [Int]()
                        for aPrize in holePrizeArray{
                            let prizeSplit:[String] = aPrize.prize.components(separatedBy: " ")
                            let removedColon:String = prizeSplit[1].substring(to: prizeSplit[1].index(prizeSplit[1].endIndex, offsetBy: -1))
                            let extractedNum: Int = Int(removedColon)!
                            holeOptions.append(extractedNum)
                            //print("PrizeSplit[0]: \(prizeSplit[0])")
                            //print("PrizeSplit[1]: \(prizeSplit[1])")
                            //print("PrizeSplit[2]: \(prizeSplit[2])")
                            //print("Extracted num: \(removedColon)")
                            
                        }
                        
                        holeOptions.sort()
                        var counter:Int = 0
                        for aOption in holeOptions{
                            
                            for aPrize in holePrizeArray{
                                if(aPrize.prize.contains("Hole \(aOption):")){
                                    sortedHolePrizeArray.append(aPrize)
                                }
                            }
                            
                             print("aOption: \(aOption)")
                             print("sortedHolePrizeArray: \(sortedHolePrizeArray[counter])")

                            counter += 1;
                            
                        }
                        
                       

                    }
                    
                }
                

                print("sorted count \(sortedHolePrizeArray.count)")

                
                
                
                let nextEvent: Event = Event(name: name, owner: owner, type: type, course: course, players: playerArray, holePrizes: sortedHolePrizeArray)
                EventImporter.exisitingEvents.append(nextEvent)
                
                if(self.globals.globalEvent != nil && nextEvent.name == self.globals.globalEvent.name){
                    self.globals.globalEvent = nextEvent
                }
                
                
                i = i + 1
            }
 
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    
    public static func getExisitingEventNames() -> [String]{
       // print()
       // print("\(exisitingNames)")
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
