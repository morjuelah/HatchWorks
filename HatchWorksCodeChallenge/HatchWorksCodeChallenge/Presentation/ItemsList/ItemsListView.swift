//
//  ItemsListView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct ItemsListView: View {

    @Environment(\.modelContext) var modelContext
    @State var viewModel = ItemsListViewModel()

    var body: some View {

        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    LoaderView()
                } else {
                    if viewModel.tryAgain {
                        RetryView{
                            viewModel.getData(with: modelContext)
                        }
                    } else {
                        ScrollView {
                            ZStack(alignment: .top) {
                                VStack(spacing: 12) {
                                    NavigationLink {
                                        if let item = viewModel.highlightedItem {
                                            ItemDetailView(item: item, category: viewModel.categorySelected)
                                        }
                                    } label: {
                                        HighlitedItem(item: viewModel.highlightedItem)
                                    }

                                    CategoryItemsView(lists: viewModel.filteredLists)
                                }

                                CategorySelectionView(categorySelected: viewModel.categorySelected) { type in
                                    viewModel.categorySelected = type
                                }
                                .padding(.top, 54)
                            }
                        }
                        .scrollIndicators(.hidden)
                        .edgesIgnoringSafeArea(.top)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            viewModel.getData(with: modelContext)
        }
    }
}
