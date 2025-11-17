//
//  AIChat.swift
//  TradeTeammate
//
//  Created by James Hollander on 11/10/25.
//

import SwiftUI
struct AIChat: View {
    @State private var text: String = ""
    var body: some View {
        NavigationStack {
            Spacer()
            VStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 350, height: 60)
                        .foregroundStyle(Color.gray.opacity(0.3))
                    HStack {
                        TextField("Ask me your stock questions!", text: $text)
                            .foregroundStyle(Color.black)
                            .frame(width: 250)
                            .padding(20)
                        Button {
                            
                        }label: {
                            Image(systemName: "paperplane")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                }

            }
        }
    }
}
#Preview {
    AIChat()
}
