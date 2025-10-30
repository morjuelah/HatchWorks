//
//  ItemsListViewModel.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation
import SwiftData

@Observable
final class ItemsListViewModel {

    private var repository: ItemsRepositoryProtocol
    var lists: [CategoryList] = []
    private var moviesHighlightedItem: VideoItem?
    private var tvHighlightedItem: VideoItem?

    var categorySelected: CategoryType = .movie
    var isLoading: Bool = false
    var tryAgain: Bool = false

    var filteredLists: [CategoryList] {
        return lists.filter { $0.category.type == categorySelected }
    }

    var highlightedItem: VideoItem? {
        switch categorySelected {
        case .movie:
            return moviesHighlightedItem
        case .tv:
            return tvHighlightedItem
        }
    }

    var modelContext: ModelContext? {
        didSet {
            self.repository.modelContext = self.modelContext
        }
    }

    init(repository: ItemsRepositoryProtocol = ItemsRepository()) {
        self.repository = repository
    }

    func getData(with context: ModelContext) {
        self.modelContext = context

        Task { @MainActor in
            isLoading = true
            tryAgain = false

            do {
                lists = try await repository.getLists()

                if lists.isEmpty {
                    tryAgain = true
                } else {
                    getHighlightedItems()
                }
            } catch {
                tryAgain = true
            }

            isLoading = false
        }
    }

    private func getHighlightedItems() {

        if moviesHighlightedItem == nil {
            if let firstList = lists.first(where: { list in
                list.category.type == .movie
            }),
               let firstItem = firstList.videoItems.randomElement() {

                moviesHighlightedItem = firstItem
            }
        }

        if tvHighlightedItem == nil {
            if let firstList = lists.first(where: { list in
                list.category.type == .tv
            }),
               let firstItem = firstList.videoItems.randomElement() {

                tvHighlightedItem = firstItem
            }
        }
    }
}
