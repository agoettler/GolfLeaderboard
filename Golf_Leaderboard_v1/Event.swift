//
//  Event.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
//import Firebase

/// Represents a golf event that players can join.
/// ---
/// Properties:
///     - `String` `name`: The name of the event.
///     - `String` `owner`: The name of the player that created and owns this event.
///     - `Course` `course`: The golf course where this event is played.
///     - 'String` `type`: The type of event being played - scramble, best ball, etc.
///     - `[Player]` `players`: An array of the players joined to this event.
///     - `[HolePrize]` `holePrizes`: An array of the hole prizes available in this event.
public class Event
{
    public let name: String
    
    public let owner: String
    
    public let type: String
    
    public let course: Course
    
    public var skins: Bool
    
    public var players: [Player] = []
    
    public var holePrizes: [HolePrize] = []
    
    // TODO: Add leaderboard later
    
    /// The default initializer for the `Event` class.
    /// Creates an `Event` with empty arrays of players and hole prizes, which can be added later.
    /// The properties set by this initializer are declared constant, as they do not change after event creation.
    /// - parameters:
    ///     - name: The name of the event.
    ///     - owner: The name of the player that created and owns this event.
    ///     - type: The type of event being played.
    ///     - course: The golf course where this event is played.
    public init(name: String, owner: String, type: String, course: Course, skins: Bool)
    {
        self.name = name
        self.owner = owner
        self.type = type
        self.course = course
        self.skins = true
    }
    
    /// A convenience initializer for the `Event` class.
    /// Creates an event with the player and hole prize arrays set to the given parameters.
    /// Intended for reconstructing an `Event` object from database values.
    public convenience init(name: String, owner: String, type: String, course: Course, players: [Player], holePrizes: [HolePrize], skins: Bool)
    {
        self.init(name: name, owner: owner, type: type, course: course, skins: skins)
        self.players = players
        self.holePrizes = holePrizes
        self.skins = skins
    }
    
    /// Used for adding a player to the array of players.
    /// 
    public func addPlayer(newPlayer: Player)
    {
        // TODO: Code can be added to this method to force an update to the database when a new player is added
        players.append(newPlayer)
    }
    
    /// Used for adding a new hole prize to the list of hole prizes
    public func addHolePrize(newHolePrize: HolePrize)
    {
        // TODO: Code can be added to this method to force an update to the database when a new hole prize is added
        holePrizes.append(newHolePrize)
    }
    
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
