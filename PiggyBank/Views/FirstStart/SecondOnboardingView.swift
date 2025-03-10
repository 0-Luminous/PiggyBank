import SwiftUI

struct SecondOnboardingView: View {
    @Binding var isOnboardingCompleted: Bool
    @State private var showContentView = false
    
    var body: some View {
        VStack(spacing: 40) {
            // Заголовок
            VStack(alignment: .leading, spacing: 16) {
                Text("Take Control\nof Your Financial\nJourney")
                    .font(.nunitoSansBold(40))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 25)
            
            Image("LoadingFrame")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            // Список функций
            VStack(alignment: .leading, spacing: 16) {
                FeatureRow(icon: "briefcase", text: "Personalized Portfolio Builder")
                Divider()
                    .overlay(Color.white)
                FeatureRow(icon: "chart", text: "Data-driven Performance Analysis")
                Divider()
                    .overlay(Color.white)
                FeatureRow(icon: "message", text: "Stay Inspired with Trading Quotes")
                Divider()
                    .overlay(Color.white)
                FeatureRow(icon: "bank", text: "Grow Your Savings with Piggy Bank")
                Divider()
                    .overlay(Color.white)
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // Кнопка Continue
            Button(action: {
                withAnimation {
                    isOnboardingCompleted = true
                    showContentView = true
                }
            }) {
                Text("Continue")
                    .font(.nunitoSansSemiBold(16))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(
            Image("BackgroundFrame")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $showContentView) {
            ContentView()
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
            
            Text(text)
                .font(.nunitoSansBold(16))
                .foregroundColor(.white)
        }
    }
} 
