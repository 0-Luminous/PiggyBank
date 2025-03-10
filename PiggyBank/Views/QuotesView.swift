import SwiftUI

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
    var isSaved: Bool
}

struct QuotesView: View {
    @State private var quotes = [
        Quote(
            text: "When you have money in your hands, only you forget who you are. But when you don't have money in your hands, everyone forgets who you are. That's life.",
            author: "Bill Gates",
            isSaved: false
        ),
        Quote(
            text: "The key to success in business is to determine where the world is going and get there first",
            author: "Bill Gates",
            isSaved: true
        ),
        Quote(
            text: "You will not earn 5,000 euros per month immediately after graduation and will not become a vice president until you have earned both achievements through your efforts",
            author: "Bill Gates",
            isSaved: true
        ),
        Quote(
            text: "Yes, you can learn anything",
            author: "Bill Gates",
            isSaved: true
        )
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Заголовок Today
            Text("Today")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            // Список цитат
            ScrollView {
                VStack(spacing: 24) {
                    ForEach($quotes) { $quote in
                        QuoteCard(quote: $quote)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black)
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
                    Image(systemName: "arrow.up.forward")
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    quote.isSaved.toggle()
                }) {
                    Image(systemName: quote.isSaved ? "heart.fill" : "heart")
                        .foregroundColor(quote.isSaved ? .red : .gray)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(12)
    }
} 