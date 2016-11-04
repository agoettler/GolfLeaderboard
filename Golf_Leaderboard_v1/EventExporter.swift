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
    
    static var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    static let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    public init(currentEvent: Event){
        
        let name: String = currentEvent.name
        //let owner: String = currentEvent.owner
        //let course: String = currentEvent.course.name
        //let gameType: String = currentEvent.type
        
        let key = EventExporter.ref.child("Events/\(name)")
        print("KEY: \(key)")
        let updates = EventExporter.toAnyObject(event: currentEvent)
        key.setValue(updates)
    }
    
    public static func toAnyObject(event: Event) -> Any{
        
        var hpDictionary: Dictionary<String,String> = Dictionary()

        for aPrize in event.holePrizes {
            print("\(aPrize.prize)")
            print("Winner: \(aPrize.currentWinner)")
            let prizeKey: String = aPrize.prize
            hpDictionary.updateValue(aPrize.currentWinner, forKey: prizeKey)
        }
        
        /*
        let playerDictionary: NSDictionary = NSDictionary()
        
        for aPlayer in event.players {
            print("PLAYER HERE")
            playerDictionary.setValue(["Current Hole": aPlayer.currentHole, "Handicap": aPlayer.handicap, "Start Hole": aPlayer.startHole], forKey: aPlayer.name)
        }
        */
        return [
            "Course": event.course.name,
            "Owner": event.owner,
            "GameType": event.type,
            "Hole Prizes": hpDictionary,
            "Players": "Null"
        ]
    }
    
    // Function to add a new player to the database
    // Format for the new player -> "Players": ["Adam1":["Current Hole": 5,"Gross Score":42, "Net Score": 42, "Handicap": 12, "Start Hole": 4]]

    public static func addPlayer(player: Player, event: Event)
    {
        let key = ref.child("Events/\(event.name)/Players/\(player.name)")
        print("addPlayer key: \(key)")
        
        let updates = exportPlayer(player: player)
        
        key.setValue(updates)
        
        
    }
    
    // Function to format a player's information for the database
    public static func exportPlayer(player: Player) -> NSDictionary
    {
        
        var scoreString:String = ""
        
        for hole in player.scorecard.grossScoreArray{
            scoreString += "\(hole),"
        }
        scoreString.remove(at: scoreString.index(before: scoreString.endIndex))
        
        return ["Current Hole": player.currentHole, "Handicap": player.handicap, "Start Hole": player.startHole, "Scorecard": scoreString]
    }
    
    // Function to update hole prizes in the database
    public static func updateHolePrizes(holePrize: HolePrize){
        let eventName:String = globals.globalEvent.name
        let key = ref.child("Events/\(eventName)/Hole Prizes/\(holePrize.prize)")
        let updates = globals.globalPlayer.name
        
        key.setValue(updates)
        
    }
    
    public static func updatePlayerScorecardInDatabase(){
        let player:Player = globals.globalPlayer
        let event:Event = globals.globalEvent
        
        let key = ref.child("Events/\(event.name)/Players/\(player.name)/Scorecard")
        print("scorecard key: \(key)")
        
        var scoreString:String = ""
        
        for hole in player.scorecard.grossScoreArray{
            scoreString += "\(hole),"
        }
        
        scoreString.remove(at: scoreString.index(before: scoreString.endIndex))
        
        key.setValue(scoreString)
        
        let key2 = ref.child("Events/\(event.name)/Players/\(player.name)/Current Hole")
        
        key2.setValue(player.currentHole)

        
    }
    
}
