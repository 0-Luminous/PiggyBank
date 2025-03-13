import SwiftUI

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
    var isSaved: Bool
}

struct QuotesView: View {
    @State private var todayQuotes = [
        Quote(
            text:
                "When you have money in your hands, only you forget who you are. But when you don't have money in your hands, everyone forgets who you are. That's life.",
            author: "Bill Gates",
            isSaved: false
        )
    ]

    @State private var savedQuotes = [
        Quote(
            text:
                "The key to success in business is to determine where the world is going and get there first",
            author: "Bill Gates",
            isSaved: true
        ),
        Quote(
            text:
                "You will not earn 5,000 euros per month immediately after graduation and will not become a vice president until you have earned both achievements through your efforts",
            author: "Bill Gates",
            isSaved: true
        ),
        Quote(
            text: "Yes, you can learn anything",
            author: "Bill Gates",
            isSaved: true
        ),
    ]

    var body: some View {
        ZStack(alignment: .top) {
            // Заголовок
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.09, green: 0.078, blue: 0.086))
                    .frame(height: 120)
                    .overlay(
                        Text("Quotes")
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
                // Список цитат
                ScrollView {
                    VStack(spacing: 24) {
                        QuoteTitle(title: "Today")
                        ForEach($todayQuotes) { $quote in
                            QuoteCard(quote: $quote)
                        }

                        QuoteTitle(title: "Saved")
                        ForEach($savedQuotes) { $quote in
                            QuoteCard(quote: $quote)
                        }
                    }
                }
            }
            .padding(.top, 132)
            .ignoresSafeArea()
        }
        .background(Color(red: 0.145, green: 0.129, blue: 0.129))
    }
}

struct QuoteTitle: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.nunitoSans(16))
                .foregroundColor(.gray)
                .padding(.leading, 16)
            Spacer()
        }
    }
}
struct QuoteCard: View {
    @Binding var quote: Quote

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {
            Text(quote.text)
                .foregroundColor(.white)
                .font(.system(size: 16))
                .lineSpacing(4)

            HStack {
                Text(quote.author)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))

                Spacer()

                Button(action: {
                    // Действие для кнопки share
                }) {
                    Image("share")
                        .foregroundColor(.white)
                }

                Button(action: {
                    quote.isSaved.toggle()
                }) {
                    Image(systemName: quote.isSaved ? "heart" : "heart")
                        .foregroundColor(quote.isSaved ? .red : .white)
                }
            }
            Divider()
        }
        .padding(.horizontal, 16)
        .background(Color(red: 0.145, green: 0.129, blue: 0.129))
        .cornerRadius(12)
    }
}
