//
//  SearchView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct SearchView: View {

    @StateObject var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    LoaderView()
                } else {
                    if viewModel.tryAgain {
                        RetryView{
                            viewModel.search()
                        }
                    } else {
                        CategorySelectionView(categorySelected: viewModel.categorySelected) { type in
                            viewModel.categorySelected = type
                        }
                        
                        if !viewModel.searchText.isEmpty && viewModel.videoItems.isEmpty {
                            Text("No results found")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    ForEach(viewModel.videoItems, id: \.self) { item in
                                        NavigationLink(destination: ItemDetailView(item: item, category: viewModel.categorySelected)) {
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
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $viewModel.searchText)
    }
}

#Preview {
    SearchView()
}
