import SwiftUI

struct StockRowView: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            // Stock Icon and Name
            HStack(spacing: 12) {
                Image(stock.symbol.lowercased())
                    .resizable()
                    .frame(width: 32, height: 32)
                    .cornerRadius(16)
                
                Text(stock.name)
                    .font(.system(size: 16))
            }
            
            Spacer()
            
            // Price and Change
            VStack(alignment: .trailing, spacing: 4) {
                Text(stock.formattedPrice)
                    .font(.system(size: 16, weight: .medium))
                Text("+" + stock.changePercentage)
                    .foregroundColor(.green)
                    .font(.system(size: 14))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    StockRowView(stock: Stock(symbol: "AAPL", name: "Apple Inc.", price: 150.0, change: 2.5))
        .padding()
} 