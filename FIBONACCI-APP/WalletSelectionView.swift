//
//  WalletSelectionView.swift
//  FIBONACCI-APP
//
//  Created by Nuevo Usuario on 18/9/25.
//

import SwiftUI
import AVKit

struct WalletSelectionView: View {
    @ObservedObject var walletService: WalletService
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 10) {
                    Image(systemName: "wallet.pass.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Conectar Billetera")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Selecciona tu billetera para conectar con Vaser Token")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Wallet Options
                VStack(spacing: 15) {
                    ForEach(WalletType.allCases, id: \.self) { walletType in
                        WalletOptionView(
                            walletType: walletType,
                            onTap: {
                                walletService.connectWallet(walletType)
                            }
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Vaser Token Info con video
                VStack(spacing: 10) {
                    // Video del Vaser Token
                    if let videoURL = Bundle.main.url(forResource: "vaser-token", withExtension: "mp4") {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(height: 120)
                            .cornerRadius(10)
                            .clipped()
                    }
                    
                    Text("Vaser Token (VASER)")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Precio: $0.618 (Golden Ratio)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Moneda oficial de la app Fibonacci")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Billeteras")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Cerrar") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct WalletOptionView: View {
    let walletType: WalletType
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 15) {
                Image(systemName: walletType.icon)
                    .font(.system(size: 30))
                    .foregroundColor(walletType.color)
                    .frame(width: 50, height: 50)
                    .background(walletType.color.opacity(0.1))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(walletType.displayName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Conectar con \(walletType.displayName)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    WalletSelectionView(walletService: WalletService())
}
