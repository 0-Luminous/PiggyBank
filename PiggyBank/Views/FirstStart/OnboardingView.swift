import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingCompleted: Bool
    @State private var showSecondOnboarding = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                
                // Заголовок
                VStack(alignment: .leading, spacing: 16) {
                    Text("Start Building\nYour Financial\nFuture Today")
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
                
                // Описание
                Text("Our app is designed to empower you with the tools you need to succeed in the trading\nworld. Begin your journey by exploring the\nkey features we offer.")
                    .font(.nunitoSansBold(16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                // Кнопка Continue
                Button(action: {
                    showSecondOnboarding = true
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
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showSecondOnboarding) {
                SecondOnboardingView(isOnboardingCompleted: $isOnboardingCompleted)
            }
        }
    }
} 
