//
//  ItemsFullListView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct ItemsFullListView: View {

    @Environment(\.modelContext) var modelContext
    @State var viewModel: ItemsFullListViewModel

    init(categoryList: CategoryList) {
        let viewModel = ItemsFullListViewModel(list: categoryList)
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.videoItems, id: \.self) { item in
                        NavigationLink(destination: ItemDetailView(item: item, category: viewModel.list.category.type)) {
                            ItemCellView(item: item)
                        }
                    }

                    if viewModel.enableLoadMoreItems {
                        Button {
                            viewModel.loadMoreItems()
                        } label: {
                            Label("Tap to load more...", systemImage: "arrow.down")
                                .font(.system(size: 14))
                                .bold()
                                .frame(maxWidth: .infinity)
                        }
                        .disabled(viewModel.loadingMoreItems)
                    }
                }
                .padding(.all, 12)
            }
            .scrollIndicators(.hidden)
            .navigationTitle(viewModel.list.category.describingName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
