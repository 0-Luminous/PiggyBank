import SwiftUI

struct StockRowView: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            // Stock Icon and Name
            HStack(spacing: 12) {
                Image(stock.symbol.lowercased())
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(8)
                    .background(Color.gray.opacity(0.1))
                
                VStack(alignment: .leading) {
                    Text(stock.name)
                        .font(.headline)
                }
            }
            
            Spacer()
            
            // Price and Change
            VStack(alignment: .trailing) {
                Text(stock.formattedPrice)
                    .font(.headline)
                Text("+" + stock.changePercentage)
                    .foregroundColor(.green)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    StockRowView(stock: Stock(symbol: "AAPL", name: "Apple Inc.", price: 150.0, change: 2.5))
        .padding()
} 