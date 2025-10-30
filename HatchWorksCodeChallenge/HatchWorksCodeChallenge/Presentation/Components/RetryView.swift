//
//  RetryView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct RetryView: View {

    var action: (() -> Void)

    var body: some View {
        VStack(spacing: 12) {
            Text("Something happened, please try again")

            Button(action: action) {
                Text("Retry")
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(.white)
            }
            .buttonStyle(.bordered)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.white, lineWidth: 1)
            })
            .shadow(color: .black, radius: 4, x: 0, y: 2)

        }
    }
}

#Preview {
    RetryView {
        //
    }
}
