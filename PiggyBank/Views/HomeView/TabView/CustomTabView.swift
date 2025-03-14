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

        // Настраиваем шрифт меньшего размера
        let font = UIFont.systemFont(ofSize: 10)

        // Неактивное состояние - серый цвет
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: font,
        ]

        // Активное состояние - белый цвет
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: font,
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
    }
}
