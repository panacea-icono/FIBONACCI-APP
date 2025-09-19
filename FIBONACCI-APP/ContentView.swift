//
//  ContentView.swift
//  FIBONACCI-APP
//
//  Created by Nuevo Usuario on 18/9/25.
//

import SwiftUI
import SwiftData
import AVKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var currentDoctorIndex = 0
    
    // Lista de imágenes de médicos (nombres simplificados)
    private let doctorImages = [
        "20250918_2154_Ícono Médico Sublime_simple_compose_01k5fttxp3fyrtrk1vacwhe91f",
        "20250918_2154_Ícono Médico Sublime_simple_compose_01k5fttxp3fyrtrk1vacwhe91f",
        "20250918_2154_Ícono Médico Sublime_simple_compose_01k5fttxp3fyrtrk1vacwhe91f",
        "20250918_2154_Ícono Médico Sublime_simple_compose_01k5fttxp3fyrtrk1vacwhe91f"
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Video de fondo
                VideoBackgroundView()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Header con imagen de médico rotativa
                    VStack(spacing: 10) {
                        Image(doctorImages[currentDoctorIndex])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.red, lineWidth: 3))
                            .shadow(radius: 10)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentDoctorIndex = (currentDoctorIndex + 1) % doctorImages.count
                                }
                            }
                        
                        Text("FIBONACCI APP")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        Text("Medical App with Golden Ratio")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 3)
                    }
                    .padding(.top, 40)
                
                    // Lista de elementos con fondo semitransparente
                    VStack {
                        List {
                            ForEach(items) { item in
                                HStack {
                                    Image(systemName: "medical.thermometer")
                                        .foregroundColor(.red)
                                    Text("Medical Item - \(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))")
                                        .foregroundColor(.primary)
                                }
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(8)
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // Botón para agregar elementos
                    Button(action: addItem) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Medical Item")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("FIBONACCI")
            .navigationBarTitleDisplayMode(.inline)
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

// Video de fondo
struct VideoBackgroundView: View {
    var body: some View {
        // Fondo con gradiente dorado como respaldo
        LinearGradient(
            gradient: Gradient(colors: [
                Color.red.opacity(0.8),
                Color.orange.opacity(0.6),
                Color.yellow.opacity(0.4)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        // Intentar cargar video si está disponible
        .overlay(
            Group {
                if let videoURL = Bundle.main.url(forResource: "20250916_0158_Fibonacci Waves Relaxation_simple_compose_01k58hn45rf1jv2b2xj3nmramk", withExtension: "mp4") {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                }
            }
        )
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
