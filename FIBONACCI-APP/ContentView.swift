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
    @StateObject private var walletService = WalletService()
    @State private var showingWalletSelection = false
    
    // Lista de imágenes de médicos
    private let doctorImages = [
        "fibonacci-logo",
        "IA-ASIST",
        "fibonacci-logo",
        "IA-ASIST"
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Video de fondo completo
                VideoBackgroundView()
                    .ignoresSafeArea(.all)
                
                // Contenido principal
                ScrollView {
                    VStack(spacing: 20) {
                        // Header con logo de Fibonacci arriba
                        VStack(spacing: 10) {
                            // Logo de Fibonacci en la parte superior
                            Image("fibonacci-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 8)
                                .onTapGesture {
                                    // Conectar a Vaser Token Wallet
                                    walletService.connectVaserToken()
                                    showingWalletSelection = true
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
                            
                            // Vaser Token Info
                            if walletService.isConnected {
                                VStack(spacing: 5) {
                                    Text("VASER Token Conectado")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                        .fontWeight(.bold)
                                    
                                    Text("Billetera: \(walletService.connectedWallet?.displayName ?? "")")
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Dirección: \(walletService.walletAddress?.prefix(8) ?? "")...")
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(8)
                            } else {
                                Text("Toca el logo para conectar Vaser Token")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                                    .fontWeight(.bold)
                            }
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
                        
                        // Video Vaser Token como botón principal
                        VStack(spacing: 15) {
                            // Video Vaser Token clickeable
                            Button(action: {
                                if walletService.isConnected {
                                    walletService.disconnectWallet()
                                } else {
                                    showingWalletSelection = true
                                }
                            }) {
                                VStack(spacing: 10) {
                                    // Video del Vaser Token (circular con autoplay)
                                    if let videoURL = Bundle.main.url(forResource: "vaser-token", withExtension: "mp4") {
                                        VideoPlayer(player: {
                                            let player = AVPlayer(url: videoURL)
                                            player.play() // Autoplay
                                            return player
                                        }())
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(walletService.isConnected ? Color.green : Color.blue, lineWidth: 3)
                                        )
                                    }
                                    
                                    Text(walletService.isConnected ? "VASER Token Conectado" : "Conectar VASER Token")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .shadow(radius: 3)
                                }
                                .padding()
                                .background(walletService.isConnected ? Color.green.opacity(0.3) : Color.blue.opacity(0.3))
                                .cornerRadius(20)
                                .shadow(radius: 8)
                            }
                            
                            // Botón para agregar elementos médicos
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
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("FIBONACCI")
                .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(isPresented: $showingWalletSelection) {
                WalletSelectionView(walletService: walletService)
            }
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
        
        // Intentar cargar video si está disponible (con autoplay)
        .overlay(
            Group {
                if let videoURL = Bundle.main.url(forResource: "fondo", withExtension: "mp4") {
                    VideoPlayer(player: {
                        let player = AVPlayer(url: videoURL)
                        player.play() // Autoplay
                        return player
                    }())
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea(.all)
                }
            }
        )
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}