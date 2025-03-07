import Foundation

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    
    var changePercentage: String {
        return String(format: "%.1f%%", change)
    }
    
    var formattedPrice: String {
        return String(format: "%.0f $", price)
    }
} 