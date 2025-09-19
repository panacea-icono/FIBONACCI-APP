//
//  FibonacciView.swift
//  FIBONACCI-APP
//
//  SwiftUI Component for PANACEA ICONO Medical Application
//  Integration with PANAS-APP
//

import SwiftUI

/// SwiftUI View for Fibonacci calculations in medical context
/// Can be integrated into the main panas-app ContentView
public struct FibonacciView: View {
    @State private var inputPosition: String = ""
    @State private var inputCount: String = ""
    @State private var inputMaxValue: String = ""
    @State private var selectedTab: Int = 0
    @State private var result: String = "Enter values to calculate"
    @State private var errorMessage: String = ""
    @State private var showingError: Bool = false
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack {
                    Image(systemName: "heart.text.square")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("FIBONACCI MEDICAL CALCULATOR")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("PANACEA ICONO SA")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Tab Selection
                Picker("Calculation Type", selection: $selectedTab) {
                    Text("Position").tag(0)
                    Text("Sequence").tag(1)
                    Text("Range").tag(2)
                    Text("Analysis").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Input Section
                VStack(spacing: 15) {
                    switch selectedTab {
                    case 0:
                        positionCalculationView
                    case 1:
                        sequenceCalculationView
                    case 2:
                        rangeCalculationView
                    case 3:
                        analysisView
                    default:
                        EmptyView()
                    }
                }
                .padding(.horizontal)
                
                // Result Display
                VStack(alignment: .leading, spacing: 10) {
                    Text("Result:")
                        .font(.headline)
                    
                    ScrollView {
                        Text(result)
                            .font(.body)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .frame(maxHeight: 200)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Medical Context Information
                VStack {
                    Text("Medical Applications")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("• Heart Rate Variability Analysis\n• Growth Pattern Recognition\n• Pharmacokinetics Modeling\n• Medical Data Visualization")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .navigationTitle("Fibonacci Medical")
            .alert("Error", isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var positionCalculationView: some View {
        VStack(spacing: 10) {
            Text("Calculate Fibonacci number at position")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("Enter position (0-92)", text: $inputPosition)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button("Calculate") {
                calculateFibonacciAtPosition()
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
        }
    }
    
    private var sequenceCalculationView: some View {
        VStack(spacing: 10) {
            Text("Generate Fibonacci sequence")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("Enter count (1-92)", text: $inputCount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button("Generate Sequence") {
                generateFibonacciSequence()
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
        }
    }
    
    private var rangeCalculationView: some View {
        VStack(spacing: 10) {
            Text("Generate Fibonacci numbers up to value")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("Enter maximum value", text: $inputMaxValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button("Generate Range") {
                generateFibonacciRange()
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
        }
    }
    
    private var analysisView: some View {
        VStack(spacing: 15) {
            Text("Golden Ratio Analysis")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button("Calculate Golden Ratio") {
                calculateGoldenRatio()
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
            
            if !inputPosition.isEmpty {
                Button("Check if \(inputPosition) is Fibonacci") {
                    checkIsFibonacci()
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
            }
            
            TextField("Enter number to check", text: $inputPosition)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
        }
    }
    
    // MARK: - Calculation Methods
    
    private func calculateFibonacciAtPosition() {
        guard let position = Int(inputPosition) else {
            showError("Please enter a valid number")
            return
        }
        
        do {
            let fibonacci = try FibonacciService.fibonacciAt(position: position)
            result = "Fibonacci number at position \(position): \(fibonacci)"
        } catch {
            showError(error.localizedDescription)
        }
    }
    
    private func generateFibonacciSequence() {
        guard let count = Int(inputCount) else {
            showError("Please enter a valid number")
            return
        }
        
        do {
            let sequence = try FibonacciService.fibonacciSequence(count: count)
            result = "Fibonacci sequence (\(count) numbers):\n\(sequence.map(String.init).joined(separator: ", "))"
        } catch {
            showError(error.localizedDescription)
        }
    }
    
    private func generateFibonacciRange() {
        guard let maxValue = Int(inputMaxValue) else {
            showError("Please enter a valid number")
            return
        }
        
        let sequence = FibonacciService.fibonacciSequence(upTo: maxValue)
        result = "Fibonacci numbers up to \(maxValue):\n\(sequence.map(String.init).joined(separator: ", "))"
    }
    
    private func calculateGoldenRatio() {
        let ratio = FibonacciService.goldenRatioApproximation(iterations: 20)
        result = "Golden Ratio Approximation: \(String(format: "%.10f", ratio))\n\nMedical Application:\nThis ratio appears in natural growth patterns and can be used for analyzing proportional relationships in medical measurements."
    }
    
    private func checkIsFibonacci() {
        guard let number = Int(inputPosition) else {
            showError("Please enter a valid number")
            return
        }
        
        let isFib = FibonacciService.isFibonacci(number)
        result = "\(number) \(isFib ? "is" : "is not") a Fibonacci number"
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showingError = true
    }
}

#Preview {
    FibonacciView()
}