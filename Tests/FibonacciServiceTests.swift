//
//  FibonacciServiceTests.swift
//  FIBONACCI-APP Tests
//
//  Unit Tests for Medical Fibonacci Calculator
//  PANACEA ICONO SA
//

import XCTest
@testable import FIBONACCI_APP

final class FibonacciServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Setup code before each test
    }

    override func tearDownWithError() throws {
        // Cleanup code after each test
    }

    // MARK: - fibonacciAt Tests
    
    func testFibonacciAtBasicCases() throws {
        // Test basic Fibonacci numbers
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 0), 0)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 1), 1)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 2), 1)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 3), 2)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 4), 3)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 5), 5)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 6), 8)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 7), 13)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 8), 21)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 9), 34)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 10), 55)
    }
    
    func testFibonacciAtLargePosition() throws {
        // Test larger Fibonacci numbers relevant for medical calculations
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 15), 610)
        XCTAssertEqual(try FibonacciService.fibonacciAt(position: 20), 6765)
    }
    
    func testFibonacciAtNegativePosition() {
        // Test error handling for negative position
        XCTAssertThrowsError(try FibonacciService.fibonacciAt(position: -1)) { error in
            XCTAssertEqual(error as? FibonacciError, FibonacciError.negativePosition)
        }
    }
    
    func testFibonacciAtTooLargePosition() {
        // Test error handling for position too large
        XCTAssertThrowsError(try FibonacciService.fibonacciAt(position: 93)) { error in
            XCTAssertEqual(error as? FibonacciError, FibonacciError.positionTooLarge)
        }
    }
    
    // MARK: - fibonacciSequence Tests
    
    func testFibonacciSequenceBasic() throws {
        // Test basic sequence generation
        let sequence5 = try FibonacciService.fibonacciSequence(count: 5)
        XCTAssertEqual(sequence5, [0, 1, 1, 2, 3])
        
        let sequence10 = try FibonacciService.fibonacciSequence(count: 10)
        XCTAssertEqual(sequence10, [0, 1, 1, 2, 3, 5, 8, 13, 21, 34])
    }
    
    func testFibonacciSequenceEdgeCases() throws {
        // Test edge cases
        let sequence0 = try FibonacciService.fibonacciSequence(count: 0)
        XCTAssertEqual(sequence0, [])
        
        let sequence1 = try FibonacciService.fibonacciSequence(count: 1)
        XCTAssertEqual(sequence1, [0])
        
        let sequence2 = try FibonacciService.fibonacciSequence(count: 2)
        XCTAssertEqual(sequence2, [0, 1])
    }
    
    func testFibonacciSequenceNegativeCount() {
        // Test error handling for negative count
        XCTAssertThrowsError(try FibonacciService.fibonacciSequence(count: -1)) { error in
            XCTAssertEqual(error as? FibonacciError, FibonacciError.negativeCount)
        }
    }
    
    func testFibonacciSequenceTooLargeCount() {
        // Test error handling for count too large
        XCTAssertThrowsError(try FibonacciService.fibonacciSequence(count: 93)) { error in
            XCTAssertEqual(error as? FibonacciError, FibonacciError.countTooLarge)
        }
    }
    
    // MARK: - fibonacciSequence(upTo:) Tests
    
    func testFibonacciSequenceUpToBasic() {
        // Test sequence generation up to a value
        let sequenceUpTo10 = FibonacciService.fibonacciSequence(upTo: 10)
        XCTAssertEqual(sequenceUpTo10, [0, 1, 1, 2, 3, 5, 8])
        
        let sequenceUpTo100 = FibonacciService.fibonacciSequence(upTo: 100)
        XCTAssertEqual(sequenceUpTo100, [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89])
    }
    
    func testFibonacciSequenceUpToEdgeCases() {
        // Test edge cases
        let sequenceUpTo0 = FibonacciService.fibonacciSequence(upTo: 0)
        XCTAssertEqual(sequenceUpTo0, [0])
        
        let sequenceUpToNegative = FibonacciService.fibonacciSequence(upTo: -5)
        XCTAssertEqual(sequenceUpToNegative, [])
    }
    
    // MARK: - isFibonacci Tests
    
    func testIsFibonacciValid() {
        // Test valid Fibonacci numbers
        XCTAssertTrue(FibonacciService.isFibonacci(0))
        XCTAssertTrue(FibonacciService.isFibonacci(1))
        XCTAssertTrue(FibonacciService.isFibonacci(2))
        XCTAssertTrue(FibonacciService.isFibonacci(3))
        XCTAssertTrue(FibonacciService.isFibonacci(5))
        XCTAssertTrue(FibonacciService.isFibonacci(8))
        XCTAssertTrue(FibonacciService.isFibonacci(13))
        XCTAssertTrue(FibonacciService.isFibonacci(21))
        XCTAssertTrue(FibonacciService.isFibonacci(34))
        XCTAssertTrue(FibonacciService.isFibonacci(55))
        XCTAssertTrue(FibonacciService.isFibonacci(89))
    }
    
    func testIsFibonacciInvalid() {
        // Test non-Fibonacci numbers
        XCTAssertFalse(FibonacciService.isFibonacci(4))
        XCTAssertFalse(FibonacciService.isFibonacci(6))
        XCTAssertFalse(FibonacciService.isFibonacci(7))
        XCTAssertFalse(FibonacciService.isFibonacci(9))
        XCTAssertFalse(FibonacciService.isFibonacci(10))
        XCTAssertFalse(FibonacciService.isFibonacci(11))
        XCTAssertFalse(FibonacciService.isFibonacci(12))
        XCTAssertFalse(FibonacciService.isFibonacci(14))
        XCTAssertFalse(FibonacciService.isFibonacci(15))
    }
    
    func testIsFibonacciNegative() {
        // Test negative numbers
        XCTAssertFalse(FibonacciService.isFibonacci(-1))
        XCTAssertFalse(FibonacciService.isFibonacci(-5))
    }
    
    // MARK: - goldenRatioApproximation Tests
    
    func testGoldenRatioApproximation() {
        // Test golden ratio calculation
        let ratio = FibonacciService.goldenRatioApproximation(iterations: 20)
        
        // Golden ratio should be approximately 1.618033988749
        XCTAssertTrue(abs(ratio - 1.618033988749) < 0.0001, "Golden ratio approximation should be close to 1.618033988749")
    }
    
    func testGoldenRatioApproximationEdgeCases() {
        // Test edge cases
        let ratioLowIterations = FibonacciService.goldenRatioApproximation(iterations: 1)
        XCTAssertEqual(ratioLowIterations, 1.0)
        
        let ratioZeroIterations = FibonacciService.goldenRatioApproximation(iterations: 0)
        XCTAssertEqual(ratioZeroIterations, 1.0)
    }
    
    // MARK: - Medical Context Performance Tests
    
    func testPerformanceFibonacciAtPosition() throws {
        // Performance test for medical real-time calculations
        measure {
            for i in 0...50 {
                _ = try! FibonacciService.fibonacciAt(position: i)
            }
        }
    }
    
    func testPerformanceFibonacciSequence() throws {
        // Performance test for sequence generation
        measure {
            _ = try! FibonacciService.fibonacciSequence(count: 50)
        }
    }
    
    func testPerformanceGoldenRatio() {
        // Performance test for golden ratio calculation
        measure {
            _ = FibonacciService.goldenRatioApproximation(iterations: 30)
        }
    }
}