//
//  ItemPosterView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemPosterView: View {

    var item: VideoItem
    var width: CGFloat = 100
    var height: CGFloat = 150

    var body: some View {
        ZStack {
            WebImage(url: item.posterImageUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
        }
        .frame(width: width, height: height)
        .clipped()
    }
}
