//
//  HistoryView.swift
//  TradeTeammate
//
//  Created by James Hollander on 11/14/25.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Tesla        ")
                    .font(Font.largeTitle.bold())
                Image(systemName: "arrowshape.up.fill")
                    .resizable()
                    .frame(width: 25, height: 30)
                    .foregroundStyle(Color.accentColor)
                Text("$33333")
                    .font(Font.largeTitle.bold())
                    
            }
            HStack {
                Text("Apple      ")
                    .font(Font.largeTitle.bold())
                Image(systemName: "arrowshape.up.fill")
                    .resizable()
                    .frame(width: 25, height: 30)
                    .foregroundStyle(Color.accentColor)
                Text("$33333")
                    .font(Font.largeTitle.bold())
                    
            }
            HStack {
                Text("Google   ")
                    .font(Font.largeTitle.bold())
                Image(systemName: "arrowshape.up.fill")
                    .resizable()
                    .frame(width: 25, height: 30)
                    .foregroundStyle(Color.accentColor)
                Text("$33333")
                    .font(Font.largeTitle.bold())
                    
            }
        }
    }
}

#Preview {
    HistoryView()
}
