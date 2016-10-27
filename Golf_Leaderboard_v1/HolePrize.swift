//
//  HolePrize.swift
//  Golf_Leaderboard_v1
//
//  Created by Zachary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation

class HolePrize{
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    let prize: String!
    let currentWinner: Player!
    
    public init(String: incomingPrize, Player:incomingWinner ){
        prize = incomingPrize
        currentWinner = incomingWinner
        
    }
    func updateWinner(newWinner: Player){
        currentWinner = newWinner
    }
}
