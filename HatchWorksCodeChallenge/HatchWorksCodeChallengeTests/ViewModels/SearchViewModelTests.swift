//
//  SearchViewModelTests.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 29/10/25.
//

import XCTest
@testable import HatchWorksCodeChallenge

final class SearchViewModelTests: XCTestCase {

    func test_search() throws {
        let sut = SearchViewModel(repository: MockItemRepository())
        sut.searchText = "Text"
        let expectation = expectation(description: "Search")

        sut.search()

        withObservationTracking {
            _ = sut.videoItems
        } onChange: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(sut.videoItems.count, 2)
    }

    func test_searchEmpty() throws {
        let sut = SearchViewModel(repository: MockItemRepository())

        sut.search()

        XCTAssertEqual(sut.videoItems.count, 0)
    }

    func test_loadMoreItems() throws {
        let sut = SearchViewModel(repository: MockItemRepository())

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
        let sut = SearchViewModel(repository: MockItemRepository())
        sut.list = BaseVideoList(page: 1,
                                 totalPages: 10,
                                 totalResults: 20,
                                 videoItems: [])

        XCTAssertFalse(sut.enableLoadMoreItems)

        sut.videoItems = [VideoItem(id: 1), VideoItem(id: 2)]

        XCTAssertTrue(sut.enableLoadMoreItems)
    }
}
