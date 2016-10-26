//
//  Course.swift
//  Golf_Leaderboard_v1
//
//  Created by Andrew Goettler on 10/26/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation

public class Course
{
    
}


/// Stores and organizes data for a single hole of a golf course.
/// Includes the hole number, yardage, and par value.
/// All properties are declared as constants during initialization.
/// ---
/// Properties:
/// - `number`: The number of the hole in the course.
/// - `yardage`: The distance from the tee to the hole.
/// - `par`: The ideal number of strokes needed to reach the hole.
public struct Hole
{
    let number: Int
    
    let yardage: Double
    
    let par: Int
    
    /// Creates a `Hole` structure directly from the given parameters.
    /// - parameters:
    ///     - number: The number of the hole in the course.
    ///     - yardage: The distance from the tee to the hole.
    ///     - par: The ideal number of strokes needed to reach the hole.
    init(_ number: Int, _ yardage: Double, _ par: Int)
    {
        self.number = number
        self.yardage = yardage
        self.par = par
    }
    
    /// Creates a `Hole` structure from the given parameters.
    /// The `yardage` and `par` parameters are of type `String` to facilitate creating `Hole` structures from database values, using an integer index value for the `number` parameter.
    /// If conversion from `String` fails, all properties are set to zero.
    /// - parameters:
    ///     - number: The number of the hole in the course.
    ///     - yardage: The distance from the tee to the hole.
    ///     - par: The ideal number of strokes needed to reach the hole.    
    init(number: Int, yardage: String, par: String)
    {
        if let yardageValue = Double(yardage), let parValue = Int(par)
        {
            self.init(number, yardageValue, parValue)
        }
        
        else
        {
            print("Could not create a valid Hole struct from (\(number), \(yardage), \(par))")
            self.init(0, 0, 0)
        }
    }
    /// Creates a `Hole` structure from the given parameters.
    /// All parameters are of type `String` to facilitate creating `Hole` structures from database values.
    /// If conversion from `String` fails, all properties are set to zero.
    /// - parameters:
    ///     - number: The number of the hole in the course.
    ///     - yardage: The distance from the tee to the hole.
    ///     - par: The ideal number of strokes needed to reach the hole.
    init(number: String, yardage: String, par: String)
    {
        if let numberValue = Int(number), let yardageValue = Double(yardage), let parValue = Int(par)
        {
            self.init(numberValue, yardageValue, parValue)
        }
        
        else
        {
            print("Could not create a valid Hole struct from (\(number), \(yardage), \(par))")
            self.init(0, 0, 0)
        }
    }
}
