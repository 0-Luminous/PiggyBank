//
//  PiggyBankApp.swift
//  PiggyBank
//
//  Created by Yan on 7/3/25.
//

import SwiftUI

@main
struct PiggyBankApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
