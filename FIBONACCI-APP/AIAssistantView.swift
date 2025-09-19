//
//  AIAssistantView.swift
//  FIBONACCI-APP
//
//  Created by Nuevo Usuario on 19/9/25.
//

import SwiftUI
import AVKit

struct AIAssistantView: View {
    @Environment(\.dismiss) var dismiss
    @State private var rotationAngle: Double = 0
    @State private var glowIntensity: Double = 0.5
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo animado con partículas
                ParticleBackground()
                    .ignoresSafeArea(.all)
                
                // Contenido principal
                ScrollView {
                    VStack(spacing: 30) {
                        // Header con logo animado
                        VStack(spacing: 20) {
                            // Logo de IA con animación de rotación
                            ZStack {
                                Circle()
                                    .fill(
                                        RadialGradient(
                                            gradient: Gradient(colors: [
                                                Color.cyan.opacity(0.8),
                                                Color.blue.opacity(0.4)
                                            ]),
                                            center: .center,
                                            startRadius: 20,
                                            endRadius: 60
                                        )
                                    )
                                    .frame(width: 120, height: 120)
                                    .scaleEffect(1.0 + glowIntensity * 0.2)
                                    .animation(
                                        Animation.easeInOut(duration: 1.5)
                                            .repeatForever(autoreverses: true),
                                        value: glowIntensity
                                    )
                                
                                Image(systemName: "brain.head.profile")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(rotationAngle))
                                    .animation(
                                        Animation.linear(duration: 10.0)
                                            .repeatForever(autoreverses: false),
                                        value: rotationAngle
                                    )
                                    .shadow(radius: 5)
                            }
                            .onAppear {
                                rotationAngle = 360
                                glowIntensity = 1.0
                            }
                            
                            Text("IA ASISTENTE MÉDICO")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                            
                            Text("Asistencia Inteligente para Profesionales de la Salud")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 40)
                        
                        // Características de la IA
                        VStack(spacing: 20) {
                            AIFeatureCard(
                                icon: "waveform",
                                title: "Análisis de Síntomas",
                                description: "IA avanzada para diagnóstico preliminar",
                                color: .cyan
                            )
                            
                            AIFeatureCard(
                                icon: "doc.text.magnifyingglass",
                                title: "Revisión de Casos",
                                description: "Análisis inteligente de historiales médicos",
                                color: .blue
                            )
                            
                            AIFeatureCard(
                                icon: "pills.fill",
                                title: "Recomendaciones de Tratamiento",
                                description: "Sugerencias basadas en evidencia científica",
                                color: .green
                            )
                            
                            AIFeatureCard(
                                icon: "chart.line.uptrend.xyaxis",
                                title: "Predicción de Resultados",
                                description: "Modelos predictivos para pronósticos",
                                color: .orange
                            )
                            
                            AIFeatureCard(
                                icon: "book.fill",
                                title: "Base de Conocimiento",
                                description: "Acceso a la literatura médica más reciente",
                                color: .purple
                            )
                        }
                        .padding(.horizontal)
                        
                        // Botón de acceso
                        Button(action: {
                            // Abrir IA asistente
                            if let url = URL(string: "https://ia-asistente.fibonacci-app.com/assistant") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("ACTIVAR IA ASISTENTE")
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.cyan, Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .shadow(radius: 10)
                        }
                        .padding(.horizontal)
                        
                        // Footer
                        Text("Powered by Panacea Icono S.A.")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("IA Asistente")
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

struct AIFeatureCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    @State private var cardScale: CGFloat = 0.8
    @State private var cardOpacity: Double = 0
    
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
        .scaleEffect(cardScale)
        .opacity(cardOpacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6).delay(Double.random(in: 0...0.8))) {
                cardScale = 1.0
                cardOpacity = 1.0
            }
        }
    }
}

struct ParticleBackground: View {
    @State private var particles: [Particle] = []
    
    var body: some View {
        ZStack {
            // Fondo base
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.cyan.opacity(0.8),
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Partículas animadas
            ForEach(particles, id: \.id) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .onAppear {
            generateParticles()
            animateParticles()
        }
    }
    
    private func generateParticles() {
        particles = (0..<50).map { _ in
            Particle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                ),
                size: CGFloat.random(in: 2...8),
                color: [Color.white, Color.cyan, Color.blue].randomElement() ?? .white,
                opacity: Double.random(in: 0.3...0.8)
            )
        }
    }
    
    private func animateParticles() {
        withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: false)) {
            for i in particles.indices {
                particles[i].position = CGPoint(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                )
            }
        }
    }
}

struct Particle {
    let id = UUID()
    var position: CGPoint
    let size: CGFloat
    let color: Color
    let opacity: Double
}

#Preview {
    AIAssistantView()
}
