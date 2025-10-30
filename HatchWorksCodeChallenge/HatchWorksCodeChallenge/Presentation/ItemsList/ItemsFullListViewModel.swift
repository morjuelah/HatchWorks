//
//  ItemsFullListViewModel.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation
import SwiftData

@Observable
final class ItemsFullListViewModel {

    private var repository: ItemsRepositoryProtocol

    var list: CategoryList
    var videoItems: [VideoItem]
    var loadingMoreItems: Bool = false

    var modelContext: ModelContext? {
        didSet {
            self.repository.modelContext = self.modelContext
        }
    }

    var enableLoadMoreItems: Bool {
        return !list.videoItems.isEmpty && (list.page < list.totalPages)
    }

    init(repository: ItemsRepositoryProtocol = ItemsRepository(), list: CategoryList) {
        self.repository = repository
        self.list = list
        self.videoItems = list.videoItems
    }

    func loadMoreItems() {
        Task { @MainActor in
            loadingMoreItems = true

            do {
                let newItems = try await repository.getMoreItems(for: list)

                videoItems.append(contentsOf: newItems)
            } catch {
                //
            }

            loadingMoreItems = false
        }
    }
}
