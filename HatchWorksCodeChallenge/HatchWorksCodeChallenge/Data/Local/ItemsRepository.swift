//
//  ItemsRepository.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation
import SwiftData

protocol ItemsRepositoryProtocol {
    var modelContext: ModelContext? { get set }

    func getLists() async throws -> [CategoryList]
    func getMoreItems(for list: CategoryList) async throws -> [VideoItem]
    func getItemGenres() async throws -> [Genre]
    func searchText(for category: CategoryType, searchText: String, page: Int) async throws -> BaseVideoList
}

class ItemsRepository: ItemsRepositoryProtocol {

    private let service: ServiceProtocol
    var modelContext: ModelContext?

    private let listFetchDescriptor = FetchDescriptor<CategoryList>()
    private let genresFetchDescriptor = FetchDescriptor<Genre>()

    init(service: ServiceProtocol = Service()) {
        self.service = service
    }

    func getLists() async throws -> [CategoryList] {

        let lists = try modelContext?.fetch(listFetchDescriptor)

        if let lists, !lists.isEmpty {
            return lists
        } else {
            try await initCategoryLists()

            guard let lists = try modelContext?.fetch(listFetchDescriptor) else {
                throw ServiceError.default
            }

            return lists
        }
    }

    private func initCategoryLists() async throws {
        for category in ItemCategory.allCases {

            let baseList = try await service.getVideoList(for: category, page: 1)

            let movieList = CategoryList(category: category,
                                         page: baseList.page,
                                         totalPages: baseList.totalPages,
                                         totalResults: baseList.totalResults,
                                         videoItems: baseList.videoItems)

            modelContext?.insert(movieList)
        }
    }

    func getMoreItems(for list: CategoryList) async throws -> [VideoItem] {

        let baseList = try await service.getVideoList(for: list.category, page: list.page + 1)

        list.page = baseList.page
        list.videoItems.append(contentsOf: baseList.videoItems)

        return baseList.videoItems
    }

    func getItemGenres() async throws -> [Genre] {

        let genres = try modelContext?.fetch(genresFetchDescriptor)

        if let genres, !genres.isEmpty {
            return genres
        } else {
            try await initGenres()

            guard let genres = try modelContext?.fetch(genresFetchDescriptor) else {
                throw ServiceError.default
            }

            return genres
        }
    }

    private func initGenres() async throws {
        for category in CategoryType.allCases {
            let genreList = try await service.getGenres(for: category)

            for genre in genreList.genres {
                let itemGenre = Genre(category: category,
                                      id: genre.id,
                                      name: genre.name)

                modelContext?.insert(itemGenre)
            }
        }
    }

    func searchText(for category: CategoryType, searchText: String, page: Int) async throws -> BaseVideoList {
        return try await service.searchItems(for: category, searchText: searchText, page: page)
    }
}
