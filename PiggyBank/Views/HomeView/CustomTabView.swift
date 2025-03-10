//
//  CustomTabView.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//
import SwiftUI

struct CustomTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.09, green: 0.078, blue: 0.086, alpha: 1.0)

        // Применяем внешний вид для обоих состояний
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image("Home")
                Text("Home")
            }

            ProfitView()
                .tabItem {
                    Image("arrow-growth")
                    Text("Profit")
                }

            QuotesView()
                .tabItem {
                    Image("Message1")
                    Text("Quotes")
                }

            BankView()
                .tabItem {
                    Image("piggyBank")
                    Text("Bank")
                }

            SettingsView()
                .tabItem {
                    Image("equalizer")
                    Text("Settings")
                }
        }
        .tint(.white)
        .preferredColorScheme(.dark)
        .onAppear {
            // Активируем наше расширение для UITabBarController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let tabBarController = windowScene.windows.first?.rootViewController
                    as? UITabBarController
            {
                tabBarController.viewWillLayoutSubviews()
            }
        }
    }
}
