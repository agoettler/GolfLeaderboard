//
//  HolePrize.swift
//  Golf_Leaderboard_v1
//
//  Created by Zachary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
import Firebase

public class HolePrize{
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    let prize: String
    var currentWinner: Player!
    
    // TODO: When a hole prize is created, there probably won't be a winner immediately
    public init(prize: String)
    {
        self.prize = prize
    }
    
    public init(incomingPrize:String, incomingWinner:Player )
    {
        prize = incomingPrize
        currentWinner = incomingWinner
        
    }
    
    func updateWinner(newWinner: Player)
    {
        currentWinner = newWinner
    }
}
