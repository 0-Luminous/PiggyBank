//
//  HomeView.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//
import SwiftUI

struct HomeView: View {
    @State private var walletBalance: String = "15 000 $"

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // Кастомная панель инструментов
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.09, green: 0.078, blue: 0.086))
                        .frame(height: 120)
                        .overlay(
                            Text("Home")
                                .font(.nunitoSans(32))
                                .foregroundStyle(.white)
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
                                .foregroundStyle(.gray)
                            Spacer()
                            NavigationLink {
                                WalletView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Image("editPen")
                                    .foregroundStyle(.gray)
                            }
                        }
                        Text(walletBalance)
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
                            .foregroundStyle(.white)

                        NavigationLink {
                            AddShares()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundStyle(.black)
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
}
