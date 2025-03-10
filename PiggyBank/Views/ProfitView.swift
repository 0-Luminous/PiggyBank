import SwiftUI

struct ProfitView: View {
    @State private var selectedPeriod = 1 // 1Y по умолчанию
    
    let periods = ["1M", "1Y", "2Y", "3Y", "4Y", "5Y"]
    let investments = [
        Investment(name: "Raiffeisen", percentage: 30),
        Investment(name: "Netflix", percentage: 28),
        Investment(name: "Amazon", percentage: 18),
        Investment(name: "Google", percentage: 11),
        Investment(name: "BMW", percentage: 11)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Заголовок
            HStack {
                Text("Portfolio")
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.gray)
            }
            
            // Периоды
            HStack {
                ForEach(0..<periods.count, id: \.self) { index in
                    Button(action: {
                        selectedPeriod = index
                    }) {
                        Text(periods[index])
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedPeriod == index ? Color.white.opacity(0.1) : Color.clear)
                            .cornerRadius(8)
                    }
                    .foregroundColor(.white)
                }
            }
            
            // Список инвестиций
            VStack(spacing: 16) {
                ForEach(investments) { investment in
                    InvestmentRowView(investment: investment)
                }
            }
            
            Spacer()
            
            // Итоговая информация
            VStack(spacing: 12) {
                ProfitInfoRow(title: "Was spent", value: "$100 000")
                ProfitInfoRow(title: "Amount after 5 years", value: "$250 000")
                ProfitInfoRow(title: "My profit", value: "$150 000", isProfit: true)
            }
        }
        .padding()
        .background(Color.black)
    }
}

struct Investment: Identifiable {
    let id = UUID()
    let name: String
    let percentage: Int
}

struct InvestmentRowView: View {
    let investment: Investment
    
    var body: some View {
        HStack {
            Text(investment.name)
                .foregroundColor(.white)
            Spacer()
            Text("\(investment.percentage)%")
                .foregroundColor(.white)
        }
        .padding(.bottom, 8)
        Rectangle()
            .frame(height: 4)
            .foregroundColor(.green)
            .frame(width: CGFloat(investment.percentage) * 3)
    }
}

struct ProfitInfoRow: View {
    let title: String
    let value: String
    var isProfit: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .foregroundColor(isProfit ? .green : .white)
        }
    }
} 