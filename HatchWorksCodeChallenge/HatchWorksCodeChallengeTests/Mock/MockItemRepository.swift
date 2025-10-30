//
//  MockItemRepository.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 29/10/25.
//

import Foundation
import SwiftData
@testable import HatchWorksCodeChallenge

class MockItemRepository: ItemsRepositoryProtocol {
    var modelContext: ModelContext?

    func getLists() async throws -> [CategoryList] {

        let lists = [CategoryList(category: .nowPlayingMovie,
                                  page: 1,
                                  totalPages: 10,
                                  totalResults: 20,
                                  videoItems: []),
                     CategoryList(category: .airingTodayTV,
                                  page: 1,
                                  totalPages: 10,
                                  totalResults: 20,
                                  videoItems: [])]

        return lists
    }

    func getMoreItems(for list: CategoryList) async throws -> [VideoItem] {
        return [VideoItem(id: 1), VideoItem(id: 2)]
    }

    func getItemGenres() async throws -> [Genre] {

        let genres = [Genre(category: .movie, id: 1, name: "Genre 1"),
                      Genre(category: .tv, id: 2, name: "Genre 2"),
                      Genre(category: .tv, id: 3, name: "Genre 3")]

        return genres
    }

    func searchText(for category: CategoryType, searchText: String, page: Int) async throws -> BaseVideoList {
        return BaseVideoList(page: 1,
                             totalPages: 1,
                             totalResults: 0,
                             videoItems: [VideoItem(id: 1), VideoItem(id: 2)])
    }
}
