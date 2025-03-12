import Foundation

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let logo: String
    let price: Double
    let change: Double
    var quantity: Int
} 
