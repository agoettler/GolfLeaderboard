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
            let newEntry: [String] = ["0",aKey.key,"\(aKey.value[0])","\(aKey.value[1])"]
            leaderboardOuput.append(newEntry)
        }
        
        var hold:[String]
        var m:Int
        if(leaderboardOuput.count>0){
            for k in 0..<leaderboardOuput.count-1{
                m = k;
                for j in (k+1)..<leaderboardOuput.count{
                    if(Int(leaderboardOuput[j][2])! < Int(leaderboardOuput[m][2])!){
                        m = j;
                    }
                }
                
                hold = leaderboardOuput[m];
                leaderboardOuput[m] = leaderboardOuput[k];
                leaderboardOuput[k] = hold;
                
            }
            
            leaderboardOuput[0][0] = "1"
            
            var counter: Int = 2
            m = 1
            while(m < leaderboardOuput.count){
                if(leaderboardOuput[m][2] == leaderboardOuput[m-1][2]){
                    leaderboardOuput[m][0] = leaderboardOuput[m-1][0]
                }
                else{
                    leaderboardOuput[m][0] = "\(counter)"
                    
                }
                
                counter += 1
                m += 1
            }
            print("leoutput: \(leaderboardOuput)")
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
