import SwiftUI

struct ProfitView: View {
    @State private var selectedPeriod = 1  // 1Y по умолчанию

    let periods = ["1M", "1Y", "2Y", "3Y", "4Y", "5Y"]

    @FetchRequest(
        entity: StockEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StockEntity.name, ascending: true)],
        predicate: NSPredicate(format: "quantity > 0"),
        animation: .default
    ) private var purchasedStocks: FetchedResults<StockEntity>

    // Вычисляем общую стоимость портфеля
    private var totalPortfolioValue: Double {
        purchasedStocks.reduce(0) { sum, stock in
            sum + (stock.price * Double(stock.quantity))
        }
    }

    // Преобразуем акции в инвестиции с процентами
    private var investments: [Investment] {
        purchasedStocks.map { stock in
            let stockValue = stock.price * Double(stock.quantity)
            let percentage = Int(round((stockValue / totalPortfolioValue) * 100))
            return Investment(name: stock.name ?? "", percentage: percentage)
        }
    }

    // Вычисляем потраченную сумму (цена покупки * количество)
    private var totalSpent: Double {
        purchasedStocks.reduce(0) { sum, stock in
            sum + (stock.price * Double(stock.quantity))
        }
    }

    // Предполагаемая стоимость через 5 лет (используем среднее увеличение на 15% в год)
    private var amountAfter5Years: Double {
        totalSpent * pow(1.15, 5)
    }

    // Прибыль (разница между будущей и текущей стоимостью)
    private var profit: Double {
        amountAfter5Years - totalSpent
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Заголовок
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.09, green: 0.078, blue: 0.086))
                    .frame(height: 120)
                    .overlay(
                        Text("Profitability")
                            .font(.nunitoSans(32))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                            .padding(.top, 50)
                    )
                Spacer()
            }
            .ignoresSafeArea()
            VStack {
                // Заголовок
                HStack {
                    Text("Portfolio")
                        .font(.nunitoSans(16))
                        .foregroundColor(.gray)
                    Spacer()
                    NavigationLink {
                        WalletView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Image("editPen")
                            .foregroundStyle(.gray)
                    }
                }

                // Периоды
                HStack(spacing: 8) {
                    ForEach(0..<periods.count, id: \.self) { index in
                        PeriodButton(
                            text: periods[index],
                            isSelected: selectedPeriod == index,
                            action: {
                                withAnimation {
                                    selectedPeriod = index
                                }
                            }
                        )
                    }
                }

                // Список инвестиций
                VStack {
                    if !purchasedStocks.isEmpty {
                        ForEach(investments) { investment in
                            InvestmentRowView(investment: investment)
                        }
                    } else {
                        Text("No shares in portfolio")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }

                Divider()
                // Итоговая информация
                VStack(spacing: 12) {
                    ProfitInfoRow(
                        title: "Was spent",
                        value: String(format: "%.0f $", totalSpent)
                    )
                    ProfitInfoRow(
                        title: "Amount after 5 years",
                        value: String(format: "%.0f $", amountAfter5Years)
                    )
                    ProfitInfoRow(
                        title: "My profit",
                        value: String(format: "%.0f $", profit),
                        isProfit: true
                    )
                }
                Divider()
            }
            .padding(.horizontal, 16)
            .padding(.top, 132)
            .ignoresSafeArea()
        }
        .background(Color(red: 0.145, green: 0.129, blue: 0.129))
    }
}

struct Investment: Identifiable {
    let id = UUID()
    let name: String
    let percentage: Int
}

struct InvestmentRowView: View {
    let investment: Investment
    @State private var width: CGFloat = 0

    var body: some View {
        HStack {
            Text(investment.name)
                .foregroundColor(.white)
                .font(.nunitoSans(14))
            Spacer()
            Text("\(investment.percentage)%")
                .foregroundColor(.white)
                .font(.nunitoSansBold(14))
        }
        Capsule()
            .frame(height: 8)
            .frame(width: UIScreen.main.bounds.width - 32)
            .foregroundColor(Color(red: 0.208, green: 0.2, blue: 0.2))
            .overlay(
                Capsule()
                    .frame(width: width)
                    .frame(height: 8)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.2, green: 0.7, blue: 0.2),
                                Color(red: 0.15, green: 0.5, blue: 0.15),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    ),
                alignment: .leading
            )
            .padding(.bottom, 8)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    width = (UIScreen.main.bounds.width - 32) * CGFloat(investment.percentage) / 100
                }
            }
    }
}

struct ProfitInfoRow: View {
    let title: String
    let value: String
    var isProfit: Bool = false

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.nunitoSans(14))
            Spacer()
            Text(value)
                .foregroundColor(isProfit ? .green : .white)
                .font(.nunitoSansBold(14))
        }
    }
}

struct PeriodButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .padding(.vertical, 8)
                .padding(.horizontal, 13.25)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            isSelected ? Color.white : Color(red: 0.208, green: 0.2, blue: 0.2),
                            lineWidth: isSelected ? 2 : 1)
                )
        }
        .foregroundColor(.white)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
