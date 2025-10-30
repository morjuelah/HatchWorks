//
//  ItemCellView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct ItemCellView: View {

    var item: VideoItem

    var body: some View {
        HStack(spacing: 12) {
            ItemPosterView(item: item, width: 50, height: 75)

            VStack(spacing: 8) {
                Text(item.headerName)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let year = item.releaseYear {
                    Text(year)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
