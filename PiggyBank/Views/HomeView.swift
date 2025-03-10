//
//  HomeView.swift
//  PiggyBank
//
//  Created by Yan on 10/3/25.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderView() // Верхний фрейм
                Spacer()
                AddSharesButton() // Кнопка добавления
                Spacer()
                CustomTabBar() // Нижний док-бар
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Home")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.gray)
            }
            Text("Wallet")
                .foregroundColor(.gray)
                .font(.caption)
            Text("15 000 $")
                .font(.title.bold())
                .foregroundColor(.white)
            Divider()
                .background(Color.gray)
        }
        .padding()
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }
}

struct AddSharesButton: View {
    var body: some View {
        VStack {
            Text("Add shares")
                .foregroundColor(.gray)
                .font(.caption)
            Button(action: {
                print("Add shares tapped")
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle().fill(Color.white.opacity(0.2)))
            }
        }
    }
}

struct CustomTabBar: View {
    var body: some View {
        HStack {
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
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }
}

struct TabBarItem: View {
    var icon: String
    var title: String
    var isSelected: Bool = false

    var body: some View {
        VStack(spacing: 5) {
            Image(icon)
                .font(.title2)
                .foregroundColor(isSelected ? .white : .gray)
            Text(title)
                .font(.caption)
                .foregroundColor(isSelected ? .white : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
