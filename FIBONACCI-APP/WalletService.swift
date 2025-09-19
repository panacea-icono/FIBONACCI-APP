//
//  WalletService.swift
//  FIBONACCI-APP
//
//  Created by Nuevo Usuario on 18/9/25.
//

import Foundation
import SwiftUI
import Combine

// MARK: - Wallet Types
enum WalletType: String, CaseIterable {
    case algorand = "Algorand"
    case solana = "Solana"
    case tom = "TOM"
    
    var displayName: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .algorand:
            return "diamond.fill"
        case .solana:
            return "sun.max.fill"
        case .tom:
            return "atom"
        }
    }
    
    var color: Color {
        switch self {
        case .algorand:
            return .blue
        case .solana:
            return .purple
        case .tom:
            return .green
        }
    }
    
    var deepLink: String {
        switch self {
        case .algorand:
            return "algorand://wallet/connect?app=fibonacci-medical&callback=fibonacci://wallet/callback"
        case .solana:
            return "phantom://wallet/connect?app=fibonacci-medical&callback=fibonacci://wallet/callback"
        case .tom:
            return "ton://wallet/connect?app=fibonacci-medical&callback=fibonacci://wallet/callback"
        }
    }
    
    var webURL: String {
        switch self {
        case .algorand:
            return "https://wallet.myalgo.com/connect?app=fibonacci-medical&redirect=fibonacci://wallet/success"
        case .solana:
            return "https://phantom.app/ul/v1/connect?app=fibonacci-medical&redirect=fibonacci://wallet/success"
        case .tom:
            return "https://wallet.ton.org/connect?app=fibonacci-medical&redirect=fibonacci://wallet/success"
        }
    }
}

// MARK: - Wallet Service
class WalletService: ObservableObject {
    @Published var isConnected = false
    @Published var connectedWallet: WalletType?
    @Published var walletAddress: String?
    @Published var showingWalletSelection = false
    
    // MARK: - Wallet Connection
    func connectWallet(_ walletType: WalletType) {
        // Simular conexión de billetera
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isConnected = true
            self.connectedWallet = walletType
            self.walletAddress = self.generateMockAddress(for: walletType)
            self.showingWalletSelection = false
        }
    }
    
    func disconnectWallet() {
        isConnected = false
        connectedWallet = nil
        walletAddress = nil
    }
    
    // MARK: - Deep Link Handling
    func openWalletApp(_ walletType: WalletType) {
        if let url = URL(string: walletType.deepLink) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Si no puede abrir la app, abrir en navegador
                openWalletWeb(walletType)
            }
        }
    }
    
    func openWalletWeb(_ walletType: WalletType) {
        if let url = URL(string: walletType.webURL) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Mock Data
    private func generateMockAddress(for walletType: WalletType) -> String {
        let prefix = walletType.rawValue.prefix(3).uppercased()
        let randomSuffix = String((0..<20).map { _ in "0123456789ABCDEF".randomElement()! })
        return "\(prefix)\(randomSuffix)"
    }
    
    // MARK: - Vaser Token Integration
    func connectVaserToken() {
        showingWalletSelection = true
    }
    
    func getVaserTokenInfo() -> (name: String, symbol: String, price: Double, videoName: String) {
        return (
            name: "Vaser Token",
            symbol: "VASER",
            price: 0.618, // Golden ratio price
            videoName: "vaser-token" // Video logo del Vaser Token
        )
    }
}
