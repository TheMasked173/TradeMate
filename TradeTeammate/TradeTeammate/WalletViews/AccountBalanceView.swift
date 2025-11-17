//
//  AccountBalanceView.swift
//  TradeTeammate
//
//  Created by James Hollander on 11/14/25.
//

import SwiftUI

struct AccountBalanceView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Your Balance: $99999999")
                    .font(.title.bold())
                NavigationLink(destination: TransferView()) {
                    ZStack {
                        Capsule()
                            .frame(width: 150, height: 50)
                        Text("Transfer")
                            .font(.title3.bold())
                            .foregroundStyle(Color(.black))
                    }
                }
                VStack {
                    Image("Balance")
                        .resizable()
                        .frame(width: 350, height: 300)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 4)
                }
            }
        }
    }
}

#Preview {
    AccountBalanceView()
}
