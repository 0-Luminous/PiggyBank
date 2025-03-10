//
//  HomeView.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // Кастомная панель инструментов
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.09, green: 0.078, blue: 0.086))
                    .frame(height: 120)
                    .overlay(
                        Text("Home")
                            .font(.nunitoSans(32))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.top, 40)
                    )
                Spacer()
            }
            .ignoresSafeArea()

            // Основной контент
            VStack(alignment: .leading, spacing: 20) {
                // Wallet Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Wallet")
                            .font(.nunitoSans(16))
                            .foregroundColor(.gray)
                        Spacer()
                        Image("editPen")
                            .foregroundColor(.gray)
                    }
                    Text("15 000 $")
                        .font(.nunitoSansBold(32))

                    Divider()
                        .background(Color.gray.opacity(0.3))
                        .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 80)

                // Add shares section
                VStack(spacing: 16) {
                    Text("Add shares")
                        .font(.nunitoSans(16))
                        .foregroundColor(.white)

                    Button(action: {
                        // Действие для добавления акций
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 133)

                Spacer()
            }
        }
        .background(Color(red: 0.145, green: 0.129, blue: 0.129))
    }
}
