import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.09, green: 0.078, blue: 0.086))
                    .frame(height: 120)
                    .overlay(
                        Text("Settings")
                            .font(.nunitoSans(32))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                            .padding(.top, 50)
                    )
            }
            .ignoresSafeArea()

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
                Divider()
                    .background(Color.gray.opacity(0.3))
            }
            .padding(.horizontal)
            Spacer()
        }
        .background(Color(red: 0.145, green: 0.129, blue: 0.129))
    }
}

struct SettingsRow: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.nunitoSans(16))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }
        .padding(.top, 12)
        .padding(.bottom, 12)
    }
}
