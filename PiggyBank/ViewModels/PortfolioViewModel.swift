import Foundation
import SwiftUI

class PortfolioViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var totalValue: Double = 0
    
    init() {
        loadMockData()
        calculateTotalValue()
    }
    
    private func loadMockData() {
        stocks = [
            Stock(symbol: "BMW", name: "BMW", price: 3400, change: 21.5),
            Stock(symbol: "VK", name: "Vkontakte", price: 3120, change: 15.3),
            Stock(symbol: "TT", name: "Tik Tok", price: 2850, change: 11.2),
            Stock(symbol: "NFLX", name: "Netflix", price: 2100, change: 8.6),
            Stock(symbol: "MI", name: "Xiaomi", price: 996, change: 6.6),
            Stock(symbol: "SMSNG", name: "Samsung", price: 544, change: 4.5)
        ]
    }
    
    private func calculateTotalValue() {
        totalValue = stocks.reduce(0) { $0 + $1.price }
    }
} 
