import SwiftUI

struct ProfitView: View {
    @State private var selectedPeriod = 1  // 1Y по умолчанию

    let periods = ["1M", "1Y", "2Y", "3Y", "4Y", "5Y"]
    let investments = [
        Investment(name: "Raiffeisen", percentage: 30),
        Investment(name: "Netflix", percentage: 28),
        Investment(name: "Amazon", percentage: 18),
        Investment(name: "Google", percentage: 11),
        Investment(name: "BMW", percentage: 11),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
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
            }
            .ignoresSafeArea()
            VStack {
                // Заголовок
                HStack {
                    Text("Portfolio")
                        .font(.nunitoSans(16))
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                    Spacer()
                    NavigationLink {
                        WalletView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Image("editPen")
                            .foregroundStyle(.gray)
                    }
                    .padding(.trailing, 16)
                }

                // Периоды
                HStack {
                    ForEach(0..<periods.count, id: \.self) { index in
                        Button(action: {
                            selectedPeriod = index
                        }) {
                            Text(periods[index])
                                .padding(.vertical, 8)
                                .padding(.horizontal, 13.25)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
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
                Divider()
                // Итоговая информация
                VStack(spacing: 12) {
                    ProfitInfoRow(title: "Was spent", value: "100 000 $")
                    ProfitInfoRow(title: "Amount after 5 years", value: "250 000 $")
                    ProfitInfoRow(title: "My profit", value: "150 000 $", isProfit: true)
                }
                Divider()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 146)
            .background(Color(red: 0.145, green: 0.129, blue: 0.129))
        }
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
                .font(.nunitoSans(14))
            Spacer()
            Text("\(investment.percentage)%")
                .foregroundColor(.white)
                .font(.nunitoSansBold(14))
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
                .foregroundColor(.white)
                .font(.nunitoSans(14))
            Spacer()
            Text(value)
                .foregroundColor(isProfit ? .green : .white)
                .font(.nunitoSansBold(14))
        }
    }
}
