import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Home")
                        .font(.nunitoSans(32))
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    // Wallet Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Wallet")
                                .font(.nunitoSans(16))
                                .foregroundColor(.gray)
                            Spacer()
                            Image("editPen")
                                .foregroundColor(.gray)
                        }
                        Text("15 000 $")
                            .font(.nunitoSansBold(32))
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)
                    
                    // Add shares section
                    VStack(spacing: 16) {
                        Text("Add shares")
                            .font(.nunitoSans(16))
                            .foregroundColor(.white)
                        
                        Button(action: {
                            // Действие для добавления акций
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 133)
                    
                    Spacer()
                }
                .background(Color(red: 0.145, green: 0.129, blue: 0.129))
            }
            .tabItem {
                Image("Home")
                Text("Home")
            }
            
            ProfitView()
                .tabItem {
                    Image("arrow-growth")
                    Text("Profit")
                }
            QuotesView()
                .tabItem {
                    Image("Message1")
                    Text("Quotes")
                }
            BankView()
                .tabItem {
                    Image("piggyBank")
                    Text("Bank")
                }
            SettingsView()
                .tabItem {
                    Image("equalizer")
                    Text("Settings")
                }
        }
        .tint(.white)
        .preferredColorScheme(.dark)
    } 
}
