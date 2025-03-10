import SwiftUI

struct LoadingView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Заголовок
            VStack(spacing: 8) {
                Text("Wellcome")
                    .font(.nunitoSansBold(40))
                Text("to financial app")
                    .font(.nunitoSansBold(40))
            }
            .foregroundColor(.white)
            
            Spacer()
            
            // График
            Image("Loading")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.horizontal, 20)
                .padding(.bottom, 166)
            
            // Текст загрузки
            Text("Loading...")
                .font(.nunitoSans(16))
                .foregroundColor(.white)
                .padding(.bottom, 40)
        }
        .background(
            Image("BackgroundFrame")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
        .onAppear {
            // Переход к онбордингу через 2 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            OnboardingView(isOnboardingCompleted: .constant(false))
        }
    }
} 
