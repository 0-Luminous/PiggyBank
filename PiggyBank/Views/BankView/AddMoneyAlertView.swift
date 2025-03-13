//
//  WhichOfAmount.swift
//  PiggyBank
//
//  Created by Yan on 13/3/25.
//

import SwiftUI

struct AddMoneyAlertView: View {
    let amount: String
    let onCancel: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("\(amount) $")
                    .font(.system(size: 32))
                    .foregroundColor(.green)

                Text("Put in a piggy bank?")
                    .font(.system(size: 17))
                    .foregroundColor(.white)

                HStack(spacing: 16) {
                    Button(action: onCancel) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.208, green: 0.2, blue: 0.2))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                    }

                    Button(action: onConfirm) {
                        Text("Yes")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(.white)
                            .cornerRadius(12)
                            .foregroundColor(.black)
                    }
                }
            }
            .background(Color(red: 0.145, green: 0.129, blue: 0.129).opacity(0.46))
            .padding(24)
            .cornerRadius(24)
            .padding(.horizontal, 16)
        }
        .background(
            Image("BackgroundFrame")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
    }
}
