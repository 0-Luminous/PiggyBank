//
//  PiggyBankApp.swift
//  PiggyBank
//
//  Created by Yan on 7/3/25.
//

import SwiftUI

@main
struct PiggyBankApp: App {
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted = false
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if true {
                CustomTabView()
                    .environment(
                        \.managedObjectContext, persistenceController.container.viewContext)
            } else {
                LoadingView()
            }
        }
    }
}
