//
//  HomeView.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//
import SwiftUI

struct HomeView: View {
    @State private var walletBalance: String = "15 000 $"
    @StateObject private var persistence = PersistenceController.shared
    @State private var searchText: String = ""

    @FetchRequest(
        entity: StockEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StockEntity.name, ascending: true)],
        predicate: NSPredicate(format: "quantity > 0"),
        animation: .default
    ) private var purchasedStocks: FetchedResults<StockEntity>

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
                                .padding(.top, 50)
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

                    // Purchased Stocks Section
                    if !purchasedStocks.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Shares")
                                    .font(.nunitoSans(16))
                                    .foregroundStyle(.gray)
                                Spacer()
                                NavigationLink {
                                    AddShares()
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    Image("editPen")
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.horizontal, 20)

                            // Search field
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.white)
                                TextField("", text: $searchText)
                                    .foregroundStyle(.white)
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        Color(red: 0.282, green: 0.267, blue: 0.267), lineWidth: 1)
                            )
                            .padding(.horizontal, 20)

                            VStack {
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack(spacing: 0) {
                                        ForEach(purchasedStocks) { stock in
                                            VStack(spacing: 0) {
                                                HStack(spacing: 12) {
                                                    Image(stock.logo ?? "")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40, height: 40)
                                                        .clipShape(Circle())
                                                        .background(Color.white)
                                                        .clipShape(Circle())

                                                    Text(stock.name ?? "")
                                                        .font(.nunitoSans(14))
                                                        .foregroundStyle(.white)

                                                    Spacer()

                                                    VStack(alignment: .trailing, spacing: 4) {
                                                        Text("\(Int(stock.price)) $")
                                                            .font(
                                                                .system(size: 16, weight: .semibold)
                                                            )
                                                            .foregroundStyle(.white)

                                                        Text(
                                                            "+ \(String(format: "%.1f", stock.priceChange))%"
                                                        )
                                                        .font(.system(size: 12))
                                                        .foregroundStyle(.green)
                                                    }
                                                }
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 12)
                                                .frame(maxWidth: .infinity)

                                                Divider()
                                                    .background(Color.gray.opacity(0.3))
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                    }

                    // Add shares section
                    if purchasedStocks.isEmpty {
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
                    }

                    Spacer()
                }
            }
            .background(Color(red: 0.145, green: 0.129, blue: 0.129))
            .environment(\.managedObjectContext, persistence.viewContext)
        }
    }
}
