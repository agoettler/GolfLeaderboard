//
//  Scorecard.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/3/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation

public class Scorecard
{
    
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    var playerHandicap: Int
    var playerStartHole: Int
    var cumlativeParSum: Int = 0

    
    var grossScoreArray: [Int]=[Int]()
    // var netScoreDictionary: Dictionary<Int,Int> = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0,15:0,16:0,17:0,18:0]


    public init(startHole: Int, handicap: Int, scorecard: [Int])
    {
        //holes = globals.globalEvent.course.holes
        playerHandicap = handicap
        playerStartHole = startHole
        grossScoreArray = scorecard
    }
    
    
    public func updateScore(holeNumber: Int, grossScore: Int)
    {
        let hole:Hole = globals.globalEvent.course[holeNumber]

        let holePar = hole.par

        // calculate the strokes over par for the leaderboard
        self.cumlativeParSum += holePar
        grossScoreArray[holeNumber-1] = grossScore
        
    }
    
    
    public func getNetScore(holeNumber: Int) -> Int
    {
        
        let hole:Hole = globals.globalEvent.course[holeNumber+1]
        let holeHandicap = hole.handicap
    
        var netScore:Int = grossScoreArray[holeNumber]
        if(netScore > 0){
        // calculate and update the player's net score
            if(holeHandicap <= playerHandicap)
            { // if the hole handicap is < or = to the players handicap the player gets a stroke
            
                netScore = netScore - 1 // player gets a stroke take off for their net score on the hole
            
                if(playerHandicap > 18)
                { // if a players handicap is over 18
                    let excessiveHandicap: Int = playerHandicap - 18 // find how many strokes over 18
                    if(holeHandicap <= excessiveHandicap)
                    { // if hole handicap is less than or equal to the number of strokes over 18
                        netScore = netScore - 1 // the player gets 2 strokes on the hole, remove a second stroke for that   hole
                    }
                }
            /*
            if ( playerHandicap > 18 && hole.handicap <= (playerHandicap - 18))
            {
                netScore -= 1
            }
            */
            }
            //print("netScore: \(netScore)")
            return netScore
        }
        return 0
    }
    
    
    public func getTotalGrossStrokes() -> Int
    {
        var totalGrossScore: Int = 0
        
        for aHole in grossScoreArray
        {
            totalGrossScore += aHole
        }
        
        return totalGrossScore
    }
    
    
    
    public func getTotalNetStrokes() -> Int
    {
        var totalNetScore: Int = 0
        var net:Int = 0
        
        for index in 0..<grossScoreArray.count
        {
            net = getNetScore(holeNumber: index)
            totalNetScore += net
        }
        
        return totalNetScore
    }
    

    
    
    // TODO: Decide if the subscript should be 0-indexed or 1-indexed
    public subscript(index: Int) -> ( grossScore: Int, netScore: Int)
    {
        get
        {
            assert((index >= 1 && index <= grossScoreArray.count), "Index out of range")
            
            return (grossScoreArray[index-1], getNetScore(holeNumber: index-1))
        }
    }
    
    
    
}



