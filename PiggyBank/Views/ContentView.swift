import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var searchText = ""
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack(spacing: 20) {
                    // Wallet Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wallet")
                            .foregroundColor(.gray)
                        Text("\(Int(viewModel.totalValue)) $")
                            .font(.system(size: 34, weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    // Shares Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Shares")
                            .foregroundColor(.gray)
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search", text: $searchText)
                        }
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Stocks List
                    List {
                        ForEach(viewModel.stocks) { stock in
                            StockRowView(stock: stock)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            Color.clear
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Profit")
                }
            Color.clear
                .tabItem {
                    Image(systemName: "quote.bubble")
                    Text("Quotes")
                }
            Color.clear
                .tabItem {
                    Image(systemName: "building.columns")
                    Text("Bank")
                }
            Color.clear
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("Settings")
                }
        }
        .tint(.primary)
    }
} 