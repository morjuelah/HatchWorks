//
//  HighlitedItem.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct HighlitedItem: View {

    var item: VideoItem?

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 8) {
                Text(item?.headerName ?? "yyyy")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                    .shadow(color: .black, radius: 4, x: 0, y: 2)

                Text(item?.overview ?? "")
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .shadow(color: .black, radius: 4, x: 0, y: 2)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
        .frame(height: 500, alignment: .center)
        .frame(maxWidth: .infinity)
        .background {
            WebImage(url: item?.backdropImageUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
