//
//  Wallet.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//

import SwiftUI

struct WalletView: View {
    @State private var balance: String = "15 000"
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            // Фоновое изображение
            Image("BackgroundFrame")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                // Заголовок
                Text("Enter Your\nAccount Balance")
                    .font(.nunitoSansBold(36))
                    .foregroundStyle(.white)

                // Поле ввода
                HStack {
                    Text("Wallet")
                        .foregroundStyle(.white)
                        .font(.nunitoSans(16))

                    TextField("", text: $balance)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.system(size: 16))
                        .focused($isFocused)

                    Text("$")
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.system(size: 16))
                }
                .padding()
                .background(Color.white.opacity(0))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 1)
                )

                // Кнопка
                Button(action: {
                    dismiss()
                }) {
                    Text("Let's start")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(.white)
                        .cornerRadius(16)
                }
                .padding(.top, 155)
            }
            .padding(.horizontal, 16)
        }
        .navigationBarHidden(true)
        .onAppear {
            isFocused = true  // Автоматически показываем клавиатуру при появлении
        }
        .preferredColorScheme(.dark)
    }
}
