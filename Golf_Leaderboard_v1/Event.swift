//
//  Event.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
//import Firebase

public class Event
{
    public let name: String
    
    public let owner: String
    
    public let type: String
    
    public let course: Course
    
    public var players: [Player] = []
    
    public var holePrizes: [HolePrize] = []
    
    // TODO: Add leaderboard later
    
    public init(name: String, owner: String, type: String, course: Course)
    {
        self.name = name
        self.owner = owner
        self.type = type
        self.course = course
    }
    
    public convenience init(name: String, owner: String, type: String, course: Course, players: [Player], holePrizes: [HolePrize])
    {
        self.init(name: name, owner: owner, type: type, course: course)
        self.players = players
        self.holePrizes = holePrizes
    }
}
