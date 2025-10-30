//
//  CategoryItemsView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct CategoryItemsView: View {

    var lists: [CategoryList]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(lists, id: \.self) { list in
                VStack(spacing: 8) {
                    HStack {
                        Text(list.category.describingName)
                            .font(.system(size: 16))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)

                        NavigationLink(destination: ItemsFullListView(categoryList: list)) {
                            Text("Full list >")
                                .font(.system(size: 14))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal, 12)

                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(Array(list.videoItems.prefix(20)), id: \.self) { item in

                                NavigationLink(destination: ItemDetailView(item: item, category: list.category.type)) {
                                    ItemPosterView(item: item)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
