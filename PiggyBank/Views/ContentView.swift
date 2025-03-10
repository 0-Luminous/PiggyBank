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
                        HStack {
                            Text("Wallet")
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "pencil")
                                .foregroundColor(.gray)
                        }
                        Text("\(Int(viewModel.totalValue)) $")
                            .font(.system(size: 34, weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    // Shares Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Shares")
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "pencil")
                                .foregroundColor(.gray)
                        }
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search", text: $searchText)
                        }
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
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
                .background(Color.black)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            ProfitView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Profit")
                }
            QuotesView()
                .tabItem {
                    Image(systemName: "quote.bubble")
                    Text("Quotes")
                }
            BankView()
                .tabItem {
                    Image(systemName: "building.columns")
                    Text("Bank")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("Settings")
                }
        }
        .tint(.white)
        .preferredColorScheme(.dark)
    }
} 
