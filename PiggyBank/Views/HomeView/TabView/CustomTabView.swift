//
//  CustomTabView.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//
import SwiftUI
import UIKit

struct CustomTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.09, green: 0.078, blue: 0.086, alpha: 1.0)

        // Настраиваем цвета для неактивного состояния (серый)
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]

        // Настраиваем цвета для активного состояния (белый)
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

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
                    .renderingMode(.template)  // Важно для перекрашивания
                Text("Home")
            }

            ProfitView()
                .tabItem {
                    Image("arrow-growth")
                        .renderingMode(.template)
                    Text("Profit")
                }

            QuotesView()
                .tabItem {
                    Image("Message1")
                        .renderingMode(.template)
                    Text("Quotes")
                }

            BankView()
                .tabItem {
                    Image("piggyBank")
                        .renderingMode(.template)
                    Text("Bank")
                }

            SettingsView()
                .tabItem {
                    Image("equalizer")
                        .renderingMode(.template)
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
