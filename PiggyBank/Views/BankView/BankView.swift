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
    @FocusState private var isInputActive: Bool

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
                    ScrollView(showsIndicators: false) {
                        ScrollViewReader { scrollProxy in
                            LazyVStack(spacing: 0) {
                                ForEach(Array(transactions.enumerated()), id: \.element.id) {
                                    index, transaction in
                                    TransactionRow(
                                        date: transaction.date,
                                        amount: transaction.amount,
                                        backgroundColor: index % 2 == 0
                                            ? Color(red: 0.282, green: 0.267, blue: 0.267)  // #484444
                                            : Color(red: 0.145, green: 0.129, blue: 0.129)  // #262222
                                    )
                                    .id(transaction.id)
                                }
                            }
                            .onChange(of: transactions.count) { _ in
                                if let lastID = transactions.last?.id {
                                    withAnimation {
                                        scrollProxy.scrollTo(lastID, anchor: .bottom)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 154)  // Изменено на maxHeight

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

                HStack(spacing: 16) {
                    // Минимальная сумма
                    HStack {
                        Text("Min")
                            .font(.nunitoSans(16))
                            .foregroundColor(.white)

                        Spacer()

                        TextField("", text: $minAmount)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.gray)
                            .font(.system(size: 16))
                            .focused($isInputActive)

                        Text("$")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.145, green: 0.129, blue: 0.129))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 0.282, green: 0.267, blue: 0.267), lineWidth: 1)
                    )
                    .frame(maxWidth: .infinity)

                    // Максимальная сумма
                    HStack {
                        Text("Max")
                            .font(.nunitoSans(16))
                            .foregroundColor(.white)

                        Spacer()

                        TextField("", text: $maxAmount)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.gray)
                            .font(.system(size: 16))
                            .focused($isInputActive)

                        Text("$")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.145, green: 0.129, blue: 0.129))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 0.282, green: 0.267, blue: 0.267), lineWidth: 1)
                    )
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)

                // Кнопка рандомизации/готово
                Button(action: {
                    if isInputActive {
                        isInputActive = false
                    } else {
                        randomizeAmount()
                    }
                }) {
                    Text(isInputActive ? "Done" : "Randomize")
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
