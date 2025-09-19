//
//  MedicalGamesView.swift
//  FIBONACCI-APP
//
//  Created by Nuevo Usuario on 19/9/25.
//

import SwiftUI
import AVKit

struct MedicalGamesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var animationOffset: CGFloat = 0
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo animado con gradiente suave
                AnimatedGradientBackground()
                    .ignoresSafeArea(.all)
                
                // Contenido principal
                ScrollView {
                    VStack(spacing: 30) {
                        // Header con logo animado
                        VStack(spacing: 20) {
                            // Logo de juegos médicos con animación
                            ZStack {
                                Circle()
                                    .fill(Color.purple.opacity(0.3))
                                    .frame(width: 120, height: 120)
                                    .scaleEffect(pulseScale)
                                    .animation(
                                        Animation.easeInOut(duration: 2.0)
                                            .repeatForever(autoreverses: true),
                                        value: pulseScale
                                    )
                                
                                Image(systemName: "gamecontroller.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                            }
                            .onAppear {
                                pulseScale = 1.2
                            }
                            
                            Text("JUEGOS MÉDICOS")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                            
                            Text("Simulación Interactiva para Profesionales de la Salud")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 40)
                        
                        // Características de los juegos
                        VStack(spacing: 20) {
                            GameFeatureCard(
                                icon: "stethoscope",
                                title: "Diagnóstico Virtual",
                                description: "Practica diagnósticos con casos reales",
                                color: .blue
                            )
                            
                            GameFeatureCard(
                                icon: "heart.fill",
                                title: "Cirugía Simulada",
                                description: "Entrena procedimientos quirúrgicos",
                                color: .red
                            )
                            
                            GameFeatureCard(
                                icon: "brain.head.profile",
                                title: "Neuroanatomía",
                                description: "Explora el sistema nervioso",
                                color: .purple
                            )
                            
                            GameFeatureCard(
                                icon: "cross.fill",
                                title: "Emergencias",
                                description: "Responde a situaciones críticas",
                                color: .orange
                            )
                        }
                        .padding(.horizontal)
                        
                        // Botón de acceso
                        Button(action: {
                            // Abrir juegos médicos
                            if let url = URL(string: "https://juegos-medicos.fibonacci-app.com/games") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("COMENZAR JUEGOS")
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .shadow(radius: 10)
                        }
                        .padding(.horizontal)
                        
                        // Footer
                        Text("Desarrollado por Panacea Icono S.A.")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Juegos Médicos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct GameFeatureCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    @State private var cardOffset: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(Color.white.opacity(0.2))
                .cornerRadius(25)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 5)
        .offset(x: cardOffset)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6).delay(Double.random(in: 0...0.5))) {
                cardOffset = 0
            }
        }
    }
}

struct AnimatedGradientBackground: View {
    @State private var gradientOffset: CGFloat = 0
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.purple.opacity(0.8),
                Color.blue.opacity(0.6),
                Color.cyan.opacity(0.4),
                Color.purple.opacity(0.8)
            ]),
            startPoint: UnitPoint(x: gradientOffset, y: 0),
            endPoint: UnitPoint(x: 1 - gradientOffset, y: 1)
        )
        .onAppear {
            withAnimation(
                Animation.linear(duration: 8.0)
                    .repeatForever(autoreverses: true)
            ) {
                gradientOffset = 1.0
            }
        }
    }
}

#Preview {
    MedicalGamesView()
}
