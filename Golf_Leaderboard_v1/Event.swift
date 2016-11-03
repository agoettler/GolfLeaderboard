//
//  Event.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
//import Firebase

class Event
{
    
    public func getPlayerNames() -> [String]
    {
        var playerNamesArray: [String] = [String]()
        
        /*
        var i : Int = 0
        
        while(i<players.count)
        {
            playerNamesArray.append(players[i].name)
            i = i + 1;
        }
        */
        
        // get Swifty
        for player in players
        {
            playerNamesArray.append(player.name)
        }
        
        return playerNamesArray
    }
    
    // get Swift-ier
    public func containsPlayer(name: String) -> Bool
    {
        // we can actually specify what the .contains method "looks at" using a closure
        return players.contains(where: {(element: Player) -> Bool in element.name == name})
    }
}
