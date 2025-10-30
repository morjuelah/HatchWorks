//
//  ItemsRepositoryTests.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 29/10/25.
//

import XCTest
import SwiftData
@testable import HatchWorksCodeChallenge

final class ItemsRepositoryTests: XCTestCase {

    @MainActor
    func test_getLists_Success() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CategoryList.self, configurations: config)

        let sut = ItemsRepository(service: MockService())
        sut.modelContext = container.mainContext

        let lists = try await sut.getLists()

        XCTAssertTrue(!lists.isEmpty)
        XCTAssertEqual(lists.count, ItemCategory.allCases.count)
        XCTAssertEqual(lists.first?.videoItems.count, 20)
    }

    @MainActor
    func test_getLists_Failure() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CategoryList.self, configurations: config)

        let sut = ItemsRepository(service: MockServiceFailure())
        sut.modelContext = container.mainContext

        do {
            let _ = try await sut.getLists()
            XCTFail()
        } catch {
            XCTAssertEqual(error as? ServiceError, ServiceError.default)
        }
    }

    @MainActor
    func test_getMoreItems_Success() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CategoryList.self, configurations: config)

        let sut = ItemsRepository(service: MockService())
        sut.modelContext = container.mainContext

        let lists = try await sut.getLists()

        if let list = lists.first {
            let newItems = try await sut.getMoreItems(for: list)

            XCTAssertEqual(newItems.count, 20)
            XCTAssertEqual(list.videoItems.count, 40)
        } else {
            XCTFail()
        }
    }

    @MainActor
    func test_getItemGenres_Success() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Genre.self, configurations: config)

        let sut = ItemsRepository(service: MockService())
        sut.modelContext = container.mainContext

        let genres = try await sut.getItemGenres()

        XCTAssertTrue(!genres.isEmpty)
        XCTAssertEqual(genres.count, 20)
    }

    @MainActor
    func test_getItemGenres_Failure() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Genre.self, configurations: config)

        let sut = ItemsRepository(service: MockServiceFailure())
        sut.modelContext = container.mainContext

        do {
            let _ = try await sut.getItemGenres()
            XCTFail()
        } catch {
            XCTAssertEqual(error as? ServiceError, ServiceError.default)
        }
    }

    @MainActor
    func test_searchText_Success() async throws {
        let sut = ItemsRepository(service: MockService())

        let videoList = try await sut.searchText(for: .movie, searchText: "Search", page: 1)

        XCTAssertEqual(videoList.videoItems.count, 20)
    }

    @MainActor
    func test_searchText_Failure() async throws {
        let sut = ItemsRepository(service: MockServiceFailure())

        do {
            let _ = try await sut.searchText(for: .movie, searchText: "Search", page: 1)
            XCTFail()
        } catch {
            XCTAssertEqual(error as? ServiceError, ServiceError.default)
        }
    }
}
