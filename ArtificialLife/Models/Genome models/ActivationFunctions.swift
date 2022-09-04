//
//  ActivationFunctions.swift
//  ArtificialLife
//
//  Created by Keith Staines on 04/09/2022.
//

import Foundation

struct Activation {
    
    /// The logistic sigmoid
    ///
    /// maps x into the range 0...1
    static func lg(_ x: Float) -> Float { 1.0 / (1 + exp(-x)) }
    
    /// The hyperbolic tangent sigmoid
    ///
    /// maps x into the range  -1...1 using
    static func th(_ x: Float) -> Float { tanhf(x) }
    
    /// ReLu
    ///
    /// map x to max(0, x)
    /// Suitable for hidden layers
    static func relu(_ x: Float) -> Float { max(0, x) }
    
    /// The identity function maps x to itself
    static func i(_ x: Float) -> Float { x }
    
    /// Returns the index of the maximum value in the array of values
    static func argMax(_ values: [Float]) -> Int {
        var max = values[0]
        var index = 0
        for item in values.enumerated() {
            if item.element > max {
                max = item.element
                index = item.offset
            }
        }
        return index
    }
    
    /// Returns an array of probabilities obtained by normalising the input array
    ///
    /// The input array is assumed to contain only positive values
    static func softMax(_ values: [Float]) -> [Float] {
        let exponentials = values.map(exp)
        let sum = exponentials.reduce(0) { sum, value in
            sum + value
        }
        return exponentials.map { value in value / sum }
    }
}
