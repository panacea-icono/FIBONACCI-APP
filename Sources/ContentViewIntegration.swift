//
//  ContentViewIntegration.swift
//  Integration Example for PANAS-APP
//
//  Shows how to integrate Fibonacci functionality into the main medical app
//  PANACEA ICONO SA
//

import SwiftUI
import SwiftData

/// Enhanced ContentView with Fibonacci Medical Calculator Integration
/// This demonstrates how to add Fibonacci functionality to the existing panas-app
struct EnhancedContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showingFibonacci = false

    var body: some View {
        NavigationSplitView {
            List {
                // Fibonacci Medical Calculator Section
                NavigationLink {
                    FibonacciView()
                } label: {
                    HStack {
                        Image(systemName: "heart.text.square")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Fibonacci Medical Calculator")
                                .font(.headline)
                            Text("PANACEA ICONO Analysis Tool")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // Existing Items Section
                Section("Medical Records") {
                    ForEach(items) { item in
                        NavigationLink {
                            MedicalItemDetailView(item: item)
                        } label: {
                            HStack {
                                Image(systemName: "doc.text")
                                    .foregroundColor(.green)
                                VStack(alignment: .leading) {
                                    Text("Record")
                                        .font(.headline)
                                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Record", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: { showingFibonacci = true }) {
                        Label("Fibonacci Calculator", systemImage: "heart.text.square")
                    }
                }
            }
            .sheet(isPresented: $showingFibonacci) {
                NavigationView {
                    FibonacciView()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    showingFibonacci = false
                                }
                            }
                        }
                }
            }
        } detail: {
            VStack {
                Image(systemName: "stethoscope")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("PANACEA ICONO")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Medical Application System")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Select an item or use Fibonacci Calculator")
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

/// Enhanced detail view for medical items with Fibonacci analysis
struct MedicalItemDetailView: View {
    let item: Item
    @State private var fibonacciAnalysis: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Basic Item Information
            VStack(alignment: .leading, spacing: 10) {
                Text("Medical Record Details")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Created: \(item.timestamp, format: Date.FormatStyle(date: .complete, time: .standard))")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            // Fibonacci Analysis Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Fibonacci Pattern Analysis")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("Medical Context Analysis")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                if fibonacciAnalysis.isEmpty {
                    Button("Generate Fibonacci Analysis") {
                        generateFibonacciAnalysis()
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Text(fibonacciAnalysis)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            
            Spacer()
            
            // Medical Applications Info
            VStack(alignment: .leading, spacing: 5) {
                Text("Fibonacci in Medical Analysis:")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("• Heart Rate Variability Patterns")
                Text("• Growth Rate Analysis")
                Text("• Pharmacokinetic Modeling")
                Text("• Natural Healing Progressions")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .padding()
        .navigationTitle("Medical Record")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func generateFibonacciAnalysis() {
        let timestamp = item.timestamp
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: timestamp) ?? 1
        
        // Generate analysis based on timestamp
        let analysisPosition = dayOfYear % 20 // Keep it reasonable
        
        do {
            let fibValue = try FibonacciService.fibonacciAt(position: analysisPosition)
            let goldenRatio = FibonacciService.goldenRatioApproximation()
            let isFib = FibonacciService.isFibonacci(analysisPosition)
            
            fibonacciAnalysis = """
            Analysis for day \(dayOfYear) of year:
            
            Fibonacci Position: \(analysisPosition)
            Fibonacci Value: \(fibValue)
            Golden Ratio: \(String(format: "%.6f", goldenRatio))
            
            Pattern Recognition:
            Day \(dayOfYear) \(isFib ? "follows" : "does not follow") natural Fibonacci progression.
            
            Medical Relevance:
            The Fibonacci value \(fibValue) can be used as a reference point for:
            • Expected healing timeframes
            • Medication dosing intervals
            • Follow-up scheduling optimization
            • Growth rate expectations
            """
        } catch {
            fibonacciAnalysis = "Analysis Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    EnhancedContentView()
        .modelContainer(for: Item.self, inMemory: true)
}