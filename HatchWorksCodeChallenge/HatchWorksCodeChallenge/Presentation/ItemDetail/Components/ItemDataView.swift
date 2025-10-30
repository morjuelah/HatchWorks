//
//  ItemDataView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct ItemDataView: View {

    @State var title: String
    @State var content: String

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 14))
                .bold()
            Text(content)
                .font(.system(size: 14))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.black)
                        .shadow(color: .gray, radius: 2, x: 0, y: 0)
                )
        }
    }
}

#Preview {
    ItemDataView(title: "Title", content: "Content")
}
