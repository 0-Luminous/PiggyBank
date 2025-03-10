import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Home")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                    
                    // Wallet Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Wallet")
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "pencil")
                                .foregroundColor(.gray)
                        }
                        Text("15 000 $")
                            .font(.system(size: 34, weight: .bold))
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)
                    
                    // Add shares section
                    VStack(spacing: 16) {
                        Text("Add shares")
                            .foregroundColor(.gray)
                        
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
                    .padding(.top, 40)
                    
                    Spacer()
                }
                .background(Color(red: 0.145, green: 0.129, blue: 0.129))
            }
            .tabItem {
                Image("Home")
                Text("Home")
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color(red: 0.067, green: 0.067, blue: 0.067), for: .tabBar)
            
            Text("Profit View")
                .tabItem {
                    Image("arrow-growth")
                    Text("Profit")
                }
            
            Text("Quotes View")
                .tabItem {
                    Image("Message1")
                    Text("Quotes")
                }
            
            Text("Bank View")
                .tabItem {
                    Image("piggyBank")
                    Text("Bank")
                }
            
            Text("Settings View")
                .tabItem {
                    Image("equalizer")
                    Text("Settings")
                }
        }
        .tint(.white)
        .preferredColorScheme(.dark)
    }
} 
