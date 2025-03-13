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
        Transaction(date: "23.05.2024", amount: 10),
    ]

    var totalAmount: Int {
        transactions.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Заголовок
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.09, green: 0.078, blue: 0.086))
                    .frame(height: 120)
                    .overlay(
                        Text("My piggy bank")
                            .font(.nunitoSans(32))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                            .padding(.top, 50)
                    )
                Spacer()
            }
            .ignoresSafeArea()

            // История пополнений
            VStack(alignment: .leading, spacing: 16) {
                Text("Replenishment history")
                    .foregroundColor(.gray)
                    .font(.nunitoSans(16))
                    .padding(.horizontal)
                VStack(spacing: 0) {
                    ForEach(Array(transactions.enumerated()), id: \.element.id) {
                        index, transaction in
                        TransactionRow(
                            date: transaction.date,
                            amount: transaction.amount,
                            backgroundColor: index % 2 == 0
                                ? Color(red: 0.282, green: 0.267, blue: 0.267)  // #484444
                                : Color(red: 0.145, green: 0.129, blue: 0.129)  // #262222
                        )
                    }

                    // Итоговая строка
                    HStack {
                        Text("Total")
                            .foregroundColor(.white)
                            .font(.nunitoSansBold(14))
                            .padding(.leading, 16)
                        Spacer()
                        Text("\(totalAmount) $")
                            .foregroundColor(.white)
                            .padding(.trailing, 16)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color(red: 0.29, green: 0.439, blue: 0.176))
                }
                .background(Color.black.opacity(0.3))
                .cornerRadius(16)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 0.282, green: 0.267, blue: 0.267), lineWidth: 1)
                        .padding(.horizontal)
                )
            }
            .padding(.top, 90)

            // Настройки копилки
            VStack(alignment: .leading, spacing: 16) {
                Text("Piggy bank settings")
                    .foregroundColor(.gray)
                    .font(.nunitoSans(16))
                    .padding(.horizontal)

                HStack {
                    // Минимальная сумма
                    HStack {
                        Text("Min")
                            .font(.nunitoSans(16))
                            .foregroundColor(.white)
                            .padding(.leading, 16)

                        Text("\(minAmount) $")
                            .foregroundColor(.gray)
                            .padding(.trailing, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 0.282, green: 0.267, blue: 0.267), lineWidth: 1)
                            .padding(.horizontal)
                            .padding(.leading, 17)
                    )

                    // Максимальная сумма
                    HStack {
                        Text("Max")
                            .font(.nunitoSans(16))
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                        Text("\(maxAmount) $")
                            .foregroundColor(.gray)
                            .padding(.trailing, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 0.282, green: 0.267, blue: 0.267), lineWidth: 1)
                            .padding(.trailing, 17)

                    )
                }
                .padding(.horizontal, 17)

                // Кнопка рандомизации
                Button(action: {
                    randomizeAmount()
                }) {
                    Text("Randomize")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal)
            }
            .padding(.top, 350)
            Spacer()
        }
        .background(Color(red: 0.145, green: 0.129, blue: 0.129))
    }

    private func randomizeAmount() {
        guard let min = Int(minAmount),
            let max = Int(maxAmount),
            min < max
        else { return }

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
    let backgroundColor: Color

    var body: some View {
        HStack {
            Text(date)
                .font(.nunitoSans(14))
                .foregroundColor(.white)
                .padding(.leading, 16)
            Spacer()
            Text("+ \(amount) $")
                .foregroundColor(.white)
                .padding(.trailing, 16)
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(backgroundColor)
    }
}
