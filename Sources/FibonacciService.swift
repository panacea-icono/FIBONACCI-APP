//
//  FibonacciService.swift
//  FIBONACCI-APP
//
//  Medical Fibonacci Calculator for PANACEA ICONO SA
//  Integrated with PANAS-APP Medical Application
//

import Foundation

/// Service class for calculating Fibonacci sequences with medical applications
/// Used in PANACEA ICONO medical data analysis and pattern recognition
public class FibonacciService {
    
    /// Calculate Fibonacci number at specific position
    /// - Parameter position: The position in the Fibonacci sequence (0-based)
    /// - Returns: The Fibonacci number at the given position
    /// - Throws: FibonacciError for invalid inputs
    public static func fibonacciAt(position: Int) throws -> Int {
        guard position >= 0 else {
            throw FibonacciError.negativePosition
        }
        
        guard position <= 92 else {
            throw FibonacciError.positionTooLarge
        }
        
        if position <= 1 {
            return position
        }
        
        var a = 0
        var b = 1
        
        for _ in 2...position {
            let temp = a + b
            a = b
            b = temp
        }
        
        return b
    }
    
    /// Generate Fibonacci sequence up to a specific count
    /// - Parameter count: Number of Fibonacci numbers to generate
    /// - Returns: Array of Fibonacci numbers
    /// - Throws: FibonacciError for invalid inputs
    public static func fibonacciSequence(count: Int) throws -> [Int] {
        guard count >= 0 else {
            throw FibonacciError.negativeCount
        }
        
        guard count <= 92 else {
            throw FibonacciError.countTooLarge
        }
        
        if count == 0 { return [] }
        if count == 1 { return [0] }
        
        var sequence = [0, 1]
        
        for i in 2..<count {
            let nextValue = sequence[i-1] + sequence[i-2]
            sequence.append(nextValue)
        }
        
        return sequence
    }
    
    /// Generate Fibonacci sequence up to a maximum value
    /// Useful for medical data ranges and thresholds
    /// - Parameter maxValue: Maximum value for the sequence
    /// - Returns: Array of Fibonacci numbers not exceeding maxValue
    public static func fibonacciSequence(upTo maxValue: Int) -> [Int] {
        guard maxValue >= 0 else { return [] }
        
        var sequence: [Int] = []
        var a = 0
        var b = 1
        
        while a <= maxValue {
            sequence.append(a)
            let temp = a + b
            a = b
            b = temp
        }
        
        return sequence
    }
    
    /// Check if a number is a Fibonacci number
    /// Useful for validating medical measurements against expected patterns
    /// - Parameter number: Number to check
    /// - Returns: True if the number is in the Fibonacci sequence
    public static func isFibonacci(_ number: Int) -> Bool {
        guard number >= 0 else { return false }
        
        if number <= 1 { return true }
        
        var a = 0
        var b = 1
        
        while b < number {
            let temp = a + b
            a = b
            b = temp
        }
        
        return b == number
    }
    
    /// Calculate Golden Ratio approximation using Fibonacci numbers
    /// Used in medical applications for growth analysis and proportional measurements
    /// - Parameter iterations: Number of Fibonacci iterations for precision
    /// - Returns: Golden ratio approximation
    public static func goldenRatioApproximation(iterations: Int = 20) -> Double {
        guard iterations >= 2 else { return 1.0 }
        
        do {
            let sequence = try fibonacciSequence(count: iterations)
            guard sequence.count >= 2 else { return 1.0 }
            
            let lastIndex = sequence.count - 1
            return Double(sequence[lastIndex]) / Double(sequence[lastIndex - 1])
        } catch {
            return 1.618033988749 // Mathematical golden ratio as fallback
        }
    }
}

/// Errors that can occur during Fibonacci calculations
public enum FibonacciError: Error, LocalizedError, Equatable {
    case negativePosition
    case negativeCount
    case positionTooLarge
    case countTooLarge
    
    public var errorDescription: String? {
        switch self {
        case .negativePosition:
            return "Position cannot be negative"
        case .negativeCount:
            return "Count cannot be negative"
        case .positionTooLarge:
            return "Position too large (maximum 92 for Int range)"
        case .countTooLarge:
            return "Count too large (maximum 92 for Int range)"
        }
    }
}