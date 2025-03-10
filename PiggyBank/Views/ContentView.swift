import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var searchText = ""
    
    var filteredStocks: [Stock] {
        if searchText.isEmpty {
            return viewModel.stocks
        } else {
            return viewModel.stocks.filter { stock in
                stock.name.lowercased().contains(searchText.lowercased()) ||
                stock.symbol.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
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
                        ForEach(filteredStocks) { stock in
                            StockRowView(stock: stock)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .navigationBarHidden(true)
                .background(Color(uiColor: .systemBackground))
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
