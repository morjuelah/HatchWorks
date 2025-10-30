//
//  ItemsListViewModelTests.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 29/10/25.
//

import XCTest
import SwiftData
@testable import HatchWorksCodeChallenge

final class ItemsListViewModelTests: XCTestCase {

    @MainActor
    func test_getData() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CategoryList.self, configurations: config)
        let sut = ItemsListViewModel(repository: MockItemRepository())
        let expectation = expectation(description: "Get data")

        sut.getData(with: container.mainContext)

        withObservationTracking {
            _ = sut.lists
        } onChange: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(sut.lists.count, 2)
    }

    @MainActor
    func test_filteredLists() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CategoryList.self, configurations: config)
        let sut = ItemsListViewModel(repository: MockItemRepository())
        let expectation = expectation(description: "Get data")

        sut.categorySelected = .movie
        sut.getData(with: container.mainContext)

        withObservationTracking {
            _ = sut.lists
        } onChange: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(sut.filteredLists.count, 1)

        sut.categorySelected = .tv

        XCTAssertEqual(sut.filteredLists.count, 1)
    }
}
