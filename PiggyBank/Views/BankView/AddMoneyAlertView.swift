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
                    .font(.nunitoSansBold(36))
                    .foregroundColor(Color(red: 0.553, green: 0.875, blue: 0.235))  // #8ddf3c

                Text("Put in a piggy bank?")
                    .font(.nunitoSans(20))
                    .foregroundColor(.white)

                HStack(spacing: 8) {
                    Button(action: onCancel) {
                        Text("Cancel")
                            .frame(maxWidth: 151)
                            .padding(.vertical, 16)
                            .background(Color(red: 1, green: 1, blue: 1).opacity(0.16))  // #5f5f5f
                            .cornerRadius(16)
                            .foregroundColor(.white)
                    }

                    Button(action: onConfirm) {
                        Text("Yes")
                            .frame(maxWidth: 151)
                            .padding(.vertical, 16)
                            .background(.white)
                            .cornerRadius(16)
                            .foregroundColor(.black)
                    }
                }
                .padding(.top, 8)
            }
            .padding(16)
            .background(Color(red: 0.145, green: 0.129, blue: 0.129).opacity(0.46))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("BackgroundFrame")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
    }
}
