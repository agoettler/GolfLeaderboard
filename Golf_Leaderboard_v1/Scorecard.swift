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
    
    var totalGrossScore:Int = 0
    var totalNetScore:Int = 0
    var strokesOverPar:Int = 0
    
    var grossScoreDictionary: Dictionary<Int,Int> = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0,15:0,16:0,17:0,18:0]
    var netScoreDictionary: Dictionary<Int,Int> = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0,15:0,16:0,17:0,18:0]


    public init(startHole: Int, handicap: Int){
        holes = globals.globalEvent.course.holes
        playerHandicap = handicap
        playerStartHole = startHole
    }
    
    
    public func updateScore(holeNumber: Int, score: Int){
        let hole:Hole = holes[holeNumber]
        let holeHandicap = hole.handicap
        
        // update the player's gross score
        grossScoreDictionary.updateValue(score, forKey: holeNumber)
        self.totalGrossScore += score
    
        // calculate the strokes over par for the leaderboard
        self.cumlativeParSum += holeHandicap
        strokesOverPar = totalGrossScore - cumlativeParSum
        
        
        // calculate and update the player's net score
        if(holeHandicap <= playerHandicap){ // if the hole handicap is < or = to the players handicap the player gets a stroke
            var adjustedScore: Int = score

            adjustedScore = score - 1 // player gets a stroke take off for their net score on the hole
 
            if(playerHandicap > 18){ // if a players handicap is over 18
                let excessiveHandicap: Int = playerHandicap - 18 // find how many strokes over 18
                if(holeHandicap <= excessiveHandicap){ // if hole handicap is less than or equal to the number of strokes over 18
                    adjustedScore = adjustedScore - 1 // the player gets 2 strokes on the hole, remove a second stroke for that hole
                }
            }
            netScoreDictionary.updateValue(adjustedScore, forKey: holeNumber)
            totalNetScore += adjustedScore
        }
        else{
            netScoreDictionary.updateValue(score, forKey: holeNumber)
            totalNetScore += score
        }
        
        
    }
    
    public func getTotalGrossScore() -> Int {
        return totalGrossScore
    }
    
    public func getTotalNetScore() -> Int {
        return totalNetScore
    }
    
    public func getGrossScoreDictionary() -> Dictionary<Int,Int>{
        return grossScoreDictionary
    }
    
    public func getNetScoreDictionary() -> Dictionary<Int,Int>{
        return netScoreDictionary
    }
    
}
