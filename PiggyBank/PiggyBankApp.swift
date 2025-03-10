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
    
    var body: some Scene {
        WindowGroup {
            if isOnboardingCompleted {
                CustomTabView()
            } else {
                LoadingView()
            }
        }
    }
}
