//
//  SearchViewModel.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation

@Observable
final class SearchViewModel: ObservableObject {

    private var repository: ItemsRepositoryProtocol

    var list: BaseVideoList?

    var videoItems: [VideoItem] = []
    var isLoading: Bool = false
    var tryAgain: Bool = false
    var loadingMoreItems: Bool = false

    var categorySelected: CategoryType = .movie {
        didSet {
            search()
        }
    }

    var searchText: String = "" {
        didSet {
            search()
        }
    }

    var enableLoadMoreItems: Bool {
        return !videoItems.isEmpty && (list?.page ?? 0 < list?.totalPages ?? 0)
    }

    init(repository: ItemsRepositoryProtocol = ItemsRepository()) {
        self.repository = repository
    }

    func search() {
        guard !searchText.isEmpty else {
            videoItems = []
            return
        }

        Task { @MainActor in
            isLoading = true
            tryAgain = false

            do {
                list = try await repository.searchText(for: categorySelected,
                                                       searchText: searchText,
                                                       page: 1)

                if let list {
                    videoItems = list.videoItems
                }
            } catch {
                tryAgain = true
            }

            isLoading = false
        }
    }

    func loadMoreItems() {
        Task { @MainActor in
            loadingMoreItems = true

            do {
                list = try await repository.searchText(for: categorySelected,
                                                       searchText: searchText,
                                                       page: (list?.page ?? 1) + 1)

                if let list {
                    videoItems.append(contentsOf: list.videoItems)
                }
            } catch {
                //
            }

            loadingMoreItems = false
        }
    }
}
