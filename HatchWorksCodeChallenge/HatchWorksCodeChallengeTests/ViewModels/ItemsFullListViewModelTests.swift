//
//  ItemsFullListViewModelTests.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 29/10/25.
//

import XCTest
import SwiftData
@testable import HatchWorksCodeChallenge

final class ItemsFullListViewModelTests: XCTestCase {

    @MainActor
    func test_loadMoreItems() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CategoryList.self, configurations: config)

        let list = CategoryList(category: .nowPlayingMovie)
        let sut = ItemsFullListViewModel(repository: MockItemRepository(), list: list)
        sut.modelContext = container.mainContext

        let expectation = expectation(description: "Load more items")

        sut.loadMoreItems()

        withObservationTracking {
            _ = sut.videoItems
        } onChange: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(sut.videoItems.count, 2)
    }

    func test_enableLoadMoreItems() throws {
        let list = CategoryList(category: .nowPlayingMovie,
                                page: 1,
                                totalPages: 10,
                                totalResults: 20,
                                videoItems: [])
        let sut = ItemsFullListViewModel(repository: MockItemRepository(), list: list)

        XCTAssertFalse(sut.enableLoadMoreItems)
    }
}
