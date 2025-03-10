import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let date: String
    let amount: Int
}

struct BankView: View {
    @State private var minAmount: String = "10"
    @State private var maxAmount: String = "45"
    @State private var transactions = [
        Transaction(date: "22.05.2024", amount: 10),
        Transaction(date: "23.05.2024", amount: 15),
        Transaction(date: "24.05.2024", amount: 25),
        Transaction(date: "23.05.2024", amount: 10)
    ]
    
    var totalAmount: Int {
        transactions.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("My piggy bank")
                .font(.title)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            // История пополнений
            VStack(alignment: .leading, spacing: 16) {
                Text("Replenishment history")
                    .foregroundColor(.gray)
                
                VStack(spacing: 0) {
                    ForEach(transactions) { transaction in
                        TransactionRow(date: transaction.date, amount: transaction.amount)
                    }
                    
                    // Итоговая строка
                    HStack {
                        Text("Total")
                            .foregroundColor(.white)
                        Spacer()
                        Text("+ \(totalAmount) $")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            // Настройки копилки
            VStack(alignment: .leading, spacing: 16) {
                Text("Piggy bank settings")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    // Минимальная сумма
                    VStack {
                        Text("Min")
                            .foregroundColor(.gray)
                        Text("\(minAmount) $")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                    
                    // Максимальная сумма
                    VStack {
                        Text("Max")
                            .foregroundColor(.gray)
                        Text("\(maxAmount) $")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Кнопка рандомизации
                Button(action: {
                    randomizeAmount()
                }) {
                    Text("Randomize")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .background(Color(red: 0.145, green: 0.129, blue: 0.129))
    }
    
    private func randomizeAmount() {
        guard let min = Int(minAmount),
              let max = Int(maxAmount),
              min < max else { return }
        
        let randomAmount = Int.random(in: min...max)
        let currentDate = formatDate(Date())
        
        transactions.append(Transaction(date: currentDate, amount: randomAmount))
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

struct TransactionRow: View {
    let date: String
    let amount: Int
    
    var body: some View {
        HStack {
            Text(date)
                .foregroundColor(.white)
            Spacer()
            Text("+ \(amount) $")
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(8)
    }
} 
