//
//  ItemDetailViewModelTests.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 29/10/25.
//

import XCTest
import SwiftData
@testable import HatchWorksCodeChallenge

final class ItemDetailViewModelTests: XCTestCase {

    @MainActor
    func test_getData_VideoItemWithGenres() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Genre.self, configurations: config)

        let videoItem = VideoItem(id: 1)
        videoItem.genres = [1]
        let sut = ItemDetailViewModel(repository: MockItemRepository(), item: videoItem, categoryType: .movie)

        let expectation = expectation(description: "Get data")

        sut.getData(with: container.mainContext)

        withObservationTracking {
            _ = sut.genres
        } onChange: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(sut.genres.count, 1)
    }

    @MainActor
    func test_getData_VideoItemWithoutGenres() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Genre.self, configurations: config)

        let videoItem = VideoItem(id: 1)
        let sut = ItemDetailViewModel(repository: MockItemRepository(), item: videoItem, categoryType: .movie)

        sut.getData(with: container.mainContext)

        XCTAssertEqual(sut.genres.count, 0)
    }

    @MainActor
    func test_genresText() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Genre.self, configurations: config)

        let videoItem = VideoItem(id: 1)
        videoItem.genres = [2, 3]
        let sut = ItemDetailViewModel(repository: MockItemRepository(), item: videoItem, categoryType: .tv)

        let expectation = expectation(description: "Get data")

        sut.getData(with: container.mainContext)

        withObservationTracking {
            _ = sut.genres
        } onChange: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(sut.genres.count, 2)
        XCTAssertEqual(sut.genresText, "Genre 2 • Genre 3")
    }
}
