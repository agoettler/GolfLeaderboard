//
//  SkinsCalculator.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/16/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation

class SkinsCalculator{
    
    static let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    static var currentMinScores1:Dictionary<Int,Int>!
    
    public static func updateSkins()->Dictionary<Int,String>{
        
        let players:[Player] = globals.globalEvent.players
        var skinsDictionary: Dictionary<Int,String> = Dictionary<Int,String> ()
        var currentMinScores:Dictionary<Int,Int> = Dictionary<Int,Int> ()

        
        for currentPlayer in players{
            for currHole in 1..<19{
                let score:Int = currentPlayer.scorecard.getNetScore(holeNumber: currHole-1);
                
                if(score > 0){
                    if(currentMinScores.keys.contains(currHole)){
                        if(score < currentMinScores[currHole]!){
                            currentMinScores.updateValue(score, forKey: currHole)
                            skinsDictionary.updateValue(currentPlayer.name, forKey: currHole)
                        }
                        else if(score == currentMinScores[currHole]!){
                            skinsDictionary.removeValue(forKey: currHole)
                        }
                    }
                    else{
                        currentMinScores.updateValue(score, forKey: currHole)
                        skinsDictionary.updateValue(currentPlayer.name, forKey: currHole)
                    }
                }
            }
        }
        
        
        print("skinsDicKeys: \(skinsDictionary.keys.sorted())")
        print("skinsDicVals: \(skinsDictionary.values)")

        currentMinScores1 = currentMinScores
    
        return skinsDictionary
    }
    
    
    public static func getMinScores() -> Dictionary<Int,Int>{
        return currentMinScores1
    }
    
    
    
}
