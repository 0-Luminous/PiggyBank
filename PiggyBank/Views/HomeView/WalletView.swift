//
//  Wallet.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//

import CoreData
import SwiftUI

struct WalletView: View {
    @State private var balance: String = ""
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    @StateObject private var persistence = PersistenceController.shared

    private var currentBalance: String {
        let context = persistence.viewContext
        let fetchRequest: NSFetchRequest<WalletEntity> = WalletEntity.fetchRequest()

        do {
            let wallets = try context.fetch(fetchRequest)
            if let existingWallet = wallets.first {
                return String(format: "%.2f", existingWallet.balance)
            }
        } catch {
            print("Error fetching wallet: \(error)")
        }
        return ""
    }

    private func saveBalance() {
        let context = persistence.viewContext
        let fetchRequest: NSFetchRequest<WalletEntity> = WalletEntity.fetchRequest()

        do {
            let wallets = try context.fetch(fetchRequest)
            let wallet: WalletEntity
            if let existingWallet = wallets.first {
                wallet = existingWallet
            } else {
                wallet = WalletEntity(context: context)
            }

            let cleanBalance =
                balance
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ",", with: ".")

            if !cleanBalance.isEmpty {
                wallet.balance = Double(cleanBalance) ?? 0
            }

            persistence.save()
        } catch {
            print("Error saving wallet: \(error)")
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Фоновое изображение
                Image("BackgroundFrame")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 24) {
                    // Заголовок
                    Text("Enter Your\nAccount Balance")
                        .font(.nunitoSansBold(36))
                        .foregroundStyle(.white)

                    // Поле ввода
                    HStack {
                        Text("Wallet")
                            .foregroundStyle(.white)
                            .font(.nunitoSans(16))

                        TextField(
                            "", text: $balance,
                            prompt: Text(currentBalance)
                                .foregroundColor(.white.opacity(0.3))
                        )
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.system(size: 16))
                        .focused($isFocused)

                        Text("$")
                            .foregroundStyle(.white.opacity(0.7))
                            .font(.system(size: 16))
                    }
                    .padding()
                    .background(Color.white.opacity(0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 1)
                    )

                    // Кнопка
                    Button(action: {
                        saveBalance()
                        dismiss()
                    }) {
                        Text("Let's start")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(.white)
                            .cornerRadius(16)
                    }
                    .padding(.top, 155)
                }
                .padding(.horizontal, 16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
        .preferredColorScheme(.dark)
    }
}
