//
//  ItemDetailView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct ItemDetailView: View {

    @Environment(\.modelContext) var modelContext
    @State var viewModel: ItemDetailViewModel

    init(item: VideoItem, category: CategoryType) {
        let viewModel = ItemDetailViewModel(item: item, categoryType: category)
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ItemDetailHeader(item: viewModel.item)

                VStack(spacing: 16) {
                    ItemActionsBarView()

                    if !viewModel.item.originalHeaderName.isEmpty {
                        originalName
                    }

                    if !viewModel.genresText.isEmpty {
                        genres
                    }

                    overview

                    HStack(spacing: 16) {
                        ItemDataView(title: "Original language", content: viewModel.item.originalLanguage ?? "N/A")
                        ItemDataView(title: "Popularity", content: String(viewModel.item.popularity ?? 2))
                    }

                    HStack(spacing: 16) {
                        ItemDataView(title: "Vote average", content: String(viewModel.item.voteAverage ?? 2))
                        ItemDataView(title: "Vote count", content: String(viewModel.item.voteCount ?? 0))
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 16)
            }
        }
        .toolbarRole(.editor)
        .scrollIndicators(.hidden)
        .edgesIgnoringSafeArea(.top)
        .task {
            viewModel.getData(with: modelContext)
        }
    }

    private var originalName: some View {
        HStack(spacing: 4) {
            Text("Original title:")
                .font(.system(size: 14))
                .bold()

            Text(viewModel.item.originalHeaderName)
                .lineLimit(1)
                .font(.system(size: 12))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var genres: some View {
        Text(viewModel.genresText)
            .font(.system(size: 12))
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var overview: some View {
        Text(viewModel.item.overview ?? "")
            .multilineTextAlignment(.leading)
            .font(.system(size: 16))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
