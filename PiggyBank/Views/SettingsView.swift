import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Settings")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top)
            
            VStack(spacing: 0) {
                // Terms and conditions
                NavigationLink {
                    Text("Terms and conditions")
                        .navigationTitle("Terms and conditions")
                } label: {
                    SettingsRow(title: "Terms and conditions")
                }
                
                Divider()
                    .background(Color.gray.opacity(0.3))
                
                // Policy privacy
                NavigationLink {
                    Text("Policy privacy")
                        .navigationTitle("Policy privacy")
                } label: {
                    SettingsRow(title: "Policy privacy")
                }
                
                Divider()
                    .background(Color.gray.opacity(0.3))
                
                // Feedback
                NavigationLink {
                    Text("Feedback")
                        .navigationTitle("Feedback")
                } label: {
                    SettingsRow(title: "Feedback")
                }
                
                Divider()
                    .background(Color.gray.opacity(0.3))
                
                // Rate app
                NavigationLink {
                    Text("Rate app")
                        .navigationTitle("Rate app")
                } label: {
                    SettingsRow(title: "Rate app")
                }
            }
            .background(Color.black.opacity(0.3))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color.black)
    }
}

struct SettingsRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
    }
} 