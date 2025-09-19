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
    @State private var showingMedicalGames = false
    @State private var showingAIAssistant = false
    
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
                            Group {
                                if let imagePath = Bundle.main.path(forResource: "fibonacci-logo", ofType: "png"),
                                   let image = UIImage(contentsOfFile: imagePath) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 150)
                                        .shadow(radius: 8)
                                        .onTapGesture {
                                            // Conectar a Vaser Token Wallet
                                            walletService.connectVaserToken()
                                            showingWalletSelection = true
                                        }
                                } else {
                                    // Fallback con imagen del sistema
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.blue.opacity(0.6))
                                        .frame(width: 150, height: 150)
                                        .overlay(
                                            VStack(spacing: 5) {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 40))
                                                    .foregroundColor(.white)
                                                Text("FIBONACCI")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                            }
                                        )
                                        .shadow(radius: 8)
                                        .onTapGesture {
                                            // Conectar a Vaser Token Wallet
                                            walletService.connectVaserToken()
                                            showingWalletSelection = true
                                        }
                                }
                            }
                            
                            // Iconos de plataformas como referencia
                            HStack(spacing: 15) {
                                // Solana
                                Image(systemName: "s.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.purple)
                                    .shadow(radius: 2)
                                
                                // TON
                                Image(systemName: "t.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .shadow(radius: 2)
                                
                                // Telegram
                                Image(systemName: "paperplane.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.cyan)
                                    .shadow(radius: 2)
                                
                                // Apple
                                Image(systemName: "applelogo")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)
                                
                                // Algorand
                                Image(systemName: "a.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                    .shadow(radius: 2)
                            }
                            .padding(.top, 5)
                            
                            Text("App Médica de Simulación con Asistentes de IA")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.9))
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                            
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
                        
                        // Videos de Apps Médicas
                        VStack(spacing: 20) {
                            // Fila de logos de video - Juegos Médicos e IA Asistente
                            HStack(spacing: 30) {
                                // Video Juegos Médicos (circular)
                                VStack(spacing: 8) {
                                        Button(action: {
                                            // Mostrar vista de juegos médicos
                                            showingMedicalGames = true
                                        }) {
                                        if let videoURL = Bundle.main.url(forResource: "doc-games", withExtension: "mp4") {
                                            VideoPlayer(player: {
                                                let player = AVPlayer(url: videoURL)
                                                player.play() // Autoplay
                                                return player
                                            }())
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.purple, lineWidth: 3)
                                            )
                                        }
                                    }
                                    
                                    Text("Juegos Médicos")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .shadow(radius: 2)
                                }
                                
                                // Video IA Asistente (circular)
                                VStack(spacing: 8) {
                                        Button(action: {
                                            // Mostrar vista de IA asistente
                                            showingAIAssistant = true
                                        }) {
                                        if let videoURL = Bundle.main.url(forResource: "IA-ASIST", withExtension: "mp4") {
                                            VideoPlayer(player: {
                                                let player = AVPlayer(url: videoURL)
                                                player.play() // Autoplay
                                                return player
                                            }())
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.cyan, lineWidth: 3)
                                            )
                                        }
                                    }
                                    
                                    Text("IA Asistente")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .shadow(radius: 2)
                                }
                            }
                            
                            // Video Vaser Token como botón principal
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
                                    
                                    Text("Conectar Wallet")
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
                            
                        }
                        .padding(.bottom, 20)
                        
                        // Texto de derechos reservados
                        Text("PANACEA ICONO S.A.")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 2)
                            .padding(.bottom, 10)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("FIBONACCI")
                .navigationBarTitleDisplayMode(.large)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.clear, for: .navigationBar)
                .toolbarTitleDisplayMode(.large)
            }
            .sheet(isPresented: $showingWalletSelection) {
                WalletSelectionView(walletService: walletService)
            }
            .sheet(isPresented: $showingMedicalGames) {
                MedicalGamesView()
            }
            .sheet(isPresented: $showingAIAssistant) {
                AIAssistantView()
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