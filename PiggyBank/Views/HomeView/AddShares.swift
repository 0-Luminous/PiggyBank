//
//  AddShares.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//

import CoreData
import SwiftUI

struct AddShares: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StockEntity.name, ascending: true)],
        animation: .default)
    private var stocks: FetchedResults<StockEntity>

    @State private var searchText = ""

    private func addStock(
        symbol: String, name: String, logo: String, price: Double, priceChange: Double
    ) {
        let context = PersistenceController.shared.viewContext
        let newStock = StockEntity(context: context)
        newStock.id = UUID()
        newStock.symbol = symbol
        newStock.name = name
        newStock.logo = logo
        newStock.price = price
        newStock.priceChange = priceChange
        newStock.quantity = 0

        PersistenceController.shared.save()
    }

    private func updateStock(_ stock: StockEntity, quantity: Int) {
        stock.quantity = Int16(quantity)
        PersistenceController.shared.save()
    }

    private func initializeStocksIfNeeded() {
        let context = PersistenceController.shared.viewContext
        let fetchRequest: NSFetchRequest<StockEntity> = StockEntity.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                // Добавляем начальные данные
                addStock(
                    symbol: "AAPL", name: "Apple", logo: "brands/apple", price: 2850,
                    priceChange: 11.2)
                addStock(
                    symbol: "AMZN", name: "Amazon", logo: "brands/amazon", price: 2100,
                    priceChange: 8.6)
                addStock(
                    symbol: "YUM", name: "KFC", logo: "brands/kfc", price: 3400, priceChange: 21.5)
                addStock(
                    symbol: "RAIF", name: "Raiffeisen", logo: "brands/raiffeisen", price: 3120,
                    priceChange: 15.3)
                addStock(
                    symbol: "GOOGL", name: "Google", logo: "brands/google", price: 996,
                    priceChange: 6.6)
                addStock(
                    symbol: "PEP", name: "Lays", logo: "brands/lays", price: 544, priceChange: 4.5)
            }
        } catch {
            print("Error checking for existing stocks: \(error)")
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Кастомная панель инструментов
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.09, green: 0.078, blue: 0.086))
                        .frame(height: 120)
                        .overlay(
                            HStack {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20))
                                        .padding(.leading, 20)
                                }

                                Text("Collect a briefcase")
                                    .font(.nunitoSans(24))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 8)

                                Spacer()
                            }
                            .padding(.top, 40)
                        )
                    Spacer()
                }
                .ignoresSafeArea()

                VStack {
                    // Wallet section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wallet")
                            .foregroundStyle(.gray)
                            .font(.system(size: 16))
                        Text("15 731 $")
                            .font(.nunitoSansBold(32))
                            .foregroundStyle(.white)
                        Divider()
                            .background(Color.gray.opacity(0.3))
                    }
                    .padding(.horizontal)

                    // Shares section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Shares")
                            .foregroundStyle(.gray)
                            .font(.system(size: 16))
                            .padding(.horizontal)

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
                                .stroke(Color(red: 0.282, green: 0.267, blue: 0.267), lineWidth: 1)
                        )
                        .padding(.horizontal)

                        // Shares list
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(stocks) { stock in
                                    HStack {
                                        Image(stock.logo ?? "")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 32, height: 32)
                                            .clipShape(Circle())
                                            .background(Color.white)
                                            .clipShape(Circle())
                                        Text(stock.name ?? "")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 16))

                                        Spacer()

                                        VStack(alignment: .trailing, spacing: 4) {
                                            Text("\(Int(stock.price)) $")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("+ \(String(format: "%.1f", stock.priceChange))%")
                                                .foregroundStyle(.green)
                                                .font(.system(size: 12))
                                        }

                                        HStack(spacing: 16) {
                                            Button(action: {
                                                if stock.quantity > 0 {
                                                    updateStock(
                                                        stock, quantity: Int(stock.quantity) - 1)
                                                }
                                            }) {
                                                Image(systemName: "minus")
                                                    .foregroundStyle(.white)
                                            }

                                            Text("\(stock.quantity)")
                                                .foregroundStyle(.white)
                                                .frame(minWidth: 20)

                                            Button(action: {
                                                updateStock(
                                                    stock, quantity: Int(stock.quantity) + 1)
                                            }) {
                                                Image(systemName: "plus")
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .padding(.leading)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }

                    Spacer()

                    // Bottom buttons
                    HStack(spacing: 16) {
                        Button(action: {
                            // Действие для кнопки Cancel
                            dismiss()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(16)
                        }

                        Button(action: {
                            // Действие для кнопки Save
                            dismiss()
                        }) {
                            Text("Save")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(.white)
                                .cornerRadius(16)
                        }
                    }
                    .padding()
                }
                .padding(.top, 120)
            }
            .onAppear {
                initializeStocksIfNeeded()
            }
            .background(Color(red: 0.145, green: 0.129, blue: 0.129))
            .toolbar(.hidden, for: .tabBar)
            .preferredColorScheme(.dark)
        }
    }
}
