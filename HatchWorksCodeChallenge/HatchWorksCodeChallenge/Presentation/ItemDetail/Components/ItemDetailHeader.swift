//
//  ItemDetailHeader.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemDetailHeader: View {
    var item: VideoItem

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 8) {
                Text(item.headerName)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                    .shadow(color: .black, radius: 4, x: 0, y: 2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let year = item.releaseYear {
                    Text(year)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(color: .black, radius: 4, x: 0, y: 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Button {
                    //Implement action
                } label: {
                    Label("Play now", systemImage: "play.fill")
                        .padding()
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                }
                .background (Color.white)
                .frame(height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .frame(height: 500, alignment: .center)
        .frame(maxWidth: .infinity)
        .background {
            WebImage(url: item.backdropImageUrl) { image in
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
