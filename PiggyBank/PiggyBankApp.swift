//
//  PiggyBankApp.swift
//  PiggyBank
//
//  Created by Yan on 7/3/25.
//

import CoreData
import SwiftUI

@main
struct PiggyBankApp: App {
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted = false
    @AppStorage("appLaunchCount") private var appLaunchCount = 0
    let persistenceController = PersistenceController.shared

    init() {
        // Увеличиваем счетчик запусков приложения
        appLaunchCount += 1

        // Проверяем, является ли это третьим запуском
        if appLaunchCount >= 3 {
            isOnboardingCompleted = true
        }

        // Инициализируем кошелек сразу при запуске приложения
        initializeWalletIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            if isOnboardingCompleted {
                CustomTabView()
                    .environment(
                        \.managedObjectContext, persistenceController.container.viewContext)
            } else {
                LoadingView()
                    .environment(
                        \.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }

    private func initializeWalletIfNeeded() {
        let context = persistenceController.viewContext
        let fetchRequest: NSFetchRequest<WalletEntity> = WalletEntity.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                let wallet = WalletEntity(context: context)
                wallet.balance = 0
                try context.save()
                print("Wallet initialized with balance: 0")
            } else {
                print("Wallet already exists")
            }
        } catch {
            print("Error initializing wallet: \(error)")
        }
    }
}
