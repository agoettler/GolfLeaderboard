//
//  Scorecard.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/3/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation

public class Scorecard{
    
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    var holes:[Hole]!
    var playerHandicap: Int!
    var playerStartHole: Int!
    var cumlativeParSum: Int = 0

    
    var grossScoreArray: [Int]!
    // var netScoreDictionary: Dictionary<Int,Int> = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0,15:0,16:0,17:0,18:0]


    public init(startHole: Int, handicap: Int, scorecard: [Int]){
        //holes = globals.globalEvent.course.holes
        playerHandicap = handicap
        playerStartHole = startHole
        grossScoreArray = scorecard
    }
    
    
    public func updateScore(holeNumber: Int, grossScore: Int){
        holes = globals.globalEvent.course.holes

        let hole:Hole = holes[holeNumber]
        let holeHandicap = hole.handicap

        // calculate the strokes over par for the leaderboard
        self.cumlativeParSum += holeHandicap
        
        grossScoreArray[holeNumber] = grossScore
        
    }
    
    
    public func getNetScore(holeNumber: Int) -> Int{
        
        let hole:Hole = holes[holeNumber]
        let holeHandicap = hole.handicap
    
        var netScore:Int = grossScoreArray[holeNumber]

        // calculate and update the player's net score
        if(holeHandicap <= playerHandicap){ // if the hole handicap is < or = to the players handicap the player gets a stroke
            
            netScore = netScore - 1 // player gets a stroke take off for their net score on the hole
            
            if(playerHandicap > 18){ // if a players handicap is over 18
                let excessiveHandicap: Int = playerHandicap - 18 // find how many strokes over 18
                if(holeHandicap <= excessiveHandicap){ // if hole handicap is less than or equal to the number of strokes over 18
                    netScore = netScore - 1 // the player gets 2 strokes on the hole, remove a second stroke for that hole
                }
            }
        }
        
        return netScore
    }
    
    
    public func getGrossStrokesOverPar() -> Int {
        var totalGrossScore: Int = 0
        
        for aHole in grossScoreArray{
            totalGrossScore += aHole
        }
        
        return totalGrossScore - cumlativeParSum
    }
    
    
    
    public func getNetStrokesOverPar() -> Int {
        var totalNetScore: Int = 0
        var net:Int = 0
        
        for index in 0..<grossScoreArray.count{
            net = getNetScore(holeNumber: index)
            totalNetScore += grossScoreArray[index]
        }
        
        return totalNetScore - cumlativeParSum
    }
    
    
    // TODO: Decide if the subscript should be 0-indexed or 1-indexed
    public subscript(index: Int) -> Hole
        {
        get
        {
            assert((index >= 1 && index <= holes.count), "Index out of range")
            
            return holes[index - 1]
        }
    }
    
    
    
}



