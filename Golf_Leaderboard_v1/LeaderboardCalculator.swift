//
//  LeaderboardCalculator.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/8/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation

public class LeaderboardCalculator{
    
    static let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    static var currentPlayers: [Player]!
    
    public static func updateLeaderboard() -> [[String]]{
        var leaderboardDictionary: Dictionary<String,[Int]> = Dictionary<String,[Int]>()
        var leaderboardOuput: [[String]] = [[String]]()
        LeaderboardCalculator.currentPlayers = LeaderboardCalculator.globals.globalEvent.players
        
        for aPlayer in LeaderboardCalculator.currentPlayers{
            
            let parSum: [Int] = getCumlativeParSum(playerStartHole: aPlayer.startHole, playerCurrentHole: aPlayer.currentHole)
            print("ParSum: \(parSum)")
            let score: Int = aPlayer.scorecard.getTotalNetStrokes() - parSum[0]

            let holesPlayed: Int = parSum[1]
            
            leaderboardDictionary.updateValue([score, holesPlayed], forKey: aPlayer.name)
            
            
            
        }
        
        print("LB: \(leaderboardDictionary.keys)")

        for aKey in leaderboardDictionary{
            let newEntry: [String] = [aKey.key,"\(aKey.value[0])","\(aKey.value[1])"]
            leaderboardOuput.append(newEntry)
        }
        
        return leaderboardOuput
    }

    
    public static func getCumlativeParSum(playerStartHole: Int, playerCurrentHole: Int)->[Int]{
        var sum:Int = 0
        
        print("Start: \(playerStartHole), Curr: \(playerCurrentHole)")
        var i:Int = playerStartHole
        var counter:Int = 0
        
        if(playerCurrentHole == -1){
            return [LeaderboardCalculator.globals.globalEvent.course.par, 18]
        }
        else{
            
            while(i != playerCurrentHole){
                if(i > 18){
                    i = 1
                }
                
                sum = sum + globals.globalEvent.course.holes[i-1].par
                
                i = i + 1
                counter += 1
            }
        }
        return [sum, counter]
    }
    
    
}
