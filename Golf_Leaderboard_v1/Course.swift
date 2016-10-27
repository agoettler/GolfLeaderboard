//
//  Course.swift
//  Golf_Leaderboard_v1
//
//  Created by Andrew Goettler on 10/26/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation

/// Stores and organizes data for a single golf course.
/// Includes the name of the course and data for all holes.
/// All properties declared constant.
/// ---
/// Properties:
/// - `String` `name`: The name of the course.
/// - `[Hole]` `holes`: An array of `Hole` structures representing the holes of the course.
/// - `Int` `par`: The sum of par values for all holes in the course.
/// ---
/// - note: This class implements the `subscript` function, allowing the `Course` object to be used similarly to an array of `Hole` structures. Currently, the subscript is _1-indexed_.
///
///       // Set firstHole equal to the first hole of the sample course
///       firstHole: Hole = sampleCourse[1]
public class Course
{
    public let name: String
    
    // TODO: Consider making this an optional
    public let holes: [Hole]
    
    public var par: Int
    {
        get
        {
            var sum: Int = 0
            
            for hole in holes
            {
                sum += hole.par
            }
            
            return sum
        }
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
    
    /// The default initializer for the `Course` class.
    /// Creates a new `Course` object from the given parameters.
    /// - parameters:
    ///     - name: The name of the course.
    ///     - holes: The `Hole` structures of the course.
    public init(_ name: String, _ holes: [Hole])
    {
        self.name = name
        
        self.holes = holes
    }
    
    /// Creates a new `Course` object from a name and a series of arrays representing the hole numbers, yardages, and par values.
    /// The implementation assumes that the arrays list data in the same order, from first to last.
    /// Intended to facilitate building `Course` objects from database values.
    /// - parameters:
    ///     - name: The name of the course.
    ///     - numbers: The array of hole numbers of the course.
    ///     - yardages: The array of yardages of the course.
    ///     - pars: The array of par values of the course.
    public convenience init(name: String, numbers: [Int], yardages: [Int], pars: [Int], handicaps: [Int])
    {
        if numbers.count == yardages.count && yardages.count == pars.count
        {
            var tempHoles: [Hole] = []
            
            for index in 0..<numbers.count
            {
                tempHoles.append(Hole(numbers[index], yardages[index], pars[index], handicap: handicaps[index]))
            }
            
            self.init(name, tempHoles)
        }
        
        else
        {
            print("Course data arrays were not the same size. (holes: \(numbers.count), yardages: \(yardages.count), pars: \(pars.count)")
            
            // TODO: Setting the Hole array to empty is probably not the best way to handle this problem
            self.init(name, [])
        }
    }
    
    /// Creates a new `Course` object from a name and arrays representing yardages and par values.
    /// Automatically assigns the hole number based on the index of the yardage array.
    /// - paramters:
    ///     - name: The name of the course.
    ///     - yardages: The array of yardages of the course.
    ///     - pars: The array of par values of the course.
    public convenience init(name: String, yardages: [Int], pars: [Int], handicaps: [Int])
    {
        if yardages.count == pars.count
        {
            var tempHoles: [Hole] = []
            
            for index in 0..<yardages.count
            {
                tempHoles.append(Hole(index + 1, yardages[index], pars[index], handicap: handicaps[index]))
            }
            
            self.init(name, tempHoles)
        }
        
        else
        {
            print("Course data arrays were not the same size. (yardages: \(yardages.count), pars: \(pars.count)")
            
            // TODO: Setting the Hole array to empty is probably not the best way to handle this problem
            self.init(name, [])
        }
    }
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
    public let number: Int
    
    public let yardage: Int
    
    public let par: Int
    
    public let handicap: Int
    
    /// Creates a `Hole` structure directly from the given parameters.
    /// - parameters:
    ///     - number: The number of the hole in the course.
    ///     - yardage: The distance from the tee to the hole.
    ///     - par: The ideal number of strokes needed to reach the hole.
    public init(_ number: Int, _ yardage: Int, _ par: Int, handicap: Int)
    {
        self.number = number
        self.yardage = yardage
        self.par = par
        self.handicap = handicap
    }
    
    /*
    /// Creates a `Hole` structure from the given parameters.
    /// The `yardage` and `par` parameters are of type `String` to facilitate creating `Hole` structures from database values, using an integer index value for the `number` parameter.
    /// If conversion from `String` fails, all properties are set to zero.
    /// - parameters:
    ///     - number: The number of the hole in the course.
    ///     - yardage: The distance from the tee to the hole.
    ///     - par: The ideal number of strokes needed to reach the hole.    
    public init(number: Int, yardage: String, par: String)
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
    public init(number: String, yardage: String, par: String)
    {
        if let numberValue = Int(number), let yardageValue = Double(yardage), let parValue = Int(par)
        {
            self.init(numberValue, yardageValue, parValue)
        }
        
        else
        {
            print("Could not create a valid Hole struct from (number: \(number), yardage: \(yardage), par: \(par))")
            self.init(0, 0, 0)
        }
    }
    */
}
