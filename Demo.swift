#!/usr/bin/env swift

//
//  Demo.swift
//  FIBONACCI-APP
//
//  Medical Fibonacci Calculator Demonstration
//  PANACEA ICONO SA
//

import Foundation

// Add the path to our Sources directory so we can import the module
import FIBONACCI_APP

print("=== FIBONACCI MEDICAL CALCULATOR ===")
print("PANACEA ICONO SA - Medical Application Integration")
print("=" * 50)

print("\n🏥 MEDICAL FIBONACCI CALCULATIONS")
print("-" * 40)

// Basic Fibonacci calculations
print("\n1. Individual Fibonacci Calculations:")
for position in [0, 1, 5, 10, 15] {
    do {
        let result = try FibonacciService.fibonacciAt(position: position)
        print("   Position \(position): \(result)")
    } catch {
        print("   Error at position \(position): \(error)")
    }
}

// Sequence generation
print("\n2. Medical Data Sequence Generation:")
do {
    let sequence = try FibonacciService.fibonacciSequence(count: 12)
    print("   First 12 Fibonacci numbers:")
    print("   \(sequence.map(String.init).joined(separator: ", "))")
} catch {
    print("   Error generating sequence: \(error)")
}

// Range-based generation (useful for medical thresholds)
print("\n3. Range-Based Analysis (Medical Thresholds):")
let medicalRanges = [50, 100, 200]
for range in medicalRanges {
    let sequence = FibonacciService.fibonacciSequence(upTo: range)
    print("   Fibonacci numbers up to \(range): \(sequence.count) values")
    print("   Values: \(sequence.map(String.init).joined(separator: ", "))")
}

// Fibonacci validation (useful for pattern recognition)
print("\n4. Medical Pattern Recognition:")
let medicalValues = [8, 13, 21, 34, 55, 60, 89, 144]
for value in medicalValues {
    let isFib = FibonacciService.isFibonacci(value)
    print("   Value \(value): \(isFib ? "✓ Natural pattern" : "✗ Non-Fibonacci")")
}

// Golden ratio calculation (medical proportions)
print("\n5. Golden Ratio Analysis for Medical Applications:")
let ratio = FibonacciService.goldenRatioApproximation(iterations: 20)
print("   Golden Ratio: \(String(format: "%.10f", ratio))")
print("   Medical Application: Used in natural growth analysis")

// Error handling demonstration
print("\n6. Error Handling for Medical Safety:")
let invalidInputs = [-1, 100]
for input in invalidInputs {
    do {
        let result = try FibonacciService.fibonacciAt(position: input)
        print("   Position \(input): \(result)")
    } catch let error as FibonacciError {
        print("   ⚠️  Safety check for position \(input): \(error.errorDescription ?? "Unknown error")")
    } catch {
        print("   ⚠️  Unexpected error for position \(input): \(error)")
    }
}

print("\n🔬 MEDICAL USE CASE EXAMPLES")
print("-" * 40)

// Heart rate variability example
print("\n📊 Heart Rate Variability Analysis:")
let heartRates = [60, 65, 68, 73, 78, 80, 85, 89]
let fibSequence = FibonacciService.fibonacciSequence(upTo: 100)
print("   Heart rate data: \(heartRates.map(String.init).joined(separator: ", ")) bpm")
print("   Fibonacci reference points: \(fibSequence.map(String.init).joined(separator: ", "))")

var naturalRates = 0
for rate in heartRates {
    if FibonacciService.isFibonacci(rate) {
        naturalRates += 1
        print("   ✓ Rate \(rate) follows natural Fibonacci pattern")
    }
}
print("   Analysis: \(naturalRates)/\(heartRates.count) measurements follow natural patterns")

// Growth pattern analysis
print("\n📈 Growth Pattern Analysis:")
let growthMeasurements = [13, 21, 34, 55, 89]
print("   Growth measurements: \(growthMeasurements.map(String.init).joined(separator: ", ")) units")
let allNatural = growthMeasurements.allSatisfy { FibonacciService.isFibonacci($0) }
print("   Pattern Analysis: \(allNatural ? "✓ Perfect natural growth pattern" : "✗ Irregular growth")")

// Pharmacokinetics modeling
print("\n💊 Pharmacokinetics Modeling:")
let timeIntervals = try! FibonacciService.fibonacciSequence(count: 8)
print("   Optimized dosing intervals (hours): \(timeIntervals.map(String.init).joined(separator: ", "))")
print("   Based on natural absorption/elimination patterns")

print("\n" + "=" * 50)
print("Integration complete! Ready for PANAS-APP deployment")
print("Repository: https://github.com/panacea-icono/panas-app-frontend-oficial")
print("=" * 50)