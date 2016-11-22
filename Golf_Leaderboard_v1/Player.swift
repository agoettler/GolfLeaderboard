//
//  Player.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/27/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
import Firebase


public class Player{
    
    public let name: String
    public let handicap: Int
    public let startHole: Int
    public var currentHole: Int
    public var scorecard:Scorecard
    
    public init(name : String, handicap : Int, startHole : Int, card: [Int]){
        
        self.name = name
        self.handicap = handicap
        self.startHole = startHole
        self.currentHole = startHole
        self.scorecard = Scorecard(startHole: self.startHole, handicap: self.handicap, scorecard: card)
        
    }
    
    public init(name : String, handicap : Int, startHole : Int, card: [Int], currentHole: Int){
        
        self.name = name
        self.handicap = handicap
        self.startHole = startHole
        self.currentHole = currentHole
        self.scorecard = Scorecard(startHole: self.startHole, handicap: self.handicap, scorecard: card)
        
    }
    
    public func goToNextHole(){
        if(self.currentHole == 18){
            self.currentHole = 1
        }
        else{
            self.currentHole = self.currentHole + 1
        }
        if(self.currentHole == self.startHole){
            print("current hole is -1")
            currentHole = -1
        }
    }
    
    
    
}
