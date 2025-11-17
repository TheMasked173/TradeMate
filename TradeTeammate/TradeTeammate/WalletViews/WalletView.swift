//
//  WalletView.swift
//  TradeTeammate
//
//  Created by James Hollander on 11/10/25.
//

import SwiftUI

struct WalletView: View {
    @State var selection: Int = 0
    let viewOptions = ["Wallet", "History"]
    var body: some View {
        NavigationStack() {
            VStack{
                Picker("", selection: $selection) {
                    ForEach(0..<viewOptions.count, id: \.self) { index in
                        Text(viewOptions[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                    if selection == 0 {
                        AccountBalanceView()
                    } else {
                        HistoryView()
                    }
            }
            Spacer()
            VStack {
            }
        }

    }
}

#Preview {
    WalletView()
}
